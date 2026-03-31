//
//  Okidoki.m
//  JHKit
//
//  Created by HaoCold on 2018/9/19.
//  Copyright © 2018年 HaoCold. All rights reserved.
//
//  MIT License
//
//  Copyright (c) 2018 xjh093
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

#import "Okidoki.h"
#import <objc/runtime.h>

static CGFloat Okidoki_scale;
static CGFloat Okidoki_width;

CGFloat Okidoki_NumberAdaptor(CGFloat number)
{
    if (number == 0 || number == CGFLOAT_MAX || number == -CGFLOAT_MAX) {
        return number;
    }
    
    Okidoki_scale = [UIScreen mainScreen].scale;
    Okidoki_width = [UIScreen mainScreen].bounds.size.width;
    
    number = number * Okidoki_width / 375.0;
    CGFloat _scale = Okidoki_scale;
    
    // 因为设备点转化为像素时，如果偏移了半个像素点就有可能会产生虚化的效果，因此这里要将设备点先转化为像素点，然后再添加0.5个偏移取整后再除以倍数则是转化为有效的设备逻辑点。
#if CGFLOAT_IS_DOUBLE == 1
    if (number < 0)
        return ceil(fma(number, _scale, -0.5)) / _scale;
    else
        return floor(fma(number, _scale, 0.5)) / _scale;
#else
    if (number < 0)
        return ceilf(fmaf(number, _scale, -0.5f)) / _scale;
    else
        return floorf(fmaf(number, _scale, 0.5f)) / _scale;
#endif
}

#define kOkidoki_imp(sel,imp) \
- (Okidoki*(^)(id))sel{ \
    return ^id(id sel){ \
        UIView *view = self.view; \
        do { \
            imp; \
        } while (0); \
        return view.okidoki; \
    }; \
}

@interface Okidoki ()
@property (nonatomic,    weak) UIView *view;
@end

@implementation Okidoki

#pragma mark - UIView

kOkidoki_imp(tag, ({
    if ([tag isKindOfClass:[NSNumber class]] ||
        [tag isKindOfClass:[NSString class]]) {
        view.tag = [tag integerValue];
    }
}))

kOkidoki_imp(frame, ({
    if ([frame isKindOfClass:[NSValue class]]) {
        view.frame = [frame CGRectValue];
    }else if ([frame isKindOfClass:[NSString class]]) {
        view.frame = CGRectFromString(frame);
    }
}))

kOkidoki_imp(alpha, ({
    if ([alpha isKindOfClass:[NSNumber class]] ||
        [alpha isKindOfClass:[NSString class]]) {
        view.alpha = [alpha floatValue];
    }
}))
    
kOkidoki_imp(hidden, ({
    if ([hidden isKindOfClass:[NSNumber class]] ||
        [hidden isKindOfClass:[NSString class]]) {
        view.hidden = [hidden boolValue];
    }
}))

kOkidoki_imp(bgColor, ({
    view.backgroundColor = [UIColor okidokiColor:bgColor];
}))

kOkidoki_imp(bdColor, ({
    view.layer.borderColor = [[UIColor okidokiColor:bdColor] CGColor];
}))

kOkidoki_imp(bdWidth, ({
    if([bdWidth isKindOfClass:[NSNumber class]] ||
       [bdWidth isKindOfClass:[NSString class]]){
        view.layer.borderWidth = [bdWidth floatValue];
    }
}))

kOkidoki_imp(cnRadius, ({
    if([cnRadius isKindOfClass:[NSNumber class]] ||
       [cnRadius isKindOfClass:[NSString class]]){
        view.layer.cornerRadius = [cnRadius floatValue];
    }
}))

kOkidoki_imp(mkCorners, ({
    if([mkCorners isKindOfClass:[NSArray class]] &&
       [mkCorners count] > 0){
        CACornerMask mask = 0;
        if ([mkCorners containsObject:@1]) {
            mask |= kCALayerMinXMinYCorner;
        }
        if ([mkCorners containsObject:@2]) {
            mask |= kCALayerMaxXMinYCorner;
        }
        if ([mkCorners containsObject:@3]) {
            mask |= kCALayerMaxXMaxYCorner;
        }
        if ([mkCorners containsObject:@4]) {
            mask |= kCALayerMinXMaxYCorner;
        }
        
        if (mask > 0) {
            view.layer.maskedCorners = mask;
        }
    }
}))

kOkidoki_imp(mtBounds, ({
    if([mtBounds isKindOfClass:[NSNumber class]] ||
       [mtBounds isKindOfClass:[NSString class]]){
        view.layer.masksToBounds = [mtBounds boolValue];
    }
}))

kOkidoki_imp(shadowColor, ({
    UIColor *color = [UIColor okidokiColor:shadowColor];
    if (color) {
        view.layer.shadowColor = color.CGColor;
    }
}))

kOkidoki_imp(shadowOpacity, ({
    if([shadowOpacity isKindOfClass:[NSNumber class]] ||
       [shadowOpacity isKindOfClass:[NSString class]]){
        view.layer.shadowOpacity = [shadowOpacity floatValue];
    }
}))

kOkidoki_imp(shadowOffset, ({
    if ([shadowOffset isKindOfClass:[NSValue class]]) {
        view.layer.shadowOffset = [shadowOffset CGSizeValue];
    }else if ([shadowOffset isKindOfClass:[NSString class]]) {
        view.layer.shadowOffset = CGSizeFromString(shadowOffset);
    }
}))

kOkidoki_imp(shadowRadius, ({
    if([shadowRadius isKindOfClass:[NSNumber class]] ||
       [shadowRadius isKindOfClass:[NSString class]]){
        view.layer.shadowRadius = [shadowRadius floatValue];
    }
}))

kOkidoki_imp(shadowPath, ({
    if ([shadowPath isKindOfClass:[UIBezierPath class]]) {
        view.layer.shadowPath = [(UIBezierPath *)shadowPath CGPath];
    }else if (CFGetTypeID((__bridge CFTypeRef)shadowPath) == CGPathGetTypeID()) {
        view.layer.shadowPath = (__bridge CGPathRef)shadowPath;
    }
}))

kOkidoki_imp(addSubview, ({
    if ([addSubview isKindOfClass:[UIView class]]) {
        [view addSubview:(UIView *)addSubview];
    }
}))

kOkidoki_imp(addToSuperview, ({
    if ([addToSuperview isKindOfClass:[UIView class]]) {
        [(UIView *)addToSuperview addSubview:view];
    }
}))

kOkidoki_imp(userInteractionEnabled, ({
    if ([userInteractionEnabled isKindOfClass:[NSNumber class]] ||
        [userInteractionEnabled isKindOfClass:[NSString class]]) {
        view.userInteractionEnabled = [userInteractionEnabled boolValue];
    }
}))


#pragma mark - UILabel

kOkidoki_imp(highlightedTextColor, ({
    if ([view isKindOfClass:[UILabel class]]) {
        UIColor *color = [UIColor okidokiColor:highlightedTextColor];
        if (color) {
            [(UILabel *)view setHighlightedTextColor:color];
        }
    }
}))

kOkidoki_imp(text, ({
    if([text isKindOfClass:[NSString class]]){
        if ([view respondsToSelector:@selector(setText:)]) {
            [view performSelector:@selector(setText:) withObject:text];
        }
    }
}))

kOkidoki_imp(font, ({
    if ([font isKindOfClass:[UIFont class]] ||
        [font isKindOfClass:[NSString class]]) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            button.titleLabel.font = [UIFont okidokiFont:font];
        }else if ([view respondsToSelector:@selector(setFont:)]) {
            [view performSelector:@selector(setFont:) withObject:[UIFont okidokiFont:font]];
        }
    }
}))

kOkidoki_imp(color, ({
    if ([view isKindOfClass:[UIButton class]]) {
        UIButton *button = (UIButton *)view;
        [button setTitleColor:[UIColor okidokiColor:color] forState:0];
    }else if([view respondsToSelector:@selector(setTextColor:)]){
        [view performSelector:@selector(setTextColor:) withObject:[UIColor okidokiColor:color]];
    }
}))

kOkidoki_imp(align, ({
    if([align isKindOfClass:[NSNumber class]] ||
       [align isKindOfClass:[NSString class]]){
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            button.titleLabel.textAlignment = [align integerValue];
        }else if([view respondsToSelector:@selector(setTextAlignment:)]){
            [view setValue:align forKey:@"textAlignment"];
        }
    }
}))

kOkidoki_imp(lines, ({
    if(([lines isKindOfClass:[NSNumber class]] ||
        [lines isKindOfClass:[NSString class]])){
        if ([view isKindOfClass:[UILabel class]]) {
            [(UILabel *)view setNumberOfLines:[lines integerValue]];
        }else if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            button.titleLabel.numberOfLines = [lines integerValue];
        }
    }
}))

kOkidoki_imp(adjust, ({
    if(([adjust isKindOfClass:[NSNumber class]] ||
        [adjust isKindOfClass:[NSString class]])){
       if ([view isKindOfClass:[UILabel class]]) {
           [(UILabel *)view setAdjustsFontSizeToFitWidth:[adjust boolValue]];
       }else if ([view isKindOfClass:[UIButton class]]) {
           UIButton *button = (UIButton *)view;
           button.titleLabel.adjustsFontSizeToFitWidth = [adjust integerValue];
       }
    }
}))

kOkidoki_imp(lineSpace, ({
    if([view isKindOfClass:[UILabel class]] &&
       ([lineSpace isKindOfClass:[NSNumber class]] ||
        [lineSpace isKindOfClass:[NSString class]])){
        UILabel *label = (UILabel *)view;
        CGFloat space = [lineSpace floatValue];
        
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithAttributedString:label.attributedText?:[[NSAttributedString alloc] initWithString:label.text]];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:space < 0 ? 0 : (space - (label.font.lineHeight - label.font.pointSize))];
        paragraphStyle.alignment = label.textAlignment;
        [attStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [label.text length])];
        label.attributedText = attStr;
    }
}))

kOkidoki_imp(autoWidth, ({
    if([view isKindOfClass:[UILabel class]]){
    
        UILabel *label = (UILabel *)view;
        CGFloat height = CGRectGetHeight(label.frame);
        
        CGRect frame = label.frame;
        label.numberOfLines = 1;
        [label sizeToFit];
        
        if ([autoWidth floatValue] > 0 &&
            label.frame.size.width > [autoWidth floatValue])
        {
            frame.size.width = [autoWidth floatValue];
        }else{
            frame.size.width = label.frame.size.width;
        }
        frame.size.height = height;
        label.frame = frame;
    }
}))

kOkidoki_imp(autoHeight, ({
    if([view isKindOfClass:[UILabel class]]){
        
        UILabel *label = (UILabel *)view;
        
        CGRect frame = label.frame;
        label.numberOfLines = 0;
        [label sizeToFit];
        
        if ([autoHeight floatValue] > 0 &&
            label.frame.size.height > [autoHeight floatValue]) {
            frame.size.height = [autoHeight floatValue];
        }else{
            frame.size.height = label.frame.size.height;
        }
        label.frame = frame;
    }
}))

- (Okidoki*(^)(id,id))attributedSubstring{
    return ^id(id string, id value){
        UIView *view = self.view;
        
        if ([view respondsToSelector:@selector(attributedText)]) {
            
            NSString *text = [view performSelector:@selector(text)];
            NSAttributedString *attributedText = [view performSelector:@selector(attributedText)];
            if (!attributedText) {
                attributedText = [[NSAttributedString alloc] initWithString:text];
            }
            
            // color
            if ([value isKindOfClass:[UIColor class]]) {
                NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithAttributedString:attributedText];
                [attStr addAttribute:NSForegroundColorAttributeName value:value range:[text rangeOfString:string]];
                [view performSelector:@selector(setAttributedText:) withObject:attStr];
            }
            // font
            else if ([value isKindOfClass:[UIFont class]]){
                NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithAttributedString:attributedText];
                [attStr addAttribute:NSFontAttributeName value:value range:[text rangeOfString:string]];
                [view performSelector:@selector(setAttributedText:) withObject:attStr];
            }
        }
        
        return view.okidoki;
    };
}

- (Okidoki*(^)(id,id,id))attributedSubstringInRange{
    return ^id(id string, id value, id range){
        UIView *view = self.view;
        
        if ([view respondsToSelector:@selector(attributedText)]) {
            
            NSString *text = [view performSelector:@selector(text)];
            NSAttributedString *attributedText = [view performSelector:@selector(attributedText)];
            if (!attributedText) {
                attributedText = [[NSAttributedString alloc] initWithString:text];
            }
            
            // color
            if ([value isKindOfClass:[UIColor class]] &&
                [range isKindOfClass:[NSValue class]]) {
                NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithAttributedString:attributedText];
                [attStr addAttribute:NSForegroundColorAttributeName value:value range:[range rangeValue]];
                [view performSelector:@selector(setAttributedText:) withObject:attStr];
            }
            // font
            else if ([value isKindOfClass:[UIFont class]] &&
                     [range isKindOfClass:[NSValue class]]){
                NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithAttributedString:attributedText];
                [attStr addAttribute:NSFontAttributeName value:value range:[range rangeValue]];
                [view performSelector:@selector(setAttributedText:) withObject:attStr];
            }
        }
        
        return view.okidoki;
    };
}

- (Okidoki*(^)(id,id,id))attributedSubstringKeyValue{
    return ^id(id string, id key, id value){
        UIView *view = self.view;
        if ([view respondsToSelector:@selector(attributedText)]) {
            NSString *text = [view performSelector:@selector(text)];
            NSMutableAttributedString *attr = [[view performSelector:@selector(attributedText)] mutableCopy];
            if (attr.string.length == 0) {
                attr = [[NSMutableAttributedString alloc] initWithString:text];
            }
            if (attr.string.length > 0) {
                [attr addAttribute:key value:value range:[attr.string rangeOfString:string]];
                [view performSelector:@selector(setAttributedText:) withObject:attr];
            }
        }
        return view.okidoki;
    };
}

- (Okidoki*(^)(id,id,id,id))attributedSubstringKeyValueInRange{
    return ^id(id string, id key, id value, id range){
        UIView *view = self.view;
        if ([view respondsToSelector:@selector(attributedText)]) {
            NSString *text = [view performSelector:@selector(text)];
            NSMutableAttributedString *attr = [[view performSelector:@selector(attributedText)] mutableCopy];
            if (attr.string.length == 0) {
                attr = [[NSMutableAttributedString alloc] initWithString:text];
            }
            if (attr.string.length > 0) {
                [attr addAttribute:key value:value range:[range rangeValue]];
                [view performSelector:@selector(setAttributedText:) withObject:attr];
            }
        }
        return view.okidoki;
    };
}

#pragma mark - UIControl

kOkidoki_imp(enabled, ({
    if ([view isKindOfClass:[UIControl class]]) {
        if ([enabled isKindOfClass:[NSNumber class]] ||
            [enabled isKindOfClass:[NSString class]]) {
            [(UIControl *)view setEnabled:[enabled boolValue]];
        }
    }
}))

kOkidoki_imp(selected, ({
    if ([view isKindOfClass:[UIControl class]]) {
        if ([selected isKindOfClass:[NSNumber class]] ||
            [selected isKindOfClass:[NSString class]]) {
            [(UIControl *)view setSelected:[selected boolValue]];
        }
    }
}))

kOkidoki_imp(highlighted, ({
    if ([highlighted isKindOfClass:[NSNumber class]] ||
        [highlighted isKindOfClass:[NSString class]]) {
        BOOL isHighlighted = [highlighted boolValue];
                
        if ([view respondsToSelector:@selector(setHighlighted:)]) {
            // UILabel, UIImageView, UIControl
            [(UIControl *)view setHighlighted:isHighlighted];
        }
    }
}))

kOkidoki_imp(contentVerticalAlignment, ({
    if ([view isKindOfClass:[UIControl class]]) {
        if ([contentVerticalAlignment isKindOfClass:[NSNumber class]] ||
            [contentVerticalAlignment isKindOfClass:[NSString class]]) {
            [(UIControl *)view setContentVerticalAlignment:[contentVerticalAlignment integerValue]];
        }
    }
}))

kOkidoki_imp(contentHorizontalAlignment, ({
    if ([view isKindOfClass:[UIControl class]]) {
        if ([contentHorizontalAlignment isKindOfClass:[NSNumber class]] ||
            [contentHorizontalAlignment isKindOfClass:[NSString class]]) {
            [(UIControl *)view setContentHorizontalAlignment:[contentHorizontalAlignment integerValue]];
        }
    }
}))

#pragma mark - UIButton

kOkidoki_imp(title, ({
    if ([view isKindOfClass:[UIButton class]] &&
        [title isKindOfClass:[NSString class]]) {
        [(UIButton *)view setTitle:title forState:0];
    }
}))

- (Okidoki*(^)(id,id))titleForState{
    return ^id(id title, id state){
        UIView *view = self.view;
        
        if ([view isKindOfClass:[UIButton class]] &&
            [title isKindOfClass:[NSString class]] &&
            [state isKindOfClass:[NSNumber class]]) {
            [(UIButton *)view setTitle:title forState:[state integerValue]];
        }
        
        return view.okidoki;
    };
}

- (Okidoki*(^)(id,id))colorForState{
    return ^id(id color, id state){
        UIView *view = self.view;
        
        if ([view isKindOfClass:[UIButton class]]&&
            [state isKindOfClass:[NSNumber class]]) {
            [(UIButton *)view setTitleColor:[UIColor okidokiColor:color] forState:[state integerValue]];
        }
        
        return view.okidoki;
    };
}

- (Okidoki*(^)(id,id))imageForState{
    return ^id(id image, id state){
        UIView *view = self.view;
        
        if ([view isKindOfClass:[UIButton class]] &&
            [state isKindOfClass:[NSNumber class]]) {
            if ([image isKindOfClass:[NSString class]]) {
                [(UIButton *)view setImage:[UIImage imageNamed:image] forState:[state integerValue]];
            }else if ([image isKindOfClass:[UIImage class]]) {
                [(UIButton *)view setImage:image forState:[state integerValue]];
            }
        }
        
        return view.okidoki;
    };
}

- (Okidoki*(^)(id,id))bgImageForState{
    return ^id(id bgImage, id state){
        UIView *view = self.view;
        
        if ([view isKindOfClass:[UIButton class]] &&
            [state isKindOfClass:[NSNumber class]]) {
            if ([bgImage isKindOfClass:[NSString class]]) {
                [(UIButton *)view setBackgroundImage:[UIImage imageNamed:bgImage] forState:[state integerValue]];
            }else if ([bgImage isKindOfClass:[UIImage class]]) {
                [(UIButton *)view setBackgroundImage:bgImage forState:[state integerValue]];
            }
        }
        
        return view.okidoki;
    };
}

- (Okidoki*(^)(id,id))lineSpaceForState{
    return ^id(id lineSpace, id state){
        UIView *view = self.view;
        
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            CGFloat space = [lineSpace integerValue];
            
            NSAttributedString *attributedString = [button attributedTitleForState:[state integerValue]]?:[[NSAttributedString alloc] initWithString:button.currentTitle];
            NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithAttributedString:attributedString];
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            [paragraphStyle setLineSpacing:space < 0 ? 0 : (space - (button.titleLabel.font.lineHeight - button.titleLabel.font.pointSize))];
            paragraphStyle.alignment = button.titleLabel.textAlignment;
            [attStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attStr.string length])];
            [button setAttributedTitle:attStr forState:[state integerValue]];
        }
        
        return view.okidoki;
    };
}

- (Okidoki*(^)(id))imageUpTitleDown{
    return ^id(id offsetY){
        UIView *view = self.view;
        
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            CGFloat Y = [offsetY floatValue];
            
            [button layoutSubviews];
            [button setImageEdgeInsets:UIEdgeInsetsMake(-button.titleLabel.intrinsicContentSize.height-Y,0,0,-button.titleLabel.intrinsicContentSize.width)];
            [button setTitleEdgeInsets:UIEdgeInsetsMake(0,-CGRectGetWidth(button.imageView.frame),-CGRectGetHeight(button.imageView.frame)-Y,0)];
            
        }
        
        return view.okidoki;
    };
}

- (Okidoki*(^)(id))imageDownTitleUp{
    return ^id(id offsetY){
        UIView *view = self.view;
        
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            CGFloat Y = [offsetY floatValue];
            
            [button layoutSubviews];
            [button setImageEdgeInsets:UIEdgeInsetsMake(button.titleLabel.intrinsicContentSize.height+Y,0,0,-button.titleLabel.intrinsicContentSize.width)];
            [button setTitleEdgeInsets:UIEdgeInsetsMake(-CGRectGetWidth(button.imageView.frame)-Y,-CGRectGetWidth(button.imageView.frame),0,0)];
            
        }
        
        return view.okidoki;
    };
}

- (Okidoki*(^)(id))imageRightTitleLeft{
    return ^id(id offsetX){
        UIView *view = self.view;
        
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            CGFloat X = [offsetX floatValue];
            
            [button layoutSubviews];
            [button setImageEdgeInsets:UIEdgeInsetsMake(0,0,0,-button.titleLabel.intrinsicContentSize.width*2-X)];
            [button setTitleEdgeInsets:UIEdgeInsetsMake(0,-button.imageView.frame.size.width*2-X,0,0)];
            
        }
        
        return view.okidoki;
    };
}

- (Okidoki*(^)(id))imageLeftTitleRight{
    return ^id(id offsetX){
        UIView *view = self.view;
        
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            CGFloat X = [offsetX floatValue];
            
            [button layoutSubviews];
            [button setImageEdgeInsets:UIEdgeInsetsMake(0,0,0,X)];
            [button setTitleEdgeInsets:UIEdgeInsetsMake(0,X,0,0)];
            
        }
        
        return view.okidoki;
    };
}

- (Okidoki*(^)(void))imageCenterTitleCenter{
    return ^id(){
        UIView *view = self.view;
        
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            
            [button layoutSubviews];
            [button setImageEdgeInsets:UIEdgeInsetsMake(0,0,0,-button.titleLabel.intrinsicContentSize.width)];
            [button setTitleEdgeInsets:UIEdgeInsetsMake(0,-button.imageView.frame.size.width,0,0)];
            
        }
        
        return view.okidoki;
    };
}

- (Okidoki*(^)(id,id,id))attributedSubstringForState{
    return ^id(id substring, id value, id state){
        UIView *view = self.view;
        
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            
            // color
            if ([value isKindOfClass:[UIColor class]]) {
                NSAttributedString *attributedString = [button attributedTitleForState:[state integerValue]]?:[[NSAttributedString alloc] initWithString:button.currentTitle];
                NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithAttributedString:attributedString];
                [attStr addAttribute:NSForegroundColorAttributeName value:value range:[attributedString.string rangeOfString:substring]];
                [button setAttributedTitle:attStr forState:[state integerValue]];
            }
            // font
            else if ([value isKindOfClass:[UIFont class]]){
                NSAttributedString *attributedString = [button attributedTitleForState:[state integerValue]]?:[[NSAttributedString alloc] initWithString:button.currentTitle];
                NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithAttributedString:attributedString];
                [attStr addAttribute:NSFontAttributeName value:value range:[attributedString.string rangeOfString:substring]];
                [button setAttributedTitle:attStr forState:[state integerValue]];
            }
        }
        
        return view.okidoki;
    };
}

- (Okidoki*(^)(id,id,id,id))attributedSubstringInRangeForState{
    return ^id(id substring, id value, id range, id state){
        UIView *view = self.view;
        
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            
            // color
            if ([value isKindOfClass:[UIColor class]] &&
                [range isKindOfClass:[NSValue class]]) {
                NSAttributedString *attributedString = [button attributedTitleForState:[state integerValue]]?:[[NSAttributedString alloc] initWithString:button.currentTitle];
                NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithAttributedString:attributedString];
                [attStr addAttribute:NSForegroundColorAttributeName value:value range:[range rangeValue]];
                [button setAttributedTitle:attStr forState:[state integerValue]];
            }
            // font
            else if ([value isKindOfClass:[UIFont class]] &&
                     [range isKindOfClass:[NSValue class]]){
                NSAttributedString *attributedString = [button attributedTitleForState:[state integerValue]]?:[[NSAttributedString alloc] initWithString:button.currentTitle];
                NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithAttributedString:attributedString];
                [attStr addAttribute:NSFontAttributeName value:value range:[range rangeValue]];
                [button setAttributedTitle:attStr forState:[state integerValue]];
            }
        }
        
        return view.okidoki;
    };
}

- (Okidoki*(^)(id,id,id,id))attributedSubstringKeyValueForState{
    return ^id(id string, id key, id value, id state){
        UIView *view = self.view;
        
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            
            NSAttributedString *attr = [button attributedTitleForState:[state integerValue]];
            if (!attr) {
                attr = [[NSAttributedString alloc] initWithString:button.titleLabel.text];
            }
            
            NSMutableAttributedString *mattr = attr.mutableCopy;
            if (mattr.string.length > 0) {
                [mattr addAttribute:key value:value range:[mattr.string rangeOfString:string]];
                [button setAttributedTitle:mattr forState:[state integerValue]];
            }
        }
        return view.okidoki;
    };
}

- (Okidoki*(^)(id,id,id,id,id))attributedSubstringKeyValueInRangeForState{
    return ^id(id string, id key, id value, id range, id state){
        UIView *view = self.view;
        
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            
            NSAttributedString *attr = [button attributedTitleForState:[state integerValue]];
            if (!attr) {
                attr = [[NSAttributedString alloc] initWithString:button.titleLabel.text];
            }
            
            NSMutableAttributedString *mattr = attr.mutableCopy;
            if (mattr.string.length > 0) {
                [mattr addAttribute:key value:value range:[range rangeValue]];
                [button setAttributedTitle:mattr forState:[state integerValue]];
            }
        }
        return view.okidoki;
    };
}

#pragma mark - UIImageView

kOkidoki_imp(image, ({
    if ([view isKindOfClass:[UIImageView class]]) {
        if ([image isKindOfClass:[NSString class]]) {
            [view performSelector:@selector(setImage:) withObject:[UIImage imageNamed:image]];
        }else if ([image isKindOfClass:[UIImage class]]){
            [view performSelector:@selector(setImage:) withObject:image];
        }
    }else if ([view isKindOfClass:[UIButton class]]) {
        UIButton *button = (UIButton *)view;
        if ([image isKindOfClass:[NSString class]]) {
            [button setImage:[UIImage imageNamed:image] forState:0];
        }else if ([image isKindOfClass:[UIImage class]]){
            [button setImage:image forState:0];
        }
    }
}))

kOkidoki_imp(highlightedImage, ({
    if ([view isKindOfClass:[UIImageView class]]) {
        UIImageView *imageView = (UIImageView *)view;
        if ([highlightedImage isKindOfClass:[NSString class]]) {
            imageView.highlightedImage = [UIImage imageNamed:highlightedImage];
        }else if ([highlightedImage isKindOfClass:[UIImage class]]){
            imageView.highlightedImage = highlightedImage;
        }
    }else if ([view isKindOfClass:[UIButton class]]) {
        UIButton *button = (UIButton *)view;
        if ([highlightedImage isKindOfClass:[NSString class]]) {
            [button setImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];
        }else if ([highlightedImage isKindOfClass:[UIImage class]]){
            [button setImage:highlightedImage forState:UIControlStateHighlighted];
        }
    }
}))

- (Okidoki*(^)(id,id))imageForTintColor{
    return ^id(id image, id color){
        UIView *view = self.view;
        
        if ([view isKindOfClass:[UIImageView class]]) {
            UIImageView *imageView = (UIImageView *)view;
            imageView.tintColor = [UIColor okidokiColor:color];
            
            if ([image isKindOfClass:[NSString class]]) {
                imageView.image = [[UIImage imageNamed:image]
                                   imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            }else if ([image isKindOfClass:[UIImage class]]){
                imageView.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            }
        }
        
        return view.okidoki;
    };
}


#pragma mark - UITextField

kOkidoki_imp(bdStyle, ({
    if ([view isKindOfClass:[UITextField class]] &&
        ([bdStyle isKindOfClass:[NSNumber class]]) ||
         [bdStyle isKindOfClass:[NSString class]]) {
        [(UITextField *)view setBorderStyle:[bdStyle integerValue]];
    }
}))

kOkidoki_imp(pHolder, ({
    if ([view isKindOfClass:[UITextField class]] &&
        [pHolder isKindOfClass:[NSString class]]) {
        [view performSelector:@selector(setPlaceholder:) withObject:pHolder];
    }
}))

kOkidoki_imp(pHColor, ({
    if ([view isKindOfClass:[UITextField class]]) {
        UITextField *t = (UITextField *)view;
        NSMutableAttributedString *attr = t.attributedPlaceholder.mutableCopy;
        if (attr.string.length == 0 && t.placeholder.length > 0) {
            attr = [[NSMutableAttributedString alloc] initWithString:t.placeholder];
        }
        if (attr.string.length > 0) {
            [attr addAttribute:NSForegroundColorAttributeName value:[UIColor okidokiColor:pHColor] range:NSMakeRange(0, attr.string.length)];
            t.attributedPlaceholder = attr;
        }
    }
}))

kOkidoki_imp(pHFont, ({
    if ([view isKindOfClass:[UITextField class]] &&
        ([pHFont isKindOfClass:[UIFont class]] ||
         [pHFont isKindOfClass:[NSString class]])) {
        UITextField *t = (UITextField *)view;
        NSMutableAttributedString *attr = t.attributedPlaceholder.mutableCopy;
        if (attr.string.length == 0 && t.placeholder.length > 0) {
            attr = [[NSMutableAttributedString alloc] initWithString:t.placeholder];
        }
        if (attr.string.length > 0) {
            [attr addAttribute:NSFontAttributeName value:[UIFont okidokiFont:pHFont] range:NSMakeRange(0, attr.string.length)];
            t.attributedPlaceholder = attr;
        }
    }
}))

kOkidoki_imp(cbMode, ({
    if ([view isKindOfClass:[UITextField class]] &&
        ([cbMode isKindOfClass:[NSNumber class]] ||
         [cbMode isKindOfClass:[NSString class]])) {
        [(UITextField *)view setClearButtonMode:[cbMode integerValue]];
    }
}))

kOkidoki_imp(lvMode, ({
    if ([view isKindOfClass:[UITextField class]] &&
        ([lvMode isKindOfClass:[NSNumber class]] ||
         [lvMode isKindOfClass:[NSString class]])) {
        [(UITextField *)view setLeftViewMode:[lvMode integerValue]];
    }
}))

kOkidoki_imp(rvMode, ({
    if ([view isKindOfClass:[UITextField class]] &&
        ([rvMode isKindOfClass:[NSNumber class]] ||
         [rvMode isKindOfClass:[NSString class]])) {
        [(UITextField *)view setRightViewMode:[rvMode integerValue]];
    }
}))

kOkidoki_imp(lfView, ({
    if ([view isKindOfClass:[UITextField class]] &&
        [lfView isKindOfClass:[UIView class]]) {
        [view performSelector:@selector(setLeftView:) withObject:lfView];
    }
}))

kOkidoki_imp(rtView, ({
    if ([view isKindOfClass:[UITextField class]] &&
        [rtView isKindOfClass:[UIView class]]) {
        [view performSelector:@selector(setRightView:) withObject:rtView];
    }
}))

kOkidoki_imp(secure, ({
    if ([view isKindOfClass:[UITextField class]] &&
        ([secure isKindOfClass:[NSNumber class]] ||
         [secure isKindOfClass:[NSString class]])) {
        [(UITextField *)view setSecureTextEntry:[secure boolValue]];
    }
}))

#pragma mark - UIScrollView

kOkidoki_imp(verInd, ({
    if ([view isKindOfClass:[UIScrollView class]]) {
        [(UIScrollView *)view setShowsVerticalScrollIndicator:[verInd boolValue]];
    }
}))

kOkidoki_imp(horInd, ({
    if ([view isKindOfClass:[UIScrollView class]]) {
        [(UIScrollView *)view setShowsHorizontalScrollIndicator:[horInd boolValue]];
    }
}))

kOkidoki_imp(paging, ({
    if ([view isKindOfClass:[UIScrollView class]]) {
        [(UIScrollView *)view setPagingEnabled:[paging boolValue]];
    }
}))

kOkidoki_imp(bounces, ({
    if ([view isKindOfClass:[UIScrollView class]]) {
        [(UIScrollView *)view setBounces:[bounces boolValue]];
    }
}))

#pragma mark - UITextView

kOkidoki_imp(editable, ({
    if ([view isKindOfClass:[UITextView class]]) {
        [(UITextView *)view setEditable:[editable boolValue]];
    }
}))

kOkidoki_imp(selectable, ({
    if ([view isKindOfClass:[UITextView class]]) {
        [(UITextView *)view setSelectable:[selectable boolValue]];
    }
}))

#pragma mark - AutoLayout Anchors

- (Okidoki*(^)(id))leadingAnchor {
    return ^id(id params) {
        UIView *view = self.view;
        view.translatesAutoresizingMaskIntoConstraints = NO;
        
        if ([params isKindOfClass:[NSArray class]]) {
            NSArray *array = (NSArray *)params;
            if (array.count > 0) {
                id toItem = array[0];
                CGFloat constant = array.count > 1 ? [array[1] floatValue] : 0;
                
                NSLayoutXAxisAnchor *toAnchor = nil;
                if ([toItem isKindOfClass:[UIView class]]) {
                    toAnchor = [(UIView *)toItem leadingAnchor];
                } else if ([toItem isKindOfClass:[NSLayoutXAxisAnchor class]]) {
                    toAnchor = (NSLayoutXAxisAnchor *)toItem;
                }
                
                if (toAnchor) {
                    [view.leadingAnchor constraintEqualToAnchor:toAnchor constant:constant].active = YES;
                }
            }
        }
        
        return view.okidoki;
    };
}

- (Okidoki*(^)(id))trailingAnchor {
    return ^id(id params) {
        UIView *view = self.view;
        view.translatesAutoresizingMaskIntoConstraints = NO;
        
        if ([params isKindOfClass:[NSArray class]]) {
            NSArray *array = (NSArray *)params;
            if (array.count > 0) {
                id toItem = array[0];
                CGFloat constant = array.count > 1 ? [array[1] floatValue] : 0;
                
                NSLayoutXAxisAnchor *toAnchor = nil;
                if ([toItem isKindOfClass:[UIView class]]) {
                    toAnchor = [(UIView *)toItem trailingAnchor];
                } else if ([toItem isKindOfClass:[NSLayoutXAxisAnchor class]]) {
                    toAnchor = (NSLayoutXAxisAnchor *)toItem;
                }
                
                if (toAnchor) {
                    [view.trailingAnchor constraintEqualToAnchor:toAnchor constant:constant].active = YES;
                }
            }
        }
        
        return view.okidoki;
    };
}

- (Okidoki*(^)(id))leftAnchor {
    return ^id(id params) {
        UIView *view = self.view;
        view.translatesAutoresizingMaskIntoConstraints = NO;
        
        if ([params isKindOfClass:[NSArray class]]) {
            NSArray *array = (NSArray *)params;
            if (array.count > 0) {
                id toItem = array[0];
                CGFloat constant = array.count > 1 ? [array[1] floatValue] : 0;
                
                NSLayoutXAxisAnchor *toAnchor = nil;
                if ([toItem isKindOfClass:[UIView class]]) {
                    toAnchor = [(UIView *)toItem leftAnchor];
                } else if ([toItem isKindOfClass:[NSLayoutXAxisAnchor class]]) {
                    toAnchor = (NSLayoutXAxisAnchor *)toItem;
                }
                
                if (toAnchor) {
                    [view.leftAnchor constraintEqualToAnchor:toAnchor constant:constant].active = YES;
                }
            }
        }
        
        return view.okidoki;
    };
}

- (Okidoki*(^)(id))rightAnchor {
    return ^id(id params) {
        UIView *view = self.view;
        view.translatesAutoresizingMaskIntoConstraints = NO;
        
        if ([params isKindOfClass:[NSArray class]]) {
            NSArray *array = (NSArray *)params;
            if (array.count > 0) {
                id toItem = array[0];
                CGFloat constant = array.count > 1 ? [array[1] floatValue] : 0;
                
                NSLayoutXAxisAnchor *toAnchor = nil;
                if ([toItem isKindOfClass:[UIView class]]) {
                    toAnchor = [(UIView *)toItem rightAnchor];
                } else if ([toItem isKindOfClass:[NSLayoutXAxisAnchor class]]) {
                    toAnchor = (NSLayoutXAxisAnchor *)toItem;
                }
                
                if (toAnchor) {
                    [view.rightAnchor constraintEqualToAnchor:toAnchor constant:constant].active = YES;
                }
            }
        }
        
        return view.okidoki;
    };
}

- (Okidoki*(^)(id))topAnchor {
    return ^id(id params) {
        UIView *view = self.view;
        view.translatesAutoresizingMaskIntoConstraints = NO;
        
        if ([params isKindOfClass:[NSArray class]]) {
            NSArray *array = (NSArray *)params;
            if (array.count > 0) {
                id toItem = array[0];
                CGFloat constant = array.count > 1 ? [array[1] floatValue] : 0;
                
                NSLayoutYAxisAnchor *toAnchor = nil;
                if ([toItem isKindOfClass:[UIView class]]) {
                    toAnchor = [(UIView *)toItem topAnchor];
                } else if ([toItem isKindOfClass:[NSLayoutYAxisAnchor class]]) {
                    toAnchor = (NSLayoutYAxisAnchor *)toItem;
                }
                
                if (toAnchor) {
                    [view.topAnchor constraintEqualToAnchor:toAnchor constant:constant].active = YES;
                }
            }
        }
        
        return view.okidoki;
    };
}

- (Okidoki*(^)(id))bottomAnchor {
    return ^id(id params) {
        UIView *view = self.view;
        view.translatesAutoresizingMaskIntoConstraints = NO;
        
        if ([params isKindOfClass:[NSArray class]]) {
            NSArray *array = (NSArray *)params;
            if (array.count > 0) {
                id toItem = array[0];
                CGFloat constant = array.count > 1 ? [array[1] floatValue] : 0;
                
                NSLayoutYAxisAnchor *toAnchor = nil;
                if ([toItem isKindOfClass:[UIView class]]) {
                    toAnchor = [(UIView *)toItem bottomAnchor];
                } else if ([toItem isKindOfClass:[NSLayoutYAxisAnchor class]]) {
                    toAnchor = (NSLayoutYAxisAnchor *)toItem;
                }
                
                if (toAnchor) {
                    [view.bottomAnchor constraintEqualToAnchor:toAnchor constant:constant].active = YES;
                }
            }
        }
        
        return view.okidoki;
    };
}

- (Okidoki*(^)(id))widthAnchor {
    return ^id(id params) {
        UIView *view = self.view;
        view.translatesAutoresizingMaskIntoConstraints = NO;
        
        if ([params isKindOfClass:[NSNumber class]]) {
            // 固定宽度
            CGFloat width = [params floatValue];
            [view.widthAnchor constraintEqualToConstant:width].active = YES;
        } else if ([params isKindOfClass:[NSArray class]]) {
            // 相对宽度
            NSArray *array = (NSArray *)params;
            if (array.count > 0) {
                id toItem = array[0];
                CGFloat multiplier = array.count > 1 ? [array[1] floatValue] : 1.0;
                CGFloat constant = array.count > 2 ? [array[2] floatValue] : 0;
                
                NSLayoutDimension *toAnchor = nil;
                if ([toItem isKindOfClass:[UIView class]]) {
                    toAnchor = [(UIView *)toItem widthAnchor];
                } else if ([toItem isKindOfClass:[NSLayoutDimension class]]) {
                    toAnchor = (NSLayoutDimension *)toItem;
                }
                
                if (toAnchor) {
                    [view.widthAnchor constraintEqualToAnchor:toAnchor multiplier:multiplier constant:constant].active = YES;
                }
            }
        }
        
        return view.okidoki;
    };
}

- (Okidoki*(^)(id))heightAnchor {
    return ^id(id params) {
        UIView *view = self.view;
        view.translatesAutoresizingMaskIntoConstraints = NO;
        
        if ([params isKindOfClass:[NSNumber class]]) {
            // 固定高度
            CGFloat height = [params floatValue];
            [view.heightAnchor constraintEqualToConstant:height].active = YES;
        } else if ([params isKindOfClass:[NSArray class]]) {
            // 相对高度
            NSArray *array = (NSArray *)params;
            if (array.count > 0) {
                id toItem = array[0];
                CGFloat multiplier = array.count > 1 ? [array[1] floatValue] : 1.0;
                CGFloat constant = array.count > 2 ? [array[2] floatValue] : 0;
                
                NSLayoutDimension *toAnchor = nil;
                if ([toItem isKindOfClass:[UIView class]]) {
                    toAnchor = [(UIView *)toItem heightAnchor];
                } else if ([toItem isKindOfClass:[NSLayoutDimension class]]) {
                    toAnchor = (NSLayoutDimension *)toItem;
                }
                
                if (toAnchor) {
                    [view.heightAnchor constraintEqualToAnchor:toAnchor multiplier:multiplier constant:constant].active = YES;
                }
            }
        }
        
        return view.okidoki;
    };
}

- (Okidoki*(^)(id))centerXAnchor {
    return ^id(id params) {
        UIView *view = self.view;
        view.translatesAutoresizingMaskIntoConstraints = NO;
        
        if ([params isKindOfClass:[NSArray class]]) {
            NSArray *array = (NSArray *)params;
            if (array.count > 0) {
                id toItem = array[0];
                CGFloat constant = array.count > 1 ? [array[1] floatValue] : 0;
                
                NSLayoutXAxisAnchor *toAnchor = nil;
                if ([toItem isKindOfClass:[UIView class]]) {
                    toAnchor = [(UIView *)toItem centerXAnchor];
                } else if ([toItem isKindOfClass:[NSLayoutXAxisAnchor class]]) {
                    toAnchor = (NSLayoutXAxisAnchor *)toItem;
                }
                
                if (toAnchor) {
                    [view.centerXAnchor constraintEqualToAnchor:toAnchor constant:constant].active = YES;
                }
            }
        }
        
        return view.okidoki;
    };
}

- (Okidoki*(^)(id))centerYAnchor {
    return ^id(id params) {
        UIView *view = self.view;
        view.translatesAutoresizingMaskIntoConstraints = NO;
        
        if ([params isKindOfClass:[NSArray class]]) {
            NSArray *array = (NSArray *)params;
            if (array.count > 0) {
                id toItem = array[0];
                CGFloat constant = array.count > 1 ? [array[1] floatValue] : 0;
                
                NSLayoutYAxisAnchor *toAnchor = nil;
                if ([toItem isKindOfClass:[UIView class]]) {
                    toAnchor = [(UIView *)toItem centerYAnchor];
                } else if ([toItem isKindOfClass:[NSLayoutYAxisAnchor class]]) {
                    toAnchor = (NSLayoutYAxisAnchor *)toItem;
                }
                
                if (toAnchor) {
                    [view.centerYAnchor constraintEqualToAnchor:toAnchor constant:constant].active = YES;
                }
            }
        }
        
        return view.okidoki;
    };
}

#pragma mark - Convenience Methods

- (Okidoki*(^)(id))edgeToSuperView {
    return ^id(id params) {
        UIView *view = self.view;
        UIView *superview = view.superview;
        
        if (!superview) {
            NSLog(@"[Okidoki AutoLayout] Warning: View has no superview for edgeToSuperView");
            return view.okidoki;
        }
        
        view.translatesAutoresizingMaskIntoConstraints = NO;
        
        CGFloat top = 0, left = 0, bottom = 0, right = 0;
        
        if (!params) {
            // 无参数，四边都为 0
            top = left = bottom = right = 0;
        } else if ([params isKindOfClass:[NSNumber class]]) {
            // NSNumber，四边相同
            CGFloat inset = [params floatValue];
            top = left = inset;
            bottom = right = -inset;
        } else if ([params isKindOfClass:[NSArray class]]) {
            // NSArray: @[@(top), @(left), @(bottom), @(right)]
            NSArray *array = (NSArray *)params;
            if (array.count >= 4) {
                top = [array[0] floatValue];
                left = [array[1] floatValue];
                bottom = [array[2] floatValue];
                right = [array[3] floatValue];
            } else if (array.count == 2) {
                // @[@(vertical), @(horizontal)]
                CGFloat vertical = [array[0] floatValue];
                CGFloat horizontal = [array[1] floatValue];
                top = vertical;
                left = horizontal;
                bottom = -vertical;
                right = -horizontal;
            } else if (array.count == 1) {
                CGFloat inset = [array[0] floatValue];
                top = left = inset;
                bottom = right = -inset;
            }
        } else if ([params isKindOfClass:[NSValue class]]) {
            // UIEdgeInsets
            UIEdgeInsets insets = [params UIEdgeInsetsValue];
            top = insets.top;
            left = insets.left;
            bottom = -insets.bottom;
            right = -insets.right;
        }
        
        [view.topAnchor constraintEqualToAnchor:superview.topAnchor constant:top].active = YES;
        [view.leadingAnchor constraintEqualToAnchor:superview.leadingAnchor constant:left].active = YES;
        [view.trailingAnchor constraintEqualToAnchor:superview.trailingAnchor constant:right].active = YES;
        [view.bottomAnchor constraintEqualToAnchor:superview.bottomAnchor constant:bottom].active = YES;
        
        return view.okidoki;
    };
}

@end

@implementation UIView (Okidoki)

- (void)setOkidoki:(Okidoki *)okidoki{
    objc_setAssociatedObject(self, @selector(okidoki), okidoki, OBJC_ASSOCIATION_RETAIN);
}

- (Okidoki *)okidoki{
    Okidoki *okidoki = objc_getAssociatedObject(self, _cmd);
    if (!okidoki) {
        okidoki = [[Okidoki alloc] init];
        [okidoki setValue:self forKey:@"view"];
        self.okidoki = okidoki;
    }
    return okidoki;
}

- (CGFloat)ok_left {
    return CGRectGetMinX(self.frame);
}

- (void)setOk_left:(CGFloat)ok_left {
    CGRect frame = self.frame;
    frame.origin.x = ok_left;
    self.frame = frame;
}

- (CGFloat)ok_top {
    return CGRectGetMinY(self.frame);
}

- (void)setOk_top:(CGFloat)ok_top {
    CGRect frame = self.frame;
    frame.origin.y = ok_top;
    self.frame = frame;
}

- (CGFloat)ok_right {
    return CGRectGetMaxX(self.frame);
}

- (void)setOk_right:(CGFloat)ok_right {
    CGRect frame = self.frame;
    
    if (frame.size.width > 0) {
        frame.origin.x = ok_right - CGRectGetWidth(frame);
    } else {
        frame.size.width = ok_right - frame.origin.x;
    }
    
    self.frame = frame;
}

- (CGFloat)ok_bottom {
    return CGRectGetMaxY(self.frame);
}

- (void)setOk_bottom:(CGFloat)ok_bottom {
    CGRect frame = self.frame;
    
    if (frame.size.height > 0) {
        frame.origin.y = ok_bottom - CGRectGetHeight(frame);
    } else {
        frame.size.height = ok_bottom - frame.origin.y;
    }
    
    self.frame = frame;
}

- (CGFloat)ok_width {
    return CGRectGetWidth(self.frame);
}

- (void)setOk_width:(CGFloat)ok_width {
    CGRect frame = self.frame;
    frame.size.width = ok_width;
    self.frame = frame;
}

- (CGFloat)ok_height {
    return CGRectGetHeight(self.frame);
}

- (void)setOk_height:(CGFloat)ok_height {
    CGRect frame = self.frame;
    frame.size.height = ok_height;
    self.frame = frame;
}

- (CGFloat)ok_centerX {
    return self.center.x;
}

- (void)setOk_centerX:(CGFloat)ok_centerX {
    CGPoint center = self.center;
    center.x = ok_centerX;
    self.center = center;
}

- (CGFloat)ok_centerY {
    return self.center.y;
}

- (void)setOk_centerY:(CGFloat)ok_centerY {
    CGPoint center = self.center;
    center.y = ok_centerY;
    self.center = center;
}

- (CGPoint)ok_origin {
    return self.frame.origin;
}

- (void)setOk_origin:(CGPoint)ok_origin {
    CGRect frame = self.frame;
    frame.origin = ok_origin;
    self.frame = frame;
}

- (CGSize)ok_size {
    return self.frame.size;
}

- (void)setOk_size:(CGSize)ok_size {
    CGRect frame = self.frame;
    frame.size = ok_size;
    self.frame = frame;
}

- (CGFloat)ok_leftRight {
    return self.frame.origin.x;
}

- (void)setOk_leftRight:(CGFloat)ok_leftRight {
    CGRect frame = self.frame;
    frame.origin.x = ok_leftRight;
    if (self.superview) {
        frame.size.width = CGRectGetWidth(self.superview.bounds) - 2*ok_leftRight;
    }
    self.frame = frame;
}

- (CGFloat)ok_topBottom {
    return self.frame.origin.y;
}

- (void)setOk_topBottom:(CGFloat)ok_topBottom {
    CGRect frame = self.frame;
    frame.origin.y = ok_topBottom;
    if (self.superview) {
        frame.size.height = CGRectGetHeight(self.superview.bounds) - 2*ok_topBottom;
    }
    self.frame = frame;
}

@end

@implementation UIColor (Okidoki)
+ (UIColor *)okidokiColor:(id)color{
    if ([color isKindOfClass:[NSString class]]){
        return [self colorWithString:color];
    }
    else if ([color isKindOfClass:[UIColor class]]){
        return color;
    }
    return [UIColor blackColor];
}

+ (UIColor *)colorWithString:(NSString *)string{
    NSString *xxStr = [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // length is 6 or 8
    if ([xxStr length] < 6){
        return [UIColor blackColor];
    }
    
    // 0x
    if ([xxStr hasPrefix:@"0x"] || [xxStr hasPrefix:@"0X"]){
        xxStr = [xxStr substringFromIndex:2];
    }
    
    // #
    if ([xxStr hasPrefix:@"#"]){
        xxStr = [xxStr substringFromIndex:1];
    }
    
    if ([xxStr length] != 6){
        return [UIColor blackColor];
    }
    
    // r, g, b
    NSRange range;
    range.location = 0;
    range.length = 2;
    // r
    NSString *rStr = [xxStr substringWithRange:range];
    // g
    range.location = 2;
    NSString *gStr = [xxStr substringWithRange:range];
    // b
    range.location = 4;
    NSString *bStr = [xxStr substringWithRange:range];
    
    //
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rStr] scanHexInt:&r];
    [[NSScanner scannerWithString:gStr] scanHexInt:&g];
    [[NSScanner scannerWithString:bStr] scanHexInt:&b];
    
    UIColor *xxColor = [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1];

    return xxColor;
}

@end

@implementation UIFont (Okidoki)

+ (UIFont *)okidokiFont:(id)font
{
    if ([font isKindOfClass:[UIFont class]]) {
        return (UIFont *)font;
    }else if ([font isKindOfClass:[NSString class]]) {
        NSString *string = (NSString *)font;
        UIFont *theFont = [UIFont systemFontOfSize:[UIFont systemFontSize]];
        if ([string floatValue] > 0) {
            theFont = [UIFont systemFontOfSize:[string floatValue]];
        }else if (string.length > 1) {
            if ([string hasPrefix:@"s"]){
                theFont =  [UIFont systemFontOfSize:[[string substringFromIndex:1] floatValue]];
            }else if ([string hasPrefix:@"b"]){
                theFont =  [UIFont boldSystemFontOfSize:[[string substringFromIndex:1] floatValue]];
            }else if ([string hasPrefix:@"i"]){
                theFont =  [UIFont italicSystemFontOfSize:[[string substringFromIndex:1] floatValue]];
            }
        }
        return theFont;
    }
    
    return [UIFont systemFontOfSize:[UIFont systemFontSize]];
}

@end
