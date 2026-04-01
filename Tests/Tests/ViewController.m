//
//  ViewController.m
//  Tests
//
//  Created by HaoCold on 2020/7/30.
//  Copyright © 2020 HaoCold. All rights reserved.
//

#import "ViewController.h"
#import "Okidoki.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    // See TestsTests.m for more infomation.


//    [self shadow_Example];
    
//    [self layout_Example:self.view];
    
    [self panAnimation_Example];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    NSLog(@"viewDidLayoutSubviews");
}

- (void)shadow_Example
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    view.userInteractionEnabled = YES;
    
    // 示例 1: 基础阴影效果
    view.okidoki
    .addToSuperview(self.view)
    .frame(@"{{30, 70}, {100, 100}}")
    .bgColor(@"#FFFFFF")
    .cnRadius(@10)
    .shadowColor(@"#000000")           // 黑色阴影
    .shadowOpacity(@0.3)                // 不透明度 30%
    .shadowOffset(@"{0, 2}")            // 向下偏移 2pt
    .shadowRadius(@4);                  // 模糊半径 4pt

    // 示例 2: 卡片阴影效果
    UIView *card = [[UIView alloc] init];
    card.okidoki
    .addToSuperview(self.view)
    .frame(@"{{170, 70}, {200, 100}}")
    .bgColor(@"#FFFFFF")
    .cnRadius(@8)
    .shadowColor(@"#333333")
    .shadowOpacity(@0.15)
    .shadowOffset(@"{0, 4}")
    .shadowRadius(@12);

    // 示例 3: 浮起效果（大阴影）
    UIView *floatView = [[UIView alloc] init];
    floatView.okidoki
    .addToSuperview(self.view)
    .frame(@"{{20, 200}, {200, 80}}")
    .bgColor(@"#FF6B6B")
    .cnRadius(@16)
    .shadowColor(@"#000000")
    .shadowOpacity(@0.5)
    .shadowOffset(@"{0, 8}")
    .shadowRadius(@20);

    // 示例 4: 使用 shadowPath 优化性能
    UIView *optimizedView = [[UIView alloc] initWithFrame:CGRectMake(20, 320, 150, 100)];
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRoundedRect:optimizedView.bounds cornerRadius:10];
    optimizedView.okidoki
    .addToSuperview(self.view)
    .bgColor(@"#4ECDC4")
    .cnRadius(@10)
    .shadowColor(@"#000000")
    .shadowOpacity(@0.25)
    .shadowOffset(@"{0, 3}")
    .shadowRadius(@6)
    .shadowPath(shadowPath);           // 使用 path 提升性能

    // 示例 5: 内阴影效果（需要配合 masksToBounds）
    UIView *innerShadow = [[UIView alloc] init];
    innerShadow.okidoki
    .addToSuperview(self.view)
    .frame(@"{{250, 320}, {100, 100}}")
    .bgColor(@"#95E1D3")
    .cnRadius(@50)                     // 圆形
    .mtBounds(@NO)                     // 不裁剪，显示阴影
    .shadowColor(@"#000000")
    .shadowOpacity(@0.4)
    .shadowOffset(@"{0, 0}")
    .shadowRadius(@8);

    // 示例 6: 彩色阴影
    UIView *colorShadow = [[UIView alloc] init];
    colorShadow.okidoki
    .addToSuperview(self.view)
    .frame(@"{{20, 450}, {120, 60}}")
    .bgColor(@"#FFFFFF")
    .cnRadius(@12)
    .shadowColor(@"#FF6B6B")           // 红色阴影
    .shadowOpacity(@0.6)
    .shadowOffset(@"{0, 4}")
    .shadowRadius(@10);

    // 示例 7: UILabel 带阴影
    UILabel *label = [[UILabel alloc] init];
    label.okidoki
    .addToSuperview(self.view)
    .frame(@"{{20, 550}, {200, 50}}")
    .text(@"带阴影的文字")
    .align(@1)
    .font(@"b20")
    .color(@"#FFFFFF")
    .bgColor(@"#6C5CE7")
    .cnRadius(@8)
    .shadowColor(@"#000000")
    .shadowOpacity(@0.7)
    .shadowOffset(@"{0, 3}")
    .shadowRadius(@6)
    .highlightedTextColor(@"#FF0000") // 高亮颜色（红色）
    .highlighted(@YES);               // 设置为高亮状态
    
    // 示例 8: 按钮点击效果（通过改变阴影）
    UIButton *button = [[UIButton alloc] init];
    button.okidoki
    .addToSuperview(self.view)
    .frame(@"{{250, 550}, {100, 44}}")
    .title(@"按钮")
    .color(@"00FF00")
    .bgColor(@"#A29BFE")
    .cnRadius(@22)
    .shadowColor(@"#6C5CE7")
    .shadowOpacity(@0.5)
    .shadowOffset(@"{0, 4}")
    .shadowRadius(@8)
    .colorForState(@"FF00FF", @(UIControlStateHighlighted))
    .highlighted(@1);
}

- (void)layout_Example:(UIView *)containerView
{
    // 示例 1: 基础布局 - 固定大小
    UIView *box1 = [[UIView alloc] init];
    box1.okidoki
    .addToSuperview(containerView)
    .bgColor(UIColor.systemRedColor)
    .widthAnchor(@100)           // 宽度 100
    .heightAnchor(@100)          // 高度 100
    .centerXAnchor(@[containerView])  // 水平居中
    .topAnchor(@[containerView, @(80)])
    .tapGesture(^(UITapGestureRecognizer *tap) {
        NSLog(@"点击了视图");
        tap.view.okidoki.removeGesture(UITapGestureRecognizer.class);
        NSLog(@"移除点击事件");
    })
    .longPressGesture(^(UILongPressGestureRecognizer *longPress) {
        if (longPress.state == UIGestureRecognizerStateBegan) {
            NSLog(@"长按开始");
        }
    })
    .swipeGesture(UISwipeGestureRecognizerDirectionRight, ^(UISwipeGestureRecognizer *swipe) {
        NSLog(@"向右滑动");
    })
    .panGesture(^(UIPanGestureRecognizer *pan) {
        NSLog(@"拖动视图");
        CGPoint translation = [pan translationInView:pan.view.superview];
        pan.view.center = CGPointMake(pan.view.center.x + translation.x,
                                       pan.view.center.y + translation.y);
        [pan setTranslation:CGPointZero inView:pan.view.superview];
    })
    .pinchGesture(^(UIPinchGestureRecognizer *pinch) {
        NSLog(@"缩放视图");
        pinch.view.transform = CGAffineTransformScale(pinch.view.transform,
                                                       pinch.scale,
                                                       pinch.scale);
        pinch.scale = 1.0;
    })
    .rotationGesture(^(UIRotationGestureRecognizer *rotation) {
        NSLog(@"旋转视图");
        rotation.view.transform = CGAffineTransformRotate(rotation.view.transform,
                                                           rotation.rotation);
        rotation.rotation = 0;
    });
    
    // 示例 2: 填充父视图（带边距）
    UIView *box2 = [[UIView alloc] init];
    box2.okidoki
        .addToSuperview(containerView)
        .bgColor(UIColor.systemGreenColor)
        .topAnchor(@[box1.bottomAnchor, @20])        // 距离顶部 20
        .leadingAnchor(@[containerView, @20])    // 距离左边 20
        .trailingAnchor(@[containerView, @(-20)]) // 距离右边 20（负数）
        .bottomAnchor(@[containerView, @(-100)]);  // 距离底部 20（负数）
    
    // 示例 3: 垂直排列两个视图
    UIView *topView = [[UIView alloc] init];
    UIView *bottomView = [[UIView alloc] init];
    
    topView.okidoki
        .addToSuperview(box2)
        .bgColor(UIColor.systemBlueColor)
        .topAnchor(@[box2, @20])
        .leadingAnchor(@[box2, @20])
        .trailingAnchor(@[box2, @(-20)])
        .heightAnchor(@100);
    
    bottomView.okidoki
        .addToSuperview(box2)
        .bgColor(UIColor.systemGrayColor)
        .topAnchor(@[topView.bottomAnchor, @20])  // 相对于 topView 底部，间距 20
        .leadingAnchor(@[box2, @20])
        .trailingAnchor(@[box2, @(-20)])
//        .heightAnchor(@100)
        .bottomAnchor(@[box2.bottomAnchor, @(-20)]);
    
    // 示例 4: 水平排列三个等宽视图
    UIView *left = [[UIView alloc] init];
    UIView *middle = [[UIView alloc] init];
    UIView *right = [[UIView alloc] init];
    
    left.okidoki
        .addToSuperview(topView)
        .bgColor(@"#A29BFE")
        .topAnchor(@[topView, @10])
        .leadingAnchor(@[topView, @20])
        .widthAnchor(@[topView, @(1.0/3.0), @(-26.67)])  // 1/3 宽度，减去边距
        .heightAnchor(@80);
    
    middle.okidoki
        .addToSuperview(topView)
        .bgColor(@"#6C5CE7")
        .topAnchor(@[topView, @10])
        .leadingAnchor(@[left.trailingAnchor, @10])
        .widthAnchor(@[left])  // 与 left 等宽
        .heightAnchor(@80);
    
    right.okidoki
        .addToSuperview(topView)
        .bgColor(@"#A29BFE")
        .topAnchor(@[topView, @10])
        .leadingAnchor(@[middle.trailingAnchor, @10])
        .trailingAnchor(@[topView, @(-20)])
        .heightAnchor(@80);
    
    // 示例 5: 按比例布局
    UIView *halfWidthView = [[UIView alloc] init];
    halfWidthView.okidoki
        .addToSuperview(bottomView)
        .bgColor(UIColor.systemYellowColor)
        .topAnchor(@[bottomView, @20])
        .leadingAnchor(@[bottomView, @30])
        .widthAnchor(@[bottomView, @0.5, @0])   // 父视图宽度的 50%
        .heightAnchor(@[bottomView, @0.3, @0]); // 父视图高度的 30%
    
    // 示例 6: 混合使用 frame 和 AutoLayout（不推荐，但可以做到）
    UIView *mixedView = [[UIView alloc] init];
    mixedView.okidoki
        .addToSuperview(halfWidthView)
        .bgColor(UIColor.brownColor)
        .topAnchor(@[halfWidthView, @50])
        .leadingAnchor(@[halfWidthView, @50])
        .widthAnchor(@100)
        .heightAnchor(@60);
    
    // 示例 7: UILabel 使用 AutoLayout
    UILabel *label = [[UILabel alloc] init];
    label.okidoki
        .addToSuperview(bottomView)
        .text(@"AutoLayout Label")
        .font(@"b16")
        .color(@"#2D3436")
        .bgColor(@"#DFE6E9")
        .centerXAnchor(@[bottomView])
        .topAnchor(@[mixedView.bottomAnchor, @30])
        .widthAnchor(@[bottomView, @0.5, @10])
        .heightAnchor(@44);
    
    // 示例 8: UIButton 使用 AutoLayout
    UIButton *button = [[UIButton alloc] init];
    [containerView addSubview:button];
    button.okidoki
    .title(@"点击我")
    .bgColor(UIColor.systemBlueColor)
    .cnRadius(@8)
    .topAnchor(@[box2.bottomAnchor, @(10)])
    .centerXAnchor(@[containerView])
    .widthAnchor(@200)
    .heightAnchor(@44)
    .addControlEvent(UIControlEventTouchUpInside, ^(UIButton *button) {
        NSLog(@"点击事件");
        
        button.okidoki.title(@"已点击！");
    });
    
    // 示例 9: 使用 edgeToSuperView - 填充父视图（所有边距为 0）
    
    UIView *view9 = [[UIView alloc] init];
    view9.okidoki
    .addToSuperview(bottomView)
    .bgColor(@"#DFE6E9")
    .topAnchor(@[label.bottomAnchor, @30])
    .leadingAnchor(@[bottomView, @20])
    .trailingAnchor(@[bottomView, @(-20)])
    .bottomAnchor(@[bottomView, @(-20)])
    .addSubviewWithConfig(UIView.new, ^(Okidoki *ok){
        ok.bgColor(@"#00B894")
        .cnRadius(@20)
        .edgeToSuperView(nil); // 完全填充，四边距离都为 0
    })
    .addSubviewWithConfig(UIView.new, ^(Okidoki *ok){
        ok.bgColor(@"#E17055")
        .edgeToSuperView(@15);  // 四边距离都为 20
    })
    .addSubviewWithConfig(UIView.new, ^(Okidoki *ok){
        ok.bgColor(@"#74B9FF")
        .cnRadius(@10)
        .edgeToSuperView(@[@30, @30, @(-30), @(-30)]);  // 上10，左20，下30，右40
    })
    .addSubviewWithConfig(UIView.new, ^(Okidoki *ok){
        ok.bgColor(@"#FD79A8")
        .edgeToSuperView(@[@40, @50]);  // 垂直10，水平30
    })
    .addSubviewWithConfig(UIView.new, ^(Okidoki *ok){
        UIEdgeInsets insets = UIEdgeInsetsMake(60, 75, 70, 85);
        ok.bgColor(@"#FDCB6E")
        .cnRadius(@10)
        .edgeToSuperView([NSValue valueWithUIEdgeInsets:insets]);
    })
    .addSubviewWithConfig_superView(UIView.new, ^(Okidoki *ok, UIView *superView){
        ok.bgColor(UIColor.redColor)
        .cnRadius(@3)
        .leadingAnchor(@[superView, @0])
        .centerYAnchor(@[superView])
        .widthAnchor(@6)
        .heightAnchor(@100);
    });
}

- (void)panAnimation_Example
{
    UIView *box1 = UIView.new;
    UIView *box2 = UIView.new;
    
    box1.okidoki
    .addToSuperview(self.view)
    //.frame(@"{{30, 70}, {100, 100}}")
    .frame([NSValue valueWithCGRect:CGRectMake(30, 70, 100, 100)])
    .bgColor(@"FF0000")
    .panGesture(^(UIPanGestureRecognizer *pan) {
        NSLog(@"拖动视图");
        CGPoint translation = [pan translationInView:pan.view.superview];
        pan.view.center = CGPointMake(pan.view.center.x + translation.x,
                                      pan.view.center.y + translation.y);
        
        // 重置累计偏移量，将手势的位移归零。
        // 不重置：每次获取的是从手势开始的总偏移量（越来越大）
        // 重置后：每次获取的是上次重置后的增量偏移（准确跟随手指）
        [pan setTranslation:CGPointZero inView:pan.view.superview];
    });
    
    box2.okidoki
    .addToSuperview(self.view)
    .bgColor(UIColor.systemGreenColor)
    .leadingAnchor(@[box1, @10])
    .topAnchor(@[box1.bottomAnchor, @20])
    .rightAnchor(@[self.view, @(-20)])
    .bottomAnchor(@[self.view, @(-20)]);
}

@end
