//
//  OkidokiLabel.m
//
//  Created by HaoCold on 2026-06-26
//  Copyright © 2026年 HaoCold. All rights reserved.
//
//  MIT License

#import "OkidokiLabel.h"

@implementation OkidokiLabel

// MARK: - Setter

- (void)setTextInsets:(UIEdgeInsets)textInsets {
    _textInsets = textInsets;
    [self invalidateIntrinsicContentSize];
}

#ifdef DEBUG
- (void)setDebugBorder:(BOOL)debugBorder {
    _debugBorder = debugBorder;
    [self setNeedsDisplay];
}
#endif

// MARK: - RTL 适配

/// 将语义 insets 转换为当前布局方向下的物理 insets。
- (UIEdgeInsets)resolvedInsets {
    if ([UIView userInterfaceLayoutDirectionForSemanticContentAttribute:self.semanticContentAttribute] == UIUserInterfaceLayoutDirectionRightToLeft) {
        // RTL：left(leading) ↔ right(trailing) 互换
        return UIEdgeInsetsMake(_textInsets.top,
                                _textInsets.right,
                                _textInsets.bottom,
                                _textInsets.left);
    }
    return _textInsets;
}

// MARK: - Overrides

- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, [self resolvedInsets])];
}

/// Auto Layout 感知：intrinsicContentSize 加上 insets。
- (CGSize)intrinsicContentSize {
    CGSize s = [super intrinsicContentSize];
    s.width  += _textInsets.left + _textInsets.right;
    s.height += _textInsets.top  + _textInsets.bottom;
    return s;
}

/// sizeToFit / sizeThatFits 感知：先缩减可用区域再加回 insets。
- (CGSize)sizeThatFits:(CGSize)size {
    UIEdgeInsets ins = [self resolvedInsets];
    CGSize inner = CGSizeMake(MAX(0, size.width  - ins.left - ins.right),
                              MAX(0, size.height - ins.top  - ins.bottom));
    CGSize s = [super sizeThatFits:inner];
    s.width  += ins.left + ins.right;
    s.height += ins.top  + ins.bottom;
    return s;
}

// MARK: - Debug

#ifdef DEBUG
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (!_debugBorder) { return; }

    CGContextRef ctx = UIGraphicsGetCurrentContext();
    if (!ctx) { return; }

    UIEdgeInsets ins = [self resolvedInsets];
    CGRect textRect = UIEdgeInsetsInsetRect(rect, ins);

    CGContextSaveGState(ctx);

    // 半透明红色填充：insets 区域
    CGContextSetFillColorWithColor(ctx, [[UIColor systemRedColor] colorWithAlphaComponent:0.18].CGColor);
    // top
    CGContextFillRect(ctx, CGRectMake(CGRectGetMinX(rect), CGRectGetMinY(rect),
                                      CGRectGetWidth(rect), ins.top));
    // bottom
    CGContextFillRect(ctx, CGRectMake(CGRectGetMinX(rect), CGRectGetMaxY(rect) - ins.bottom,
                                      CGRectGetWidth(rect), ins.bottom));
    // left（top/bottom 之间）
    CGContextFillRect(ctx, CGRectMake(CGRectGetMinX(rect), CGRectGetMinY(rect) + ins.top,
                                      ins.left, CGRectGetHeight(rect) - ins.top - ins.bottom));
    // right
    CGContextFillRect(ctx, CGRectMake(CGRectGetMaxX(rect) - ins.right, CGRectGetMinY(rect) + ins.top,
                                      ins.right, CGRectGetHeight(rect) - ins.top - ins.bottom));

    // 蓝色实线：文字绘制区域
    CGContextSetStrokeColorWithColor(ctx, [UIColor systemBlueColor].CGColor);
    CGContextSetLineWidth(ctx, 1.0);
    CGContextStrokeRect(ctx, CGRectInset(textRect, 0.5, 0.5));

    // 红色虚线：标签边界
    CGFloat dash[] = {4.0, 2.0};
    CGContextSetStrokeColorWithColor(ctx, [UIColor systemRedColor].CGColor);
    CGContextSetLineWidth(ctx, 1.0);
    CGContextSetLineDash(ctx, 0, dash, 2);
    CGContextStrokeRect(ctx, CGRectInset(rect, 0.5, 0.5));

    CGContextRestoreGState(ctx);
}
#endif

@end
