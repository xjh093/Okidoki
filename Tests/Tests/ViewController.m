//
//  ViewController.m
//  Tests
//
//  Created by HaoCold on 2020/7/30.
//  Copyright © 2020 HaoCold. All rights reserved.
//

#import "ViewController.h"
#import "Okidoki.h"
#import "OkidokiLabel.h"


@interface ViewController ()
@property (nonatomic,  strong) UITableView *tableView;
@property (nonatomic,  strong) UICollectionView *collectionView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    // See TestsTests.m for more infomation.

    [self basic_Example];

//    [self shadow_Example];
    
//    [self layout_Example:self.view];
    
//    [self panAnimation_Example];
    
//    [self tableView_Example];
    
//    [self collectionView_Example];
    
//    [self textField_Example];
    
//    [self textView_Example];
    

}

- (void)basic_Example
{
    UIView.new.okidoki
    .addToSuperview(UIScrollView.new.okidoki
                    .addToSuperview(self.view)
                    .edgeToSuperView(nil)
                    .view)
    .tag(@100)
    //.frame([NSValue valueWithCGRect:CGRectInset(self.view.bounds, 20, 70)])
    .alpha(@1)
    .hidden(@"0")
    .bgColor(@"EEEEEE")
    .bdColor(@"FFFEEE")
    .bdWidth(@1)
    .cnRadius(@6)
    .shadowColor(@"#000000") // 黑色阴影
    .shadowOpacity(@0.3) // 不透明度 30%
    .shadowOffset(@"{0, 2}") // 向下偏移 2pt
    .shadowRadius(@4)
    .batch(^(Okidoki *ok) {
        ok.edgeToSuperView(@20)
          .widthAnchor(@[self.view, @1, @-40]);
    })
    .addSubviewWithConfig(UILabel.new, ^(Okidoki * _Nonnull ok) {
        UIView *s = ok.view.superview;
        ok.tag(@101)
        .text(@"Okidoki")
        .font(@"b24")
        .color(@"333333")
        .batch(^(Okidoki *ok) {
            ok.leadingAnchor(@[s.leadingAnchor, @20])
              .topAnchor(@[s, @20]);
        })
        .whenEnabled(^(UILabel * _Nonnull view) {
            view.textColor = [UIColor systemOrangeColor];
        })
        .whenDisabled(^(UILabel * _Nonnull view) {
            view.textColor = [UIColor systemGreenColor];
        });
    })
    .addSubviewWithConfig(UIButton.new, ^(Okidoki * _Nonnull ok) {
        UIView *s = ok.view.superview;
        UIView *b1 = [s viewWithTag:101];
        
        ok.title(@"点击~")
        .font(@"18")
        .color(@"ffffff")
        .bgColor(UIColor.systemBlueColor)
        .batch(^(Okidoki *ok) {
            ok.leadingAnchor(@[b1.trailingAnchor, @20])
              .heightAnchor(@30)
              .topAnchor(@[b1]);
        })
        .tapGesture(^(UITapGestureRecognizer *tap) {
            UILabel *label = [self.view viewWithTag:101];
            label.okidoki.userInteractionEnabled(@(!label.userInteractionEnabled));
        });
    })
    .addSubviewWithConfig(OkidokiLabel.new, ^(Okidoki * _Nonnull ok) {
        UIView *s = ok.view.superview;
        UIView *b1 = [s viewWithTag:101];
        
        ok.tag(@102)
        .text(@"1、这是一个用于 iOS 开发的 Objective-C 库，核心功能是用链式语法来设置 UIKit 控件的属性。")
        .font(@"18")
        .color(@"444444")
        .lines(@0)
        .textInsets(UIEdgeInsetsMake(5, 10, 5, 10))
        .debugBorder(@YES)
        .batch(^(Okidoki *ok) {
            ok.leadingAnchor(@[s.leadingAnchor, @20])
              .trailingAnchor(@[s, @-20])
              .topAnchor(@[b1.bottomAnchor, @10]);
        });
    })
    .addSubviewWithConfig(UIView.new, ^(Okidoki * _Nonnull ok) {
        UIView *s = ok.view.superview;
        UIView *b2 = [s viewWithTag:102];
        
        [self setupCodeSubView:ok tag:103 subView:b2
                          text:@"1.1、基础 UI 属性"
                        detail:@"链式设置 tag、透明度、背景色、圆角、边框等。"
                          code:@"代码示例：\n```\nview.okidoki\n.tag(@100)\n.alpha(@0.5)\n.cnRadius(@3);\n```"];
    })
    .addSubviewWithConfig(UIView.new, ^(Okidoki * _Nonnull ok) {
        UIView *s = ok.view.superview;
        UIView *b3 = [s viewWithTag:103];
        
        [self setupCodeSubView:ok tag:104 subView:b3
                          text:@"1.2、文本控件"
                        detail:@"快速配置文本、颜色、字体、对齐、行数等。"
                          code:@"代码示例：\n```\nlabel.okidoki\n.text(@\"label\")\n.font([UIFont systemFontOfSize:14]);\n```"];
    })
    .addSubviewWithConfig(UIView.new, ^(Okidoki * _Nonnull ok) {
        UIView *s = ok.view.superview;
        UIView *b4 = [s viewWithTag:104];
        
        [self setupCodeSubView:ok tag:105 subView:b4
                          text:@"1.3、按钮"
                        detail:@"为不同状态设置标题、颜色和图片。"
                          code:@"代码示例：\n```\nbutton.okidoki\n.titleForState(@\"button\",@0);\n```"];
    })
    .addSubviewWithConfig(UIView.new, ^(Okidoki * _Nonnull ok) {
        UIView *s = ok.view.superview;
        UIView *b5 = [s viewWithTag:105];
        
        [self setupCodeSubView:ok tag:106 subView:b5
                          text:@"1.4、输入限制"
                        detail:@"支持为 UITextField 和 UITextView 设置输入字符类型和长度限制。"
                          code:@"代码示例：\n```\ntextField.okidoki.\ntfInputLimit(OkidokiInputLimitTypeDigital, 6, nil, nil);\n```"];
    })
    
    .addSubviewWithConfig(UILabel.new, ^(Okidoki * _Nonnull ok) {
        UIView *s = ok.view.superview;
        UIView *b1 = [s viewWithTag:106];
        
        ok.tag(@107)
        .text(@"2、还支持自动布局、手势、键盘处理、输入限制等等。")
        .font(@"18")
        .color(@"444444")
        .lines(@0)
        .batch(^(Okidoki *ok) {
            ok.leadingAnchor(@[b1])
              .trailingAnchor(@[b1])
              .topAnchor(@[b1.bottomAnchor, @30]);
        });
    })
    .addSubviewWithConfig(UIView.new, ^(Okidoki * _Nonnull ok) {
        UIView *s = ok.view.superview;
        UIView *b2 = [s viewWithTag:107];
        
        [self setupCodeSubView:ok tag:108 subView:b2
                          text:@"2.1、自动布局"
                        detail:@"支持系统的 AutoLayout，快速调用设置约束。"
                          code:@"代码示例：\n```\nUIView.new.okidoki\n"
         @".addToSuperview(UIScrollView.new.okidoki\n"
         @"    .addToSuperview(self.view)\n"
         @"    .edgeToSuperView(nil)\n"
         @"    .view)\n"
         @".tag(@100)\n"
         @".edgeToSuperView(@20)\n"
         @".widthAnchor(@[self.view, @1, @-40])\n```"];
    })
    .addSubviewWithConfig(UIView.new, ^(Okidoki * _Nonnull ok) {
        UIView *s = ok.view.superview;
        UIView *b2 = [s viewWithTag:108];
        
        [self setupCodeSubView:ok tag:109 subView:b2
                          text:@"2.2、手势"
                        detail:@"支持系统的常用手势，快速设置。"
                          code:@"代码示例：\n```\nview.okidoki.tapGesture(^(UITapGestureRecognizer *tap) {\n"
            @"    NSLog(@\"点击了视图\");\n"
            @"})\n"
            @".longPressGesture(^(UILongPressGestureRecognizer *longPress) {\n"
            @"    if (longPress.state == UIGestureRecognizerStateBegan) {\n"
            @"        NSLog(@\"长按开始\");\n"
            @"    }\n"
            @"})\n"
            @".swipeGesture(UISwipeGestureRecognizerDirectionRight, ^(UISwipeGestureRecognizer *swipe) {\n"
            @"    NSLog(@\"向右滑动\");\n"
            @"})\n"
            @".panGesture(^(UIPanGestureRecognizer *pan) {\n"
            @"    NSLog(@\"拖动视图\");\n"
            @"})\n"
            @".pinchGesture(^(UIPinchGestureRecognizer *pinch) {\n"
            @"    NSLog(@\"缩放视图\");\n"
            @"})\n"
            @".rotationGesture(^(UIRotationGestureRecognizer *rotation) {\n"
            @"    NSLog(@\"旋转视图\");\n"
            @"})\n```"];
    })
    .addSubviewWithConfig(UIView.new, ^(Okidoki * _Nonnull ok) {
        UIView *s = ok.view.superview;
        UIView *b2 = [s viewWithTag:109];
        
        [self setupCodeSubView:ok tag:110 subView:b2
                          text:@"2.3、输入限制"
                        detail:@"过滤数字、字母、中文，限制长度，以及自定义字符。"
                          code:@"代码示例：\n```\ntextField.okidoki\n"
         @".tfInputLimit(OkidokiInputLimitTypeDigital, 6, nil, ^(NSString *original, NSString *matched) {\n"
         @"    // 限制只能输入数字,且最大长度为 6\n"
         @"    NSLog(@\"Input changed: %@ -> %@\", original, matched);\n"
         @"})\n```"];
    })
    
    .addSubviewWithConfig([self shadow_Example], ^(Okidoki * _Nonnull ok) {
        UIView *s = ok.view.superview;
        UIView *b2 = [s viewWithTag:110];
        
        ok.tag(@(111))
        .bgColor(@"DDDDDD")
        .bdColor(@"CCCCCC")
        .bdWidth(@1)
        .cnRadius(@6)
        .batch(^(Okidoki *ok) {
            ok.leadingAnchor(@[b2])
              .trailingAnchor(@[b2])
              .topAnchor(@[b2.bottomAnchor, @10])
              .heightAnchor(@600);
        });
    })
    
    .addSubviewWithConfig([self layout_Example], ^(Okidoki * _Nonnull ok) {
        UIView *s = ok.view.superview;
        UIView *b2 = [s viewWithTag:111];
        
        ok.tag(@(112))
        .bgColor(@"DDDDDD")
        .bdColor(@"CCCCCC")
        .bdWidth(@1)
        .cnRadius(@6)
        .batch(^(Okidoki *ok) {
            ok.leadingAnchor(@[b2])
              .trailingAnchor(@[b2])
              .topAnchor(@[b2.bottomAnchor, @10])
              .heightAnchor(@800);
        });
    })
    
    .addSubviewWithConfig([self panAnimation_Example], ^(Okidoki * _Nonnull ok) {
        UIView *s = ok.view.superview;
        UIView *b2 = [s viewWithTag:112];
        
        ok.tag(@(113))
        .bgColor(@"DDDDDD")
        .bdColor(@"CCCCCC")
        .bdWidth(@1)
        .cnRadius(@6)
        .batch(^(Okidoki *ok) {
            ok.leadingAnchor(@[b2])
              .trailingAnchor(@[b2])
              .topAnchor(@[b2.bottomAnchor, @10])
              .heightAnchor(@600);
        });
    })
    
    
    .addSubviewWithConfig(UILabel.new, ^(Okidoki * _Nonnull ok) {
        UIView *s = ok.view.superview;
        UIView *b = s.subviews[s.subviews.count-2];
        
        ok.tag(@1999)
        .text(@"End")
        .font(@"b24")
        .color(@"333333")
        .batch(^(Okidoki *ok) {
            ok.leadingAnchor(@[b])
              .topAnchor(@[b.bottomAnchor, @30])
              .bottomAnchor(@[s, @-20]);
        });
    })
    ;
}

- (void)setupCodeSubView:(Okidoki *)ok tag:(NSInteger)tag subView:(UIView *)b2 text:(NSString *)text detail:(NSString *)detail code:(NSString *)code
{
    ok.tag(@(tag))
    .bgColor(@"DDDDDD")
    .bdColor(@"CCCCCC")
    .bdWidth(@1)
    .cnRadius(@6)
    .batch(^(Okidoki *ok) {
        ok.leadingAnchor(@[b2])
          .trailingAnchor(@[b2])
          .topAnchor(@[b2.bottomAnchor, @10]);
    })
    .addSubviewWithConfig(UILabel.new, ^(Okidoki * _Nonnull ok) {
        UIView *s = ok.view.superview;
        ok.tag(@1000)
        .text(text)
        .font(@"14")
        .color(@"666666")
        .batch(^(Okidoki *ok) {
            ok.leadingAnchor(@[s, @10])
              .trailingAnchor(@[s, @-10])
              .topAnchor(@[s, @10]);
        });
    })
    .addSubviewWithConfig(UILabel.new, ^(Okidoki * _Nonnull ok) {
        UIView *s = ok.view.superview;
        UIView *b1 = [s viewWithTag:1000];
        
        ok.tag(@2000)
        .text(detail)
        .font(@"14")
        .color(@"666666")
        .lines(@0)
        .batch(^(Okidoki *ok) {
            ok.leadingAnchor(@[b1])
              .trailingAnchor(@[b1])
              .topAnchor(@[b1.bottomAnchor, @10]);
        });
    })
    .addSubviewWithConfig(UILabel.new, ^(Okidoki * _Nonnull ok) {
        UIView *s = ok.view.superview;
        UIView *b1 = [s viewWithTag:2000];
        
        ok.tag(@3000)
        .text(code)
        .font(@"14")
        .color(@"666666")
        .lines(@0)
        .batch(^(Okidoki *ok) {
            ok.leadingAnchor(@[b1])
              .trailingAnchor(@[b1])
              .topAnchor(@[b1.bottomAnchor, @10])
              .bottomAnchor(@[s]);
        });
    });
}

- (void)refreshAction
{
    NSLog(@"模拟网络请求");
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.refreshControl endRefreshing];
        [self.collectionView.refreshControl endRefreshing];
    });
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    NSLog(@"viewDidLayoutSubviews");
}

- (UIView *)shadow_Example
{
    UIView *view = [[UIView alloc] init];
    
    // 示例 1: 基础阴影效果
    UIView.new.okidoki
    .addToSuperview(view)
    .frame(@"{{20, 30}, {60, 60}}")
    .bgColor(@"#FFFFFF")
    .cnRadius(@10)
    .shadowColor(@"#000000")           // 黑色阴影
    .shadowOpacity(@0.3)                // 不透明度 30%
    .shadowOffset(@"{0, 2}")            // 向下偏移 2pt
    .shadowRadius(@4);                  // 模糊半径 4pt

    // 示例 2: 卡片阴影效果
    UIView *card = [[UIView alloc] init];
    card.okidoki
    .addToSuperview(view)
    .frame(@"{{100, 30}, {200, 60}}")
    .bgColor(@"#FFFFFF")
    .cnRadius(@8)
    .shadowColor(@"#333333")
    .shadowOpacity(@0.15)
    .shadowOffset(@"{0, 4}")
    .shadowRadius(@12);

    // 示例 3: 浮起效果（大阴影）
    UIView *floatView = [[UIView alloc] init];
    floatView.okidoki
    .addToSuperview(view)
    .frame(@"{{20, 120}, {200, 80}}")
    .bgColor(@"#FF6B6B")
    .cnRadius(@16)
    .shadowColor(@"#000000")
    .shadowOpacity(@0.5)
    .shadowOffset(@"{0, 8}")
    .shadowRadius(@20);

    // 示例 4: 使用 shadowPath 优化性能
    UIView *optimizedView = [[UIView alloc] initWithFrame:CGRectMake(20, 250, 150, 100)];
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRoundedRect:optimizedView.bounds cornerRadius:10];
    optimizedView.okidoki
    .addToSuperview(view)
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
    .addToSuperview(view)
    .frame(@"{{200, 250}, {100, 100}}")
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
    .addToSuperview(view)
    .frame(@"{{20, 400}, {120, 60}}")
    .bgColor(@"#FFFFFF")
    .cnRadius(@12)
    .shadowColor(@"#FF6B6B")           // 红色阴影
    .shadowOpacity(@0.6)
    .shadowOffset(@"{0, 4}")
    .shadowRadius(@10);

    // 示例 7: UILabel 带阴影
    UILabel *label = [[UILabel alloc] init];
    label.okidoki
    .addToSuperview(view)
    .frame(@"{{20, 500}, {160, 50}}")
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
    .addToSuperview(view)
    .frame(@"{{220, 500}, {80, 44}}")
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
    
    return view;
}

- (UIView *)layout_Example
{
    UIView *containerView = [[UIView alloc] init];
    
    // 示例 1: 基础布局 - 固定大小
    UIView *box1 = [[UIView alloc] init];
    box1.okidoki
    .addToSuperview(containerView)
    .bgColor(UIColor.systemRedColor)
    .batch(^(Okidoki *ok) {
        ok.widthAnchor(@100)
          .heightAnchor(@100)
          .centerXAnchor(@[containerView])
          .topAnchor(@[containerView, @(20)]);
    })
    .addSubviewWithConfig(UILabel.new, ^(Okidoki * _Nonnull ok) {
        UIView *s = ok.view.superview;
        
        ok.batch(^(Okidoki *ok) {
            ok.widthAnchor(@[s])
              .heightAnchor(@40);
        })
        .text(@"手势事件")
        .align(@1);
    })
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
        .batch(^(Okidoki *ok) {
            ok.topAnchor(@[box1.bottomAnchor, @20])
              .leadingAnchor(@[containerView, @20])
              .trailingAnchor(@[containerView, @(-20)])
              .bottomAnchor(@[containerView, @(-100)]);
        });
    
    // 示例 3: 垂直排列两个视图
    UIView *topView = [[UIView alloc] init];
    UIView *bottomView = [[UIView alloc] init];
    
    topView.okidoki
        .addToSuperview(box2)
        .bgColor(UIColor.systemBlueColor)
        .batch(^(Okidoki *ok) {
            ok.topAnchor(@[box2, @20])
              .leadingAnchor(@[box2, @20])
              .trailingAnchor(@[box2, @(-20)])
              .heightAnchor(@100);
        });
    
    bottomView.okidoki
        .addToSuperview(box2)
        .bgColor(UIColor.systemGrayColor)
        .batch(^(Okidoki *ok) {
            ok.topAnchor(@[topView.bottomAnchor, @20])
              .leadingAnchor(@[box2, @20])
              .trailingAnchor(@[box2, @(-20)])
//              .heightAnchor(@100)
              .bottomAnchor(@[box2.bottomAnchor, @(-20)]);
        });
    
    // 示例 4: 水平排列三个等宽视图
    UIView *left = [[UIView alloc] init];
    UIView *middle = [[UIView alloc] init];
    UIView *right = [[UIView alloc] init];
    
    left.okidoki
        .addToSuperview(topView)
        .bgColor(@"#A29BFE")
        .batch(^(Okidoki *ok) {
            ok.topAnchor(@[topView, @10])
              .leadingAnchor(@[topView, @20])
              .widthAnchor(@[topView, @(1.0/3.0), @(-26.67)])
              .heightAnchor(@80);
        });
    
    middle.okidoki
        .addToSuperview(topView)
        .bgColor(@"#6C5CE7")
        .batch(^(Okidoki *ok) {
            ok.topAnchor(@[topView, @10])
              .leadingAnchor(@[left.trailingAnchor, @10])
              .widthAnchor(@[left])
              .heightAnchor(@80);
        });
    
    right.okidoki
        .addToSuperview(topView)
        .bgColor(@"#A29BFE")
        .batch(^(Okidoki *ok) {
            ok.topAnchor(@[topView, @10])
              .leadingAnchor(@[middle.trailingAnchor, @10])
              .trailingAnchor(@[topView, @(-20)])
              .heightAnchor(@80);
        });
    
    // 示例 5: 按比例布局
    UIView *halfWidthView = [[UIView alloc] init];
    halfWidthView.okidoki
        .addToSuperview(bottomView)
        .bgColor(UIColor.systemYellowColor)
        .batch(^(Okidoki *ok) {
            ok.topAnchor(@[bottomView, @20])
              .leadingAnchor(@[bottomView, @30])
              .widthAnchor(@[bottomView, @0.5, @0])
              .heightAnchor(@[bottomView, @0.3, @0]);
        });
    
    // 示例 6: 混合使用 frame 和 AutoLayout（不推荐，但可以做到）
    UIView *mixedView = [[UIView alloc] init];
    mixedView.okidoki
        .addToSuperview(halfWidthView)
        .bgColor(UIColor.brownColor)
        .batch(^(Okidoki *ok) {
            ok.topAnchor(@[halfWidthView, @50])
              .leadingAnchor(@[halfWidthView, @50])
              .widthAnchor(@100)
              .heightAnchor(@60);
        });
    
    // 示例 7: UILabel 使用 AutoLayout
    UILabel *label = [[UILabel alloc] init];
    label.okidoki
        .addToSuperview(bottomView)
        .text(@"AutoLayout Label")
        .font(@"b16")
        .color(@"#2D3436")
        .bgColor(@"#DFE6E9")
        .batch(^(Okidoki *ok) {
            ok.centerXAnchor(@[bottomView])
              .topAnchor(@[mixedView.bottomAnchor, @30])
              .widthAnchor(@[bottomView, @0.5, @10])
              .heightAnchor(@44);
        });
    
    // 示例 8: UIButton 使用 AutoLayout
    UIButton *button = [[UIButton alloc] init];
    [containerView addSubview:button];
    button.okidoki
    .title(@"点击我")
    .bgColor(UIColor.systemBlueColor)
    .cnRadius(@8)
    .batch(^(Okidoki *ok) {
        ok.topAnchor(@[box2.bottomAnchor, @(10)])
          .centerXAnchor(@[containerView])
          .widthAnchor(@200)
          .heightAnchor(@44);
    })
    .addControlEvent(UIControlEventTouchUpInside, ^(UIButton *button) {
        NSLog(@"点击事件");
        
        button.okidoki.title(@"已点击！");
    });
    
    // 示例 9: 使用 edgeToSuperView - 填充父视图（所有边距为 0）
    UIView *view9 = [[UIView alloc] init];
    view9.okidoki
    .addToSuperview(bottomView)
    .bgColor(@"#DFE6E9")
    .batch(^(Okidoki *ok) {
        ok.topAnchor(@[label.bottomAnchor, @30])
          .leadingAnchor(@[bottomView, @20])
          .trailingAnchor(@[bottomView, @(-20)])
          .bottomAnchor(@[bottomView, @(-20)]);
    })
    .addSubviewWithConfig(UIView.new, ^(Okidoki *ok){
        ok.bgColor(@"#00B894")
        .cnRadius(@20)
        .edgeToSuperView(@0); // 完全填充，四边距离都为 0
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
        .batch(^(Okidoki *ok) {
            ok.leadingAnchor(@[superView, @0])
              .centerYAnchor(@[superView])
              .widthAnchor(@6)
              .heightAnchor(@100);
        });
    });
    
    return containerView;
}


- (UIView *)panAnimation_Example
{
    UIView *view = [[UIView alloc] init];
    
    UIView *box1 = UIView.new;
    UIView *box2 = UIView.new;
    
    box1.okidoki
    .addToSuperview(view)
    //.frame(@"{{30, 70}, {100, 100}}")
    .frame([NSValue valueWithCGRect:CGRectMake(30, 50, 100, 100)])
    .bgColor(@"FF0000".okidokiHexColor.okidokiAlpha(0.8))
    .panGesture(^(UIPanGestureRecognizer *pan) {
        NSLog(@"拖动视图");
        CGPoint translation = [pan translationInView:pan.view.superview];
        pan.view.center = CGPointMake(pan.view.center.x + translation.x,
                                      pan.view.center.y + translation.y);
        
        // 重置累计偏移量，将手势的位移归零。
        // 不重置：每次获取的是从手势开始的总偏移量（越来越大）
        // 重置后：每次获取的是上次重置后的增量偏移（准确跟随手指）
        [pan setTranslation:CGPointZero inView:pan.view.superview];
        
        // 打印 box1 的实际 frame
        NSLog(@"box1 frame: %@", NSStringFromCGRect(box1.frame));
        
        // 打印 box2 的实际高度
        NSLog(@"box2 frame: %@", NSStringFromCGRect(box2.frame));
    });
    
    box2.okidoki
    .addToSuperview(view)
    .bgColor(UIColor.systemGreenColor.okidokiAlpha(0.9))
    .batch(^(Okidoki *ok) {
        ok.leadingAnchor(@[box1, @10])
          .topAnchor(@[box1.bottomAnchor, @20])
          .rightAnchor(@[view, @(-100)])
          .bottomAnchor(@[view, @(-100)])
          .widthAnchorGreaterOrEqual(@100)
          .heightAnchorGreaterOrEqual(@[@100]);
    });
    
    //NSLog(@"box2.constraints = %@", box2.constraints);
    //NSLog(@"self.view.constraints = %@", box2.superview.constraints);
    
    // box2 的 height 约束
//    for (NSLayoutConstraint *c in box2.constraints) {
//        if ([c.identifier isEqualToString:@"okidoki_height"]) {
//            c.priority = 999;
//        }
//    }
    
    // box2 的 bottom, right 约束, 调低优先级
    for (NSLayoutConstraint *c in view.constraints) {
        if (c.firstItem == box2){ // 关键：检查是哪个视图的约束
            if ([c.identifier isEqualToString:@"okidoki_bottom"]) {
                c.priority = 900;
            } else if ([c.identifier isEqualToString:@"okidoki_right"]) {
                c.priority = 900;
            }
        }
    }
    
    return view;
}


- (void)tableView_Example
{
    [self.view addSubview:self.tableView];
    
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    [refresh addTarget:self action:@selector(refreshAction) forControlEvents:UIControlEventValueChanged];
    
    self.tableView.refreshControl = refresh;
    
    NSLog(@"view1.tag = %@", @(UIView.new.okidoki.tag(@100).view.tag));
}


- (UITableView *)tableView{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:0];
        tableView.tableFooterView = [[UIView alloc] init];
        tableView.showsVerticalScrollIndicator = NO;
        _tableView = tableView;
        
        tableView.okidoki
        .didScroll(^(UIScrollView *scrollView) {
            NSLog(@"contentOffset: %@", NSStringFromCGPoint(scrollView.contentOffset));
        })
        .willBeginDragging(^(UIScrollView *scrollView) {
            NSLog(@"开始拖拽");
        })
        .willEndDragging(^(UIScrollView *scrollView, CGPoint velocity) {
            NSLog(@"结束拖拽，速度: %@", NSStringFromCGPoint(velocity));
        })
        .didEndDecelerating(^(UIScrollView *scrollView) {
            NSLog(@"减速结束");
        });
        
        tableView.okidoki
            .registerCellClass(@[[UITableViewCell class], @"Cell"])
            .numberOfSections(^NSInteger(UITableView *tableView) {
                return 1;
            })
            .numberOfRowsInSection(^NSInteger(UITableView *tableView, NSInteger section) {
                return 10;
            })
            .cellForRowAtIndexPath(^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
                
                UILabel *label = [cell.contentView viewWithTag:100];
                if (!label) {
                    label = UILabel.new;
                    cell.contentView.okidoki
                    .addSubviewWithConfig(UIView.new, ^(Okidoki *ok) {
                        ok.tag(@10)
                        .bdColor(UIColor.systemOrangeColor)
                        .bdWidth(@1)
                        .edgeToSuperView(@10)
                        .addSubviewWithConfig(label, ^(Okidoki *ok) {
                            ok.tag(@100)
                            .align(@1)
                            .font(@20)
                            .bdColor(UIColor.systemOrangeColor)
                            .bdWidth(@2)
                            .color(@"00FF00")
                            .edgeToSuperView(@20);
                        });
                    });
                }
                label.text = [NSString stringWithFormat:@"Row %ld", indexPath.row];
                return cell;
            })
            .didDeselectRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath) {
                NSLog(@"Deselected");
            })
            .didSelectRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath) {
                NSLog(@"Selected row: %ld", indexPath.row);
                [tableView deselectRowAtIndexPath:indexPath animated:YES];
            });
    }
    return _tableView;
}


- (void)collectionView_Example
{
    [self.view addSubview:self.collectionView];
    
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    [refresh addTarget:self action:@selector(refreshAction) forControlEvents:UIControlEventValueChanged];
    
    self.collectionView.refreshControl = refresh;
    
    NSLog(@"view2.tag = %@", @(UIView.new.okidoki.tag(@200).view.tag));
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *collectionLayout = [[UICollectionViewFlowLayout alloc]init];
        UICollectionView *view = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:collectionLayout];
        view.backgroundColor = [UIColor whiteColor];
        _collectionView = view;
        
        view.okidoki
        .cvRegisterCellClass(@[[UICollectionViewCell class], @"Cell"])
        .cvNumberOfItemsInSection(^NSInteger(UICollectionView *collectionView, NSInteger section) {
            return 10;
        })
        .cvCellForItemAtIndexPath(^UICollectionViewCell *(UICollectionView *collectionView, NSIndexPath *indexPath) {
            UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
            
            UILabel *textLabel = [cell.contentView viewWithTag:100];
            if (!textLabel) {
                textLabel = UILabel.new;
                cell.contentView.okidoki
                .addSubviewWithConfig(textLabel, ^(Okidoki *ok) {
                    ok.tag(@100)
                    .align(@1)
                    .font(@20)
                    .bdColor(UIColor.systemOrangeColor)
                    .bdWidth(@2)
                    .color(@"00FF00")
                    .edgeToSuperView(nil);
                });
            }
            
            textLabel.text = [NSString stringWithFormat:@"Item %ld", indexPath.row + 1];
            return cell;
        })
        .cvSizeForItemAtIndexPath(^CGSize(UICollectionView *collectionView, UICollectionViewLayout *layout, NSIndexPath *indexPath) {
            CGFloat w = (CGRectGetWidth(collectionView.bounds) - 30)*0.5;
            return CGSizeMake(w, 100);
        })
        .cvInsetForSectionAtIndex(^UIEdgeInsets(UICollectionView *collectionView, UICollectionViewLayout *layout, NSInteger section) {
            return UIEdgeInsetsMake(10, 10, 10, 10);
        })
        .cvDidSelectItemAtIndexPath(^(UICollectionView *collectionView, NSIndexPath *indexPath) {
            NSLog(@"Selected = %@", @(indexPath.item));
        });

    }
    return _collectionView;
    
    
}

- (void)textField_Example
{
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 700, 300, 44)];

    textField.okidoki
    .addToSuperview(self.view)
    .bgColor(@"F5F5F5")
    .bdStyle(@(UITextBorderStyleRoundedRect))
    .pHolder(@"请输入用户名~")
    .pHColor(UIColor.systemRedColor)
    .font(@"b16")
    .tfShouldBeginEditing(^BOOL(UITextField *textField) {
        NSLog(@"即将开始编辑");
        return YES;
    })
    .tfDidBeginEditing(^(UITextField *textField) {
        NSLog(@"已经开始编辑");
    })
    .tfInputLimit(OkidokiInputLimitTypeDigital, 6, nil, ^(NSString *original, NSString *matched) {
        // 限制只能输入数字,且最大长度为 6
        NSLog(@"Input changed: %@ -> %@", original, matched);
    })
    .tfShouldChangeCharacters(^BOOL(UITextField *textField, NSRange range, NSString *replacementString) {
        // 限制只能输入数字
//        NSCharacterSet *numberSet = [NSCharacterSet decimalDigitCharacterSet];
//        if ([replacementString length] > 0 && ![numberSet isSupersetOfSet:[NSCharacterSet characterSetWithCharactersInString:replacementString]]) {
//            return NO;
//        }
        return YES;
    })
    .tfShouldReturn(^BOOL(UITextField *textField) {
        [textField resignFirstResponder];
        return YES;
    })
    .keyboardHandler(^(NSNotificationName name, CGRect beginFrame, CGRect endFrame, CGFloat duration, UIViewAnimationCurve curve) {
        if ([name isEqualToString:UIKeyboardWillShowNotification]) {
            CGFloat keyboardY = endFrame.origin.y;
            CGFloat fieldMaxY = CGRectGetMaxY(textField.frame);
            
            if (fieldMaxY > keyboardY) {
                // 输入框被键盘遮挡，需要调整
                CGFloat offset = fieldMaxY - keyboardY + 10; // 额外留10px间距
                
                [UIView animateWithDuration:duration
                                      delay:0
                                    options:curve << 16
                                 animations:^{
                    textField.transform = CGAffineTransformMakeTranslation(0, -offset);
                } completion:nil];
            }
        } else if ([name isEqualToString:UIKeyboardWillHideNotification]) {
            [UIView animateWithDuration:duration
                                  delay:0
                                options:curve << 16
                             animations:^{
                textField.transform = CGAffineTransformIdentity;
            } completion:nil];
        }
    });
    
    
    //
    UITextField *passwordField = [[UITextField alloc] initWithFrame:CGRectMake(20, 200, 300, 44)];
    passwordField.okidoki
    .addToSuperview(self.view)
    .bdStyle(@(UITextBorderStyleRoundedRect))
    .pHolder(@"请输入密码")
    .secure(@YES)
    .cbMode(@1)
    .tfDidEndEditing(^(UITextField *textField) {
        NSLog(@"密码输入完成: %@", textField.text);
    })
    .tfShouldClear(^BOOL(UITextField *textField) {
        NSLog(@"用户点击清除按钮");
        return YES;
    })
    .tfShouldReturn(^BOOL(UITextField *textField) {
        [textField resignFirstResponder];
        return YES;
    });
}


- (void)textView_Example
{
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(20, 600, 300, 200)];
    textView.okidoki
    .addToSuperview(self.view)
    .text(@"Hello World")
    .font(@"16")
    .color(@"333333")
    .bgColor(@"F5F5F5")
    .editable(@YES)
    .selectable(@YES)
    .textContainerInset([NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)])
    .addToSuperview(self.view);


    // 代理方法
    textView.okidoki
    .tvShouldBeginEditing(^BOOL(UITextView *textView) {
        NSLog(@"准备开始编辑");
        return YES;
    })
    .tvDidBeginEditing(^(UITextView *textView) {
        NSLog(@"已开始编辑");
        textView.layer.borderColor = [UIColor blueColor].CGColor;
        textView.layer.borderWidth = 1.0;
    })
    .tvShouldEndEditing(^BOOL(UITextView *textView) {
        NSLog(@"准备结束编辑");
        return YES;
    })
    .tvDidEndEditing(^(UITextView *textView) {
        NSLog(@"已结束编辑");
        textView.layer.borderWidth = 0;
    })
    .tvDidChange(^(UITextView *textView) {
        NSLog(@"文本已改变: %@", textView.text);
    })
    .tvDidChangeSelection(^(UITextView *textView) {
        NSLog(@"选择改变");
    })
    .tvInputLimit(OkidokiInputLimitTypeDigital | OkidokiInputLimitTypeAlphabetUpper, 10, nil, ^(NSString *original, NSString *matched) {
        // 限制只能输入数字和大写字母,且最大长度为 10
        NSLog(@"Input changed: %@ -> %@", original, matched);
    })
    .tvShouldChangeText(^BOOL(UITextView *textView, NSRange range, NSString *replacementText) {
        // 限制输入长度
//        if (replacementText.length > 0 && textView.text.length >= 100) {
//            return NO;
//        }
//        // 禁止输入换行
//        if ([replacementText isEqualToString:@"\n"]) {
//            [textView resignFirstResponder];
//            return NO;
//        }
        return YES;
    }).keyboardHandler(^(NSNotificationName name, CGRect beginFrame, CGRect endFrame, CGFloat duration, UIViewAnimationCurve curve) {
        if ([name isEqualToString:UIKeyboardWillShowNotification]) {
            CGFloat keyboardY = endFrame.origin.y;
            CGFloat fieldMaxY = CGRectGetMaxY(textView.frame);
            
            if (fieldMaxY > keyboardY) {
                // 输入框被键盘遮挡，需要调整
                CGFloat offset = fieldMaxY - keyboardY + 10; // 额外留10px间距
                
                [UIView animateWithDuration:duration
                                      delay:0
                                    options:curve << 16
                                 animations:^{
                    textView.transform = CGAffineTransformMakeTranslation(0, -offset);
                } completion:nil];
            }
        } else if ([name isEqualToString:UIKeyboardWillHideNotification]) {
            [UIView animateWithDuration:duration
                                  delay:0
                                options:curve << 16
                             animations:^{
                textView.transform = CGAffineTransformIdentity;
            } completion:nil];
        }
    });


    // 新版 API（iOS 26+）- 支持多范围编辑
    if (@available(iOS 26.0, *)) {
        textView.okidoki.tvShouldChangeTextInRanges(^BOOL(UITextView *textView, NSArray<NSValue *> *ranges, NSString *replacementText) {
            // 新版 API 支持同时处理多个范围的文本变化
            NSLog(@"将在 %ld 个范围内替换文本", (long)ranges.count);
            
            // 计算替换后的总长度
            NSInteger totalLength = textView.text.length;
            for (NSValue *rangeValue in ranges) {
                NSRange range = [rangeValue rangeValue];
                totalLength = totalLength - range.length + replacementText.length;
            }
            
            // 限制总长度
            if (totalLength > 200) {
                NSLog(@"文本长度超出限制");
                return NO;
            }
            
            return YES;
        });
    }
}

@end
