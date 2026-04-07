//
//  TestsTests.m
//  TestsTests
//
//  Created by HaoCold on 2020/7/30.
//  Copyright © 2020 HaoCold. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Okidoki.h"

@interface TestsTests : XCTestCase

@end

@implementation TestsTests

- (void)setUp {
}

- (void)tearDown {
}

- (void)testView {
    UIView *view = [[UIView alloc] init];
    
    view.okidoki.tag(@"1");
    XCTAssert(view.tag == 1, @"");
    
    view.okidoki.tag(@2);
    XCTAssert(view.tag == 2, @"");
    
    view.okidoki.frame([NSValue valueWithCGRect:CGRectMake(0, 1, 2, 3)]);
    XCTAssert(CGRectEqualToRect(view.frame , CGRectMake(0, 1, 2, 3)), @"");
    
    view.okidoki.frame(@"{{4,5},{6,7}}");
    XCTAssert(CGRectEqualToRect(view.frame , CGRectMake(4, 5, 6, 7)), @"");
    
    view.okidoki.alpha(@"0.5");
    XCTAssert(view.alpha == 0.5, @"");
    
    view.okidoki.alpha(@(0.7));
    XCTAssert(fabs(view.alpha - 0.7) < 0.000001, @"");
    
    view.okidoki.hidden(@"1");
    XCTAssert(view.hidden == YES, @"");
    
    view.okidoki.hidden(@0);
    XCTAssert(view.hidden == NO, @"");
    
    view.okidoki.bgColor([UIColor blackColor]);
    XCTAssert([view.backgroundColor isEqual:[UIColor blackColor]], @"");
    
    view.okidoki.bgColor(@"ff0000");
    XCTAssert([view.backgroundColor isEqual:[UIColor redColor]], @"");
    
    view.okidoki.bgColor(@"#00ff00");
    XCTAssert([view.backgroundColor isEqual:[UIColor greenColor]], @"");
    
    view.okidoki.bgColor(@"0x0000ff");
    XCTAssert([view.backgroundColor isEqual:[UIColor blueColor]], @"");
    
    view.okidoki.bdColor([UIColor blackColor]);
    XCTAssert([[UIColor colorWithCGColor:view.layer.borderColor] isEqual:[UIColor blackColor]], @"");
    
    view.okidoki.bdColor(@"ff0000");
    XCTAssert([[UIColor colorWithCGColor:view.layer.borderColor]  isEqual:[UIColor redColor]], @"");
    
    view.okidoki.bdColor(@"#00ff00");
    XCTAssert([[UIColor colorWithCGColor:view.layer.borderColor]  isEqual:[UIColor greenColor]], @"");
    
    view.okidoki.bdColor(@"0x0000ff");
    XCTAssert([[UIColor colorWithCGColor:view.layer.borderColor]  isEqual:[UIColor blueColor]], @"");
    
    view.okidoki.bdWidth(@"1");
    XCTAssert(view.layer.borderWidth == 1, @"");
    
    view.okidoki.bdWidth(@"1.5");
    XCTAssert(view.layer.borderWidth == 1.5, @"");
    
    view.okidoki.bdWidth(@2);
    XCTAssert(view.layer.borderWidth == 2, @"");
    
    view.okidoki.bdWidth(@2.5);
    XCTAssert(view.layer.borderWidth == 2.5, @"");
    
    view.okidoki.cnRadius(@"1");
    XCTAssert(view.layer.cornerRadius == 1, @"");
    
    view.okidoki.cnRadius(@"0.6");
    XCTAssert(fabs(view.layer.cornerRadius - 0.6) < 0.000001, @"");
    
    view.okidoki.cnRadius(@"0.7");
    XCTAssert(fabs(view.layer.cornerRadius - 0.7) < 0.000001, @"");
    
    view.okidoki.cnRadius(@0.8);
    XCTAssert(fabs(view.layer.cornerRadius - 0.8) < 0.000001, @"");
    
    view.okidoki.mkCorners(@[@1, @2, @3, @4]);
    XCTAssert(view.layer.maskedCorners == (kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner | kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner), @"");
    
    view.okidoki.mtBounds(@"1");
    XCTAssert(view.layer.masksToBounds == YES, @"");
    
    view.okidoki.mtBounds(@1);
    XCTAssert(view.layer.masksToBounds == YES, @"");
    
    view.okidoki.mtBounds(@(-1));
    XCTAssert(view.layer.masksToBounds == YES, @"");
    
    view.okidoki.mtBounds(@(+1));
    XCTAssert(view.layer.masksToBounds == YES, @"");
    
    view.okidoki.mtBounds(@"y");
    XCTAssert(view.layer.masksToBounds == YES, @"");
    
    view.okidoki.mtBounds(@"ya");
    XCTAssert(view.layer.masksToBounds == YES, @"");
    
    view.okidoki.mtBounds(@"Y");
    XCTAssert(view.layer.masksToBounds == YES, @"");
    
    view.okidoki.mtBounds(@"t");
    XCTAssert(view.layer.masksToBounds == YES, @"");
    
    view.okidoki.mtBounds(@"T");
    XCTAssert(view.layer.masksToBounds == YES, @"");
    
    view.okidoki.mtBounds(@"a");
    XCTAssert(view.layer.masksToBounds == NO, @"");
    
    view.okidoki.mtBounds(@"0");
    XCTAssert(view.layer.masksToBounds == NO, @"");
    
    view.okidoki.mtBounds(@0);
    XCTAssert(view.layer.masksToBounds == NO, @"");
    
    view.okidoki.mtBounds(@"f");
    XCTAssert(view.layer.masksToBounds == NO, @"");
    
    view.okidoki.mtBounds(@"n");
    XCTAssert(view.layer.masksToBounds == NO, @"");
    
    view.okidoki.shadowColor([UIColor redColor]);
    XCTAssert([[UIColor colorWithCGColor:view.layer.shadowColor] isEqual:[UIColor redColor]], @"");
    
    view.okidoki.shadowColor(@"ff0000");
    XCTAssert([[UIColor colorWithCGColor:view.layer.shadowColor] isEqual:[UIColor redColor]], @"");
    
    view.okidoki.shadowOpacity(@"0.5");
    XCTAssert(view.layer.shadowOpacity == 0.5, @"");
    
    view.okidoki.shadowOpacity(@0.7);
    XCTAssert(fabs(view.layer.shadowOpacity - 0.7) < 0.000001, @"");
    
    view.okidoki.shadowOffset([NSValue valueWithCGSize:CGSizeMake(1, 2)]);
    CGSize offset = view.layer.shadowOffset;
    XCTAssert(offset.width == 1 && offset.height == 2, @"");
    
    view.okidoki.shadowOffset(@"{1,2}");
    offset = view.layer.shadowOffset;
    XCTAssert(offset.width == 1 && offset.height == 2, @"");
    
    view.okidoki.shadowRadius(@"3");
    XCTAssert(view.layer.shadowRadius == 3, @"");
    
    view.okidoki.shadowRadius(@4.5);
    XCTAssert(view.layer.shadowRadius == 4.5, @"");
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 10, 10)];
    view.okidoki.shadowPath(path);
    XCTAssert(CGPathEqualToPath(view.layer.shadowPath, path.CGPath), @"");
    
    UIView *subview = [[UIView alloc] init];
    view.okidoki.addSubview(subview);
    XCTAssert(subview.superview == view, @"");
    
    UIView *subview2 = [[UIView alloc] init];
    view.okidoki.addSubviewWithConfig(subview2, ^(Okidoki *ok) {
        ok.bgColor(@"00ff00");
    });
    XCTAssert(subview2.superview == view && [subview2.backgroundColor isEqual:[UIColor greenColor]], @"");
    
    UIView *subview3 = [[UIView alloc] init];
    view.okidoki.addSubviewWithConfig_superView(subview3, ^(Okidoki *ok, UIView *superView) {
        ok.bgColor(@"0000ff");
    });
    XCTAssert(subview3.superview == view && [subview3.backgroundColor isEqual:[UIColor blueColor]], @"");
    
    UIView *subview4 = [[UIView alloc] init];
    subview4.okidoki.addToSuperview(view);
    XCTAssert(subview4.superview == view, @"");
    
    view.okidoki.userInteractionEnabled(@"1");
    XCTAssert(view.userInteractionEnabled == YES, @"");
    
    view.okidoki.userInteractionEnabled(@0);
    XCTAssert(view.userInteractionEnabled == NO, @"");
}

- (void)testGesture {
    UIView *view = [[UIView alloc] init];
    
    __block BOOL tapped = NO;
    view.okidoki.tapGesture(^(UITapGestureRecognizer *tap) {
        tapped = YES;
    });
    UITapGestureRecognizer *tapGesture = (UITapGestureRecognizer *)[view gestureRecognizers][0];
    XCTAssert([tapGesture isKindOfClass:[UITapGestureRecognizer class]], @"");
    
    __block BOOL longPressed = NO;
    view.okidoki.longPressGesture(^(UILongPressGestureRecognizer *longPress) {
        longPressed = YES;
    });
    UILongPressGestureRecognizer *longPressGesture = (UILongPressGestureRecognizer *)[view gestureRecognizers][1];
    XCTAssert([longPressGesture isKindOfClass:[UILongPressGestureRecognizer class]], @"");
    
    __block BOOL swiped = NO;
    view.okidoki.swipeGesture(UISwipeGestureRecognizerDirectionLeft, ^(UISwipeGestureRecognizer *swipe) {
        swiped = YES;
    });
    UISwipeGestureRecognizer *swipeGesture = (UISwipeGestureRecognizer *)[view gestureRecognizers][2];
    XCTAssert([swipeGesture isKindOfClass:[UISwipeGestureRecognizer class]], @"");
    
    __block BOOL panned = NO;
    view.okidoki.panGesture(^(UIPanGestureRecognizer *pan) {
        panned = YES;
    });
    UIPanGestureRecognizer *panGesture = (UIPanGestureRecognizer *)[view gestureRecognizers][3];
    XCTAssert([panGesture isKindOfClass:[UIPanGestureRecognizer class]], @"");
    
    __block BOOL pinched = NO;
    view.okidoki.pinchGesture(^(UIPinchGestureRecognizer *pinch) {
        pinched = YES;
    });
    UIPinchGestureRecognizer *pinchGesture = (UIPinchGestureRecognizer *)[view gestureRecognizers][4];
    XCTAssert([pinchGesture isKindOfClass:[UIPinchGestureRecognizer class]], @"");
    
    __block BOOL rotated = NO;
    view.okidoki.rotationGesture(^(UIRotationGestureRecognizer *rotation) {
        rotated = YES;
    });
    UIRotationGestureRecognizer *rotationGesture = (UIRotationGestureRecognizer *)[view gestureRecognizers][5];
    XCTAssert([rotationGesture isKindOfClass:[UIRotationGestureRecognizer class]], @"");
    
    view.okidoki.removeGesture([UITapGestureRecognizer class]);
    XCTAssert([view gestureRecognizers].count == 5, @"");
    
    view.okidoki.removeAllGestures();
    XCTAssert([view gestureRecognizers].count == 0, @"");
}

- (void)testLabel{
    UILabel *label = [[UILabel alloc] init];
    
    label.okidoki.text(@"123");
    XCTAssert([label.text isEqualToString:@"123"], @"");
    
    label.okidoki.font(@"12");
    XCTAssert([label.font isEqual:[UIFont systemFontOfSize:12]], @"");
    
    label.okidoki.font(@"b13");
    XCTAssert([label.font isEqual:[UIFont boldSystemFontOfSize:13]], @"");
    
    label.okidoki.font(@"i14");
    XCTAssert([label.font isEqual:[UIFont italicSystemFontOfSize:14]], @"");
    
    label.okidoki.font([UIFont systemFontOfSize:15]);
    XCTAssert([label.font isEqual:[UIFont systemFontOfSize:15]], @"");
    
    label.okidoki.font([UIFont boldSystemFontOfSize:16]);
    XCTAssert([label.font isEqual:[UIFont boldSystemFontOfSize:16]], @"");
    
    label.okidoki.font([UIFont italicSystemFontOfSize:17]);
    XCTAssert([label.font isEqual:[UIFont italicSystemFontOfSize:17]], @"");
    
    label.okidoki.color([UIColor blackColor]);
    XCTAssert([label.textColor isEqual:[UIColor blackColor]], @"");
    
    label.okidoki.color(@"ff0000");
    XCTAssert([label.textColor isEqual:[UIColor redColor]], @"");
    
    label.okidoki.color(@"#00ff00");
    XCTAssert([label.textColor isEqual:[UIColor greenColor]], @"");
    
    label.okidoki.color(@"0x0000ff");
    XCTAssert([label.textColor isEqual:[UIColor blueColor]], @"");
    
    label.okidoki.align(@0);
    XCTAssert(label.textAlignment == NSTextAlignmentLeft, @"");
    
    label.okidoki.align(@1);
    XCTAssert(label.textAlignment == NSTextAlignmentCenter, @"");
    
    label.okidoki.align(@2);
    XCTAssert(label.textAlignment == NSTextAlignmentRight, @"");
    
    label.okidoki.align(@"0");
    XCTAssert(label.textAlignment == NSTextAlignmentLeft, @"");
    
    label.okidoki.align(@"1");
    XCTAssert(label.textAlignment == NSTextAlignmentCenter, @"");
    
    label.okidoki.align(@"2");
    XCTAssert(label.textAlignment == NSTextAlignmentRight, @"");
    
    label.okidoki.lines(@2);
    XCTAssert(label.numberOfLines == 2, @"");
    
    label.okidoki.lines(@"3");
    XCTAssert(label.numberOfLines == 3, @"");
    
    label.okidoki.adjust(@0);
    XCTAssert(label.adjustsFontSizeToFitWidth == NO, @"");
    
    label.okidoki.adjust(@1);
    XCTAssert(label.adjustsFontSizeToFitWidth == YES, @"");
    
    label.okidoki.adjust(@"0");
    XCTAssert(label.adjustsFontSizeToFitWidth == NO, @"");
    
    label.okidoki.adjust(@"1");
    XCTAssert(label.adjustsFontSizeToFitWidth == YES, @"");
    
    label.okidoki.autoWidth(@100);
    XCTAssert(label.ok_width <= 100, @"");
    
    label.okidoki.autoWidth(@"200");
    XCTAssert(label.ok_width <= 200, @"");
    
    label.okidoki.autoHeight(@50);
    XCTAssert(label.ok_height <= 50, @"");
    
    label.okidoki.autoHeight(@"150");
    XCTAssert(label.ok_height <= 150, @"");
    
    label.okidoki.highlightedTextColor(@"ff0000");
    XCTAssert([label.highlightedTextColor isEqual:[UIColor redColor]], @"");
    
    label.okidoki.highlightedTextColor([UIColor blueColor]);
    XCTAssert([label.highlightedTextColor isEqual:[UIColor blueColor]], @"");
    
    label.okidoki.text(@"haha123");
    label.okidoki.attributedSubstring(@"haha", [UIColor redColor]);
    
    NSMutableAttributedString *matts = [[NSMutableAttributedString alloc] initWithString:@"haha123"];
    [matts addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:[@"haha123" rangeOfString:@"haha"]];
    
    NSRange range = [@"haha123" rangeOfString:@"haha"];
    
    __block NSDictionary *dic1;
    [label.attributedText enumerateAttributesInRange:range options:0 usingBlock:^(NSDictionary<NSAttributedStringKey,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        dic1 = attrs;
    }];
    
    __block NSDictionary *dic2;
    [matts enumerateAttributesInRange:range options:0 usingBlock:^(NSDictionary<NSAttributedStringKey,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        dic2 = attrs;
    }];
    
    XCTAssert([dic1[@"NSColor"] isEqual:dic2[@"NSColor"]],@"");
    
    label.okidoki.text(@"foo456");
    label.okidoki.attributedSubstring(@"456", [UIFont systemFontOfSize:14]);
    
    NSMutableAttributedString *matts2 = [[NSMutableAttributedString alloc] initWithString:@"foo456"];
    [matts2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:[@"foo456" rangeOfString:@"456"]];
    
    NSRange range2 = [@"foo456" rangeOfString:@"456"];
    
    __block NSDictionary *dic3;
    [label.attributedText enumerateAttributesInRange:range2 options:0 usingBlock:^(NSDictionary<NSAttributedStringKey,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        dic3 = attrs;
    }];
    
    __block NSDictionary *dic4;
    [matts2 enumerateAttributesInRange:range2 options:0 usingBlock:^(NSDictionary<NSAttributedStringKey,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        dic4 = attrs;
    }];
    
    XCTAssert([dic3[@"NSFont"] isEqual:dic4[@"NSFont"]],@"");
    
    NSRange range3 = NSMakeRange(2, 2);
    
    label.okidoki.text(@"haha123");
    label.okidoki.attributedSubstringInRange(@"haha", [UIColor redColor], [NSValue valueWithRange:range3]);
    
    NSMutableAttributedString *matts3 = [[NSMutableAttributedString alloc] initWithString:@"haha123"];
    [matts3 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range3];
    
    __block NSDictionary *dic5;
    [label.attributedText enumerateAttributesInRange:range3 options:0 usingBlock:^(NSDictionary<NSAttributedStringKey,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        dic5 = attrs;
    }];
    
    __block NSDictionary *dic6;
    [matts3 enumerateAttributesInRange:range3 options:0 usingBlock:^(NSDictionary<NSAttributedStringKey,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        dic6 = attrs;
    }];
    
    XCTAssert([dic5[@"NSColor"] isEqual:dic6[@"NSColor"]],@"");
    
    NSRange range4 = NSMakeRange(3, 3);
    
    label.okidoki.text(@"foofoo456");
    label.okidoki.attributedSubstringInRange(@"456", [UIFont systemFontOfSize:14], [NSValue valueWithRange:range4]);
    
    NSMutableAttributedString *matts4 = [[NSMutableAttributedString alloc] initWithString:@"foofoo456"];
    [matts4 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:range4];
    
    __block NSDictionary *dic7;
    [label.attributedText enumerateAttributesInRange:range4 options:0 usingBlock:^(NSDictionary<NSAttributedStringKey,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        dic7 = attrs;
    }];
    
    __block NSDictionary *dic8;
    [matts4 enumerateAttributesInRange:range4 options:0 usingBlock:^(NSDictionary<NSAttributedStringKey,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        dic8 = attrs;
    }];
    
    XCTAssert([dic7[@"NSFont"] isEqual:dic8[@"NSFont"]],@"");
    
    label.okidoki.text(@"Hello World");
    label.okidoki.attributedSubstringKeyValue(@"World", NSForegroundColorAttributeName, [UIColor redColor]);
    
    NSMutableAttributedString *matts5 = [[NSMutableAttributedString alloc] initWithString:@"Hello World"];
    [matts5 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:[@"Hello World" rangeOfString:@"World"]];
    
    NSRange range5 = [@"Hello World" rangeOfString:@"World"];
    
    __block NSDictionary *dic9;
    [label.attributedText enumerateAttributesInRange:range5 options:0 usingBlock:^(NSDictionary<NSAttributedStringKey,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        dic9 = attrs;
    }];
    
    __block NSDictionary *dic10;
    [matts5 enumerateAttributesInRange:range5 options:0 usingBlock:^(NSDictionary<NSAttributedStringKey,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        dic10 = attrs;
    }];
    
    XCTAssert([dic9[@"NSColor"] isEqual:dic10[@"NSColor"]],@"");
    
    NSRange range6 = NSMakeRange(6, 5);
    
    label.okidoki.text(@"Hello World");
    label.okidoki.attributedSubstringKeyValueInRange(@"World", NSForegroundColorAttributeName, [UIColor redColor], [NSValue valueWithRange:range6]);
    
    NSMutableAttributedString *matts6 = [[NSMutableAttributedString alloc] initWithString:@"Hello World"];
    [matts6 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range6];
    
    __block NSDictionary *dic11;
    [label.attributedText enumerateAttributesInRange:range6 options:0 usingBlock:^(NSDictionary<NSAttributedStringKey,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        dic11 = attrs;
    }];
    
    __block NSDictionary *dic12;
    [matts6 enumerateAttributesInRange:range6 options:0 usingBlock:^(NSDictionary<NSAttributedStringKey,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        dic12 = attrs;
    }];
    
    XCTAssert([dic11[@"NSColor"] isEqual:dic12[@"NSColor"]],@"");
}

- (void)testControl {
    UIControl *control = [[UIControl alloc] init];
    control.accessibilityIdentifier = @"UIControl";
    
    control.okidoki.enabled(@"1");
    XCTAssert(control.enabled == YES, @"");
    
    control.okidoki.enabled(@0);
    XCTAssert(control.enabled == NO, @"");
    
    control.okidoki.selected(@"1");
    XCTAssert(control.selected == YES, @"");
    
    control.okidoki.selected(@0);
    XCTAssert(control.selected == NO, @"");
    
    // UIControl.highlighted 属性测试
    // Note: 由于 iOS 内部状态管理，在同一对象上连续设置 enabled + selected 后，
    // highlighted 可能无法正常工作，所以这里使用新对象测试
    UIControl *controlForHighlighted = UIControl.new;
    controlForHighlighted.okidoki.highlighted(@"1");
    XCTAssert(controlForHighlighted.highlighted == YES, @"");
    
    controlForHighlighted.okidoki.highlighted(@0);
    XCTAssert(controlForHighlighted.highlighted == NO, @"");
    XCTAssert(control.highlighted == NO, @"");
    
    control.okidoki.contentVerticalAlignment(@0);
    XCTAssert(control.contentVerticalAlignment == UIControlContentVerticalAlignmentCenter, @"");
    
    control.okidoki.contentVerticalAlignment(@1);
    XCTAssert(control.contentVerticalAlignment == UIControlContentVerticalAlignmentTop, @"");
    
    control.okidoki.contentVerticalAlignment(@2);
    XCTAssert(control.contentVerticalAlignment == UIControlContentVerticalAlignmentBottom, @"");
    
    control.okidoki.contentVerticalAlignment(@3);
    XCTAssert(control.contentVerticalAlignment == UIControlContentVerticalAlignmentFill, @"");
    
    control.okidoki.contentHorizontalAlignment(@0);
    XCTAssert(control.contentHorizontalAlignment == UIControlContentHorizontalAlignmentCenter, @"");
    
    control.okidoki.contentHorizontalAlignment(@1);
    XCTAssert(control.contentHorizontalAlignment == UIControlContentHorizontalAlignmentLeft, @"");
    
    control.okidoki.contentHorizontalAlignment(@2);
    XCTAssert(control.contentHorizontalAlignment == UIControlContentHorizontalAlignmentRight, @"");
    
    control.okidoki.contentHorizontalAlignment(@3);
    XCTAssert(control.contentHorizontalAlignment == UIControlContentHorizontalAlignmentFill, @"");
    
    control.okidoki.contentHorizontalAlignment(@4);
    XCTAssert(control.contentHorizontalAlignment == UIControlContentHorizontalAlignmentLeading, @"");
    
    control.okidoki.contentHorizontalAlignment(@5);
    XCTAssert(control.contentHorizontalAlignment == UIControlContentHorizontalAlignmentTrailing, @"");
    
    __block BOOL eventFired = NO;
    control.okidoki.addControlEvent(UIControlEventTouchUpInside, ^(UIControl *sender) {
        eventFired = !eventFired;
    });
    
    [control sendActionsForControlEvents:UIControlEventTouchUpInside];
    XCTAssert(eventFired == YES, @"");
    
    control.okidoki.removeControlEvent(UIControlEventTouchUpInside);
    [control sendActionsForControlEvents:UIControlEventTouchUpInside];
    XCTAssert(eventFired == YES, @"移除事件后，block 不应再执行，eventFired 应保持 YES");
    
    control.okidoki.addControlEvent(UIControlEventTouchDown, ^(UIControl *sender) {
        
    });
    NSLog(@"before control.allControlEvents = %@, control.allTargets = %@", @(control.allControlEvents), control.allTargets);
    control.okidoki.removeAllControlEvents();
    NSLog(@"after control.allControlEvents = %@, control.allTargets = %@", @(control.allControlEvents), control.allTargets);
}

- (void)testButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    
    button.okidoki.title(@"Title");
    XCTAssert([[button titleForState:UIControlStateNormal] isEqualToString:@"Title"], @"");
    
    button.okidoki.titleForState(@"Highlighted", @(UIControlStateHighlighted));
    XCTAssert([[button titleForState:UIControlStateHighlighted] isEqualToString:@"Highlighted"], @"");
    
    button.okidoki.colorForState(@"ff0000", @(UIControlStateNormal));
    XCTAssert([[button titleColorForState:UIControlStateNormal] isEqual:[UIColor redColor]], @"");
    
    button.okidoki.colorForState([UIColor blueColor], @(UIControlStateHighlighted));
    XCTAssert([[button titleColorForState:UIControlStateHighlighted] isEqual:[UIColor blueColor]], @"");
    
    button.okidoki.imageForState(@"001", @(UIControlStateNormal));
    XCTAssert(button.currentImage != nil, @"");
    
    button.okidoki.bgImageForState(@"001", @(UIControlStateNormal));
    XCTAssert([button backgroundImageForState:UIControlStateNormal] != nil, @"");
    
    button.okidoki.highlighted(@"1");
    XCTAssert(button.highlighted == YES, @"");
    
    button.okidoki.highlighted(@0);
    XCTAssert(button.highlighted == NO, @"");
    
    button.okidoki.lineSpaceForState(@5, @(UIControlStateNormal));
    
    button.okidoki.imageUpTitleDown(@10);
    
    button.okidoki.imageDownTitleUp(@15);
    
    button.okidoki.imageRightTitleLeft(@20);
    
    button.okidoki.imageLeftTitleRight(@25);
    
    button.okidoki.imageCenterTitleCenter();
    
    // 测试连续调用 attributedSubstringForState
    button.okidoki.titleForState(@"Hello World", @(UIControlStateNormal));
    button.okidoki.attributedSubstringForState(@"Hello", [UIColor redColor], @(UIControlStateNormal));
    button.okidoki.attributedSubstringForState(@"World", [UIColor blueColor], @(UIControlStateNormal));
    
    button.okidoki.attributedSubstringInRangeForState(@"World", [UIColor redColor], [NSValue valueWithRange:NSMakeRange(6, 5)], @(UIControlStateNormal));
    
    button.okidoki.attributedSubstringKeyValueForState(@"World", NSForegroundColorAttributeName, [UIColor redColor], @(UIControlStateNormal));
    
    button.okidoki.attributedSubstringKeyValueInRangeForState(@"World", NSForegroundColorAttributeName, [UIColor redColor], [NSValue valueWithRange:NSMakeRange(6, 5)], @(UIControlStateNormal));
}

- (void)testImageView {
    UIImageView *imageView = [[UIImageView alloc] init];
    
    imageView.okidoki.image(@"001");
    XCTAssert(imageView.image != nil, @"");
    
    imageView.okidoki.highlightedImage(@"001");
    XCTAssert(imageView.highlightedImage != nil, @"");
    
    imageView.okidoki.imageForTintColor(@"001", [UIColor redColor]);
    XCTAssert(imageView.tintColor != nil, @"");
}

- (void)testTextField {
    UITextField *textField = [[UITextField alloc] init];
    
    textField.okidoki.bdStyle(@3);
    XCTAssert(textField.borderStyle == UITextBorderStyleRoundedRect, @"");
    
    textField.okidoki.bdStyle(@"1");
    XCTAssert(textField.borderStyle == UITextBorderStyleLine, @"");
    
    textField.okidoki.pHolder(@"Placeholder");
    XCTAssert([textField.placeholder isEqualToString:@"Placeholder"], @"");
    
    textField.okidoki.cbMode(@0);
    XCTAssert(textField.clearButtonMode == UITextFieldViewModeNever, @"");
    
    textField.okidoki.cbMode(@"1");
    XCTAssert(textField.clearButtonMode == UITextFieldViewModeWhileEditing, @"");
    
    textField.okidoki.cbMode(@2);
    XCTAssert(textField.clearButtonMode == UITextFieldViewModeUnlessEditing, @"");
    
    textField.okidoki.cbMode(@3);
    XCTAssert(textField.clearButtonMode == UITextFieldViewModeAlways, @"");
    
    textField.okidoki.lvMode(@0);
    XCTAssert(textField.leftViewMode == UITextFieldViewModeNever, @"");
    
    textField.okidoki.lvMode(@"1");
    XCTAssert(textField.leftViewMode == UITextFieldViewModeWhileEditing, @"");
    
    textField.okidoki.lvMode(@2);
    XCTAssert(textField.leftViewMode == UITextFieldViewModeUnlessEditing, @"");
    
    textField.okidoki.lvMode(@3);
    XCTAssert(textField.leftViewMode == UITextFieldViewModeAlways, @"");
    
    textField.okidoki.rvMode(@0);
    XCTAssert(textField.rightViewMode == UITextFieldViewModeNever, @"");
    
    textField.okidoki.rvMode(@"1");
    XCTAssert(textField.rightViewMode == UITextFieldViewModeWhileEditing, @"");
    
    textField.okidoki.rvMode(@2);
    XCTAssert(textField.rightViewMode == UITextFieldViewModeUnlessEditing, @"");
    
    textField.okidoki.rvMode(@3);
    XCTAssert(textField.rightViewMode == UITextFieldViewModeAlways, @"");
    
    UIView *leftView = [[UIView alloc] init];
    textField.okidoki.lfView(leftView);
    XCTAssert(textField.leftView == leftView, @"");
    
    UIView *rightView = [[UIView alloc] init];
    textField.okidoki.rtView(rightView);
    XCTAssert(textField.rightView == rightView, @"");
    
    textField.okidoki.secure(@YES);
    XCTAssert(textField.secureTextEntry == YES, @"");
    
    textField.okidoki.secure(@NO);
    XCTAssert(textField.secureTextEntry == NO, @"");
}

- (void)testScrollView {
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    
    scrollView.okidoki.contentOffset([NSValue valueWithCGPoint:CGPointMake(10, 20)]);
    XCTAssert(CGPointEqualToPoint(scrollView.contentOffset, CGPointMake(10, 20)), @"");
    
    scrollView.okidoki.contentSize([NSValue valueWithCGSize:CGSizeMake(100, 200)]);
    XCTAssert(CGSizeEqualToSize(scrollView.contentSize, CGSizeMake(100, 200)), @"");
    
    scrollView.okidoki.contentInset([NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(5, 10, 15, 20)]);
    XCTAssert(UIEdgeInsetsEqualToEdgeInsets(scrollView.contentInset, UIEdgeInsetsMake(5, 10, 15, 20)), @"");
    
    scrollView.okidoki.directionalLockEnabled(@"1");
    XCTAssert(scrollView.directionalLockEnabled == YES, @"");
    
    scrollView.okidoki.directionalLockEnabled(@0);
    XCTAssert(scrollView.directionalLockEnabled == NO, @"");
    
    scrollView.okidoki.alwaysBounceVertical(@"1");
    XCTAssert(scrollView.alwaysBounceVertical == YES, @"");
    
    scrollView.okidoki.alwaysBounceHorizontal(@"1");
    XCTAssert(scrollView.alwaysBounceHorizontal == YES, @"");
    
    scrollView.okidoki.scrollEnabled(@"1");
    XCTAssert(scrollView.scrollEnabled == YES, @"");
    
    scrollView.okidoki.scrollEnabled(@0);
    XCTAssert(scrollView.scrollEnabled == NO, @"");
    
    scrollView.okidoki.indicatorStyle(@0);
    XCTAssert(scrollView.indicatorStyle == UIScrollViewIndicatorStyleDefault, @"");
    
    scrollView.okidoki.indicatorStyle(@"1");
    XCTAssert(scrollView.indicatorStyle == UIScrollViewIndicatorStyleBlack, @"");
    
    scrollView.okidoki.indicatorStyle(@2);
    XCTAssert(scrollView.indicatorStyle == UIScrollViewIndicatorStyleWhite, @"");
    
    scrollView.okidoki.delaysContentTouches(@"1");
    XCTAssert(scrollView.delaysContentTouches == YES, @"");
    
    scrollView.okidoki.delaysContentTouches(@0);
    XCTAssert(scrollView.delaysContentTouches == NO, @"");
    
    scrollView.okidoki.canCancelContentTouches(@"1");
    XCTAssert(scrollView.canCancelContentTouches == YES, @"");
    
    scrollView.okidoki.canCancelContentTouches(@0);
    XCTAssert(scrollView.canCancelContentTouches == NO, @"");
    
    scrollView.okidoki.minimumZoomScale(@"0.5");
    XCTAssert(scrollView.minimumZoomScale == 0.5, @"");
    
    scrollView.okidoki.minimumZoomScale(@1);
    XCTAssert(scrollView.minimumZoomScale == 1, @"");
    
    scrollView.okidoki.maximumZoomScale(@"2");
    XCTAssert(scrollView.maximumZoomScale == 2, @"");
    
    scrollView.okidoki.maximumZoomScale(@3);
    XCTAssert(scrollView.maximumZoomScale == 3, @"");
    
    scrollView.okidoki.bouncesZoom(@"1");
    XCTAssert(scrollView.bouncesZoom == YES, @"");
    
    scrollView.okidoki.bouncesZoom(@0);
    XCTAssert(scrollView.bouncesZoom == NO, @"");
    
    scrollView.okidoki.scrollsToTop(@"1");
    XCTAssert(scrollView.scrollsToTop == YES, @"");
    
    scrollView.okidoki.scrollsToTop(@0);
    XCTAssert(scrollView.scrollsToTop == NO, @"");
    
    scrollView.okidoki.decelerationRate(@"0.9");
    XCTAssert(scrollView.decelerationRate == UIScrollViewDecelerationRateFast, @"");
    
    scrollView.okidoki.decelerationRate(@"0.99");
    XCTAssert(fabs(scrollView.decelerationRate - 0.99) < 0.000001, @"");
    
    // UIScrollView 的 zoomScale 需要：
    // 1. 创建一个 view 并添加到 scrollView 中
    // 2. 设置 viewForZooming block 返回这个 view
    UIView *zoomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [scrollView addSubview:zoomView];
    scrollView.okidoki.viewForZooming(^UIView *(UIScrollView *sv) {
        return zoomView;
    });
    
    scrollView.okidoki.zoomScale(@"1.5");
    XCTAssert(scrollView.zoomScale == 1.5, @"");
    
    scrollView.okidoki.zoomScale(@2);
    XCTAssert(scrollView.zoomScale == 2, @"");
    
    scrollView.okidoki.keyboardDismissMode(@0);
    XCTAssert(scrollView.keyboardDismissMode == UIScrollViewKeyboardDismissModeNone, @"");
    
    scrollView.okidoki.keyboardDismissMode(@"1");
    XCTAssert(scrollView.keyboardDismissMode == UIScrollViewKeyboardDismissModeOnDrag, @"");
    
    scrollView.okidoki.keyboardDismissMode(@2);
    XCTAssert(scrollView.keyboardDismissMode == UIScrollViewKeyboardDismissModeInteractive, @"");
    
    scrollView.okidoki.contentInsetAdjustmentBehavior(@0);
    XCTAssert(scrollView.contentInsetAdjustmentBehavior == UIScrollViewContentInsetAdjustmentAutomatic, @"");
    
    scrollView.okidoki.contentInsetAdjustmentBehavior(@"1");
    XCTAssert(scrollView.contentInsetAdjustmentBehavior == UIScrollViewContentInsetAdjustmentScrollableAxes, @"");
    
    scrollView.okidoki.contentInsetAdjustmentBehavior(@2);
    XCTAssert(scrollView.contentInsetAdjustmentBehavior == UIScrollViewContentInsetAdjustmentNever, @"");
    
    scrollView.okidoki.contentInsetAdjustmentBehavior(@3);
    XCTAssert(scrollView.contentInsetAdjustmentBehavior == UIScrollViewContentInsetAdjustmentAlways, @"");
    
    scrollView.okidoki.verticalScrollIndicatorInsets([NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(5, 0, 5, 0)]);
    
    scrollView.okidoki.horizontalScrollIndicatorInsets([NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 5)]);
    
    scrollView.okidoki.verInd(@"1");
    XCTAssert(scrollView.showsVerticalScrollIndicator == YES, @"");
    
    scrollView.okidoki.verInd(@0);
    XCTAssert(scrollView.showsVerticalScrollIndicator == NO, @"");
    
    scrollView.okidoki.horInd(@"1");
    XCTAssert(scrollView.showsHorizontalScrollIndicator == YES, @"");
    
    scrollView.okidoki.horInd(@0);
    XCTAssert(scrollView.showsHorizontalScrollIndicator == NO, @"");
    
    scrollView.okidoki.paging(@"1");
    XCTAssert(scrollView.pagingEnabled == YES, @"");
    
    scrollView.okidoki.paging(@0);
    XCTAssert(scrollView.pagingEnabled == NO, @"");
    
    scrollView.okidoki.bounces(@"1");
    XCTAssert(scrollView.bounces == YES, @"");
    
    scrollView.okidoki.bounces(@0);
    XCTAssert(scrollView.bounces == NO, @"");
}

- (void)testTextView {
    UITextView *textView = [[UITextView alloc] init];
    
    textView.okidoki.editable(@"1");
    XCTAssert(textView.editable == YES, @"");
    
    textView.okidoki.editable(@0);
    XCTAssert(textView.editable == NO, @"");
    
    textView.okidoki.selectable(@"1");
    XCTAssert(textView.selectable == YES, @"");
    
    textView.okidoki.selectable(@0);
    XCTAssert(textView.selectable == NO, @"");
    
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:@"Hello"];
    textView.okidoki.attributedText(attributedText);
    XCTAssert([textView.attributedText.string isEqualToString:@"Hello"], @"");
    
    UIView *inputView = [[UIView alloc] init];
    textView.okidoki.inputView(inputView);
    XCTAssert(textView.inputView == inputView, @"");
    
    UIView *inputAccessoryView = [[UIView alloc] init];
    textView.okidoki.inputAccessoryView(inputAccessoryView);
    XCTAssert(textView.inputAccessoryView == inputAccessoryView, @"");
    
    textView.okidoki.textContainerInset([NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)]);
}

- (void)testAutoLayout {
    UIView *view = [[UIView alloc] init];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIView *superview = [[UIView alloc] init];
    superview.translatesAutoresizingMaskIntoConstraints = NO;
    [superview addSubview:view];
    
    view.okidoki.leadingAnchor(@[superview, @20]);
    view.okidoki.trailingAnchor(@[superview, @(-20)]);
    view.okidoki.leftAnchor(@[superview, @10]);
    view.okidoki.rightAnchor(@[superview, @(-10)]);
    view.okidoki.topAnchor(@[superview, @5]);
    view.okidoki.bottomAnchor(@[superview, @(-5)]);
    view.okidoki.widthAnchor(@100);
    view.okidoki.heightAnchor(@50);
    view.okidoki.centerXAnchor(@[superview, @10]);
    view.okidoki.centerYAnchor(@[superview, @0]);
    
    view.okidoki.leadingAnchorGreaterOrEqual(@[superview, @15]);
    view.okidoki.trailingAnchorGreaterOrEqual(@[superview, @(-15)]);
    view.okidoki.leftAnchorGreaterOrEqual(@[superview, @5]);
    view.okidoki.rightAnchorGreaterOrEqual(@[superview, @(-5)]);
    view.okidoki.topAnchorGreaterOrEqual(@[superview, @0]);
    view.okidoki.bottomAnchorGreaterOrEqual(@[superview, @(-10)]);
    view.okidoki.widthAnchorGreaterOrEqual(@80);
    view.okidoki.heightAnchorGreaterOrEqual(@40);
    view.okidoki.centerXAnchorGreaterOrEqual(@[superview, @5]);
    view.okidoki.centerYAnchorGreaterOrEqual(@[superview, @(-5)]);
    
    view.okidoki.leadingAnchorLessOrEqual(@[superview, @25]);
    view.okidoki.trailingAnchorLessOrEqual(@[superview, @(-25)]);
    view.okidoki.leftAnchorLessOrEqual(@[superview, @15]);
    view.okidoki.rightAnchorLessOrEqual(@[superview, @(-15)]);
    view.okidoki.topAnchorLessOrEqual(@[superview, @10]);
    view.okidoki.bottomAnchorLessOrEqual(@[superview, @(-20)]);
    view.okidoki.widthAnchorLessOrEqual(@120);
    view.okidoki.heightAnchorLessOrEqual(@60);
    view.okidoki.centerXAnchorLessOrEqual(@[superview, @15]);
    view.okidoki.centerYAnchorLessOrEqual(@[superview, @10]);
    
    view.okidoki.edgeToSuperView(@20);
    view.okidoki.edgeToSuperView(@[@10, @20, @10, @20]);
    view.okidoki.edgeToSuperView(nil);
}

- (void)testDelegateBlocks {
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    
    __block BOOL didScrollCalled = NO;
    scrollView.okidoki.didScroll(^(UIScrollView *scrollView) {
        didScrollCalled = YES;
    });
    
    __block BOOL didZoomCalled = NO;
    scrollView.okidoki.didZoom(^(UIScrollView *scrollView) {
        didZoomCalled = YES;
    });
    
    __block BOOL willBeginDraggingCalled = NO;
    scrollView.okidoki.willBeginDragging(^(UIScrollView *scrollView) {
        willBeginDraggingCalled = YES;
    });
    
    __block BOOL willEndDraggingCalled = NO;
    scrollView.okidoki.willEndDragging(^(UIScrollView *scrollView, CGPoint velocity) {
        willEndDraggingCalled = YES;
    });
    
    __block BOOL didEndDraggingCalled = NO;
    scrollView.okidoki.didEndDragging(^(UIScrollView *scrollView, BOOL decelerate) {
        didEndDraggingCalled = YES;
    });
    
    __block BOOL willBeginDeceleratingCalled = NO;
    scrollView.okidoki.willBeginDecelerating(^(UIScrollView *scrollView) {
        willBeginDeceleratingCalled = YES;
    });
    
    __block BOOL didEndDeceleratingCalled = NO;
    scrollView.okidoki.didEndDecelerating(^(UIScrollView *scrollView) {
        didEndDeceleratingCalled = YES;
    });
    
    __block BOOL didEndScrollingAnimationCalled = NO;
    scrollView.okidoki.didEndScrollingAnimation(^(UIScrollView *scrollView) {
        didEndScrollingAnimationCalled = YES;
    });
    
    __block BOOL viewForZoomingCalled = NO;
    scrollView.okidoki.viewForZooming(^UIView *(UIScrollView *scrollView) {
        viewForZoomingCalled = YES;
        return [[UIView alloc] init];
    });
    
    __block BOOL willBeginZoomingCalled = NO;
    scrollView.okidoki.willBeginZooming(^(UIScrollView *scrollView, UIView *view) {
        willBeginZoomingCalled = YES;
    });
    
    __block BOOL didEndZoomingCalled = NO;
    scrollView.okidoki.didEndZooming(^(UIScrollView *scrollView, UIView *view, CGFloat scale) {
        didEndZoomingCalled = YES;
    });
    
    __block BOOL shouldScrollToTopCalled = NO;
    scrollView.okidoki.shouldScrollToTop(^BOOL(UIScrollView *scrollView) {
        shouldScrollToTopCalled = YES;
        return YES;
    });
    
    __block BOOL didScrollToTopCalled = NO;
    scrollView.okidoki.didScrollToTop(^(UIScrollView *scrollView) {
        didScrollToTopCalled = YES;
    });
    
    __block BOOL didChangeAdjustedContentInsetCalled = NO;
    scrollView.okidoki.didChangeAdjustedContentInset(^(UIScrollView *scrollView) {
        didChangeAdjustedContentInsetCalled = YES;
    });
    
    UITableView *tableView = [[UITableView alloc] init];
    
    __block NSInteger numberOfSectionsCalled = 0;
    tableView.okidoki.numberOfSections(^NSInteger(UITableView *tableView) {
        numberOfSectionsCalled++;
        return 2;
    });
    
    __block NSInteger numberOfRowsInSectionCalled = 0;
    tableView.okidoki.numberOfRowsInSection(^NSInteger(UITableView *tableView, NSInteger section) {
        numberOfRowsInSectionCalled++;
        return 10;
    });
    
    __block UITableViewCell *cellForRowAtIndexPathCalled = nil;
    tableView.okidoki.cellForRowAtIndexPath(^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
        cellForRowAtIndexPathCalled = [[UITableViewCell alloc] init];
        return cellForRowAtIndexPathCalled;
    });
    
    __block NSString *titleForHeaderInSectionCalled = nil;
    tableView.okidoki.titleForHeaderInSection(^NSString *(UITableView *tableView, NSInteger section) {
        titleForHeaderInSectionCalled = @"Header";
        return titleForHeaderInSectionCalled;
    });
    
    __block NSString *titleForFooterInSectionCalled = nil;
    tableView.okidoki.titleForFooterInSection(^NSString *(UITableView *tableView, NSInteger section) {
        titleForFooterInSectionCalled = @"Footer";
        return titleForFooterInSectionCalled;
    });
    
    __block BOOL canEditRowAtIndexPathCalled = NO;
    tableView.okidoki.canEditRowAtIndexPath(^BOOL(UITableView *tableView, NSIndexPath *indexPath) {
        canEditRowAtIndexPathCalled = YES;
        return YES;
    });
    
    __block BOOL commitEditingStyleCalled = NO;
    tableView.okidoki.commitEditingStyle(^(UITableView *tableView, UITableViewCellEditingStyle style, NSIndexPath *indexPath) {
        commitEditingStyleCalled = YES;
    });
    
    __block CGFloat heightForRowAtIndexPathCalled = 0;
    tableView.okidoki.heightForRowAtIndexPath(^CGFloat(UITableView *tableView, NSIndexPath *indexPath) {
        heightForRowAtIndexPathCalled = 44;
        return heightForRowAtIndexPathCalled;
    });
    
    __block CGFloat heightForHeaderInSectionCalled = 0;
    tableView.okidoki.heightForHeaderInSection(^CGFloat(UITableView *tableView, NSInteger section) {
        heightForHeaderInSectionCalled = 30;
        return heightForHeaderInSectionCalled;
    });
    
    __block CGFloat heightForFooterInSectionCalled = 0;
    tableView.okidoki.heightForFooterInSection(^CGFloat(UITableView *tableView, NSInteger section) {
        heightForFooterInSectionCalled = 20;
        return heightForFooterInSectionCalled;
    });
    
    __block UIView *viewForHeaderInSectionCalled = nil;
    tableView.okidoki.viewForHeaderInSection(^UIView *(UITableView *tableView, NSInteger section) {
        viewForHeaderInSectionCalled = [[UIView alloc] init];
        return viewForHeaderInSectionCalled;
    });
    
    __block UIView *viewForFooterInSectionCalled = nil;
    tableView.okidoki.viewForFooterInSection(^UIView *(UITableView *tableView, NSInteger section) {
        viewForFooterInSectionCalled = [[UIView alloc] init];
        return viewForFooterInSectionCalled;
    });
    
    __block BOOL didSelectRowAtIndexPathCalled = NO;
    tableView.okidoki.didSelectRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath) {
        didSelectRowAtIndexPathCalled = YES;
    });
    
    __block BOOL didDeselectRowAtIndexPathCalled = NO;
    tableView.okidoki.didDeselectRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath) {
        didDeselectRowAtIndexPathCalled = YES;
    });
    
    __block BOOL willDisplayCellCalled = NO;
    tableView.okidoki.willDisplayCell(^(UITableView *tableView, UITableViewCell *cell, NSIndexPath *indexPath) {
        willDisplayCellCalled = YES;
    });
    
    __block BOOL didEndDisplayingCellCalled = NO;
    tableView.okidoki.didEndDisplayingCell(^(UITableView *tableView, UITableViewCell *cell, NSIndexPath *indexPath) {
        didEndDisplayingCellCalled = YES;
    });
    
    __block UITableViewCellEditingStyle editingStyleForRowAtIndexPathCalled = UITableViewCellEditingStyleDelete;
    tableView.okidoki.editingStyleForRowAtIndexPath(^UITableViewCellEditingStyle(UITableView *tableView, NSIndexPath *indexPath) {
        return editingStyleForRowAtIndexPathCalled;
    });
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:UICollectionViewLayout.new];
    
    __block NSInteger cvNumberOfSectionsCalled = 0;
    collectionView.okidoki.cvNumberOfSections(^NSInteger(UICollectionView *collectionView) {
        cvNumberOfSectionsCalled++;
        return 2;
    });
    
    __block NSInteger cvNumberOfItemsInSectionCalled = 0;
    collectionView.okidoki.cvNumberOfItemsInSection(^NSInteger(UICollectionView *collectionView, NSInteger section) {
        cvNumberOfItemsInSectionCalled++;
        return 10;
    });
    
    __block UICollectionViewCell *cvCellForItemAtIndexPathCalled = nil;
    collectionView.okidoki.cvCellForItemAtIndexPath(^UICollectionViewCell *(UICollectionView *collectionView, NSIndexPath *indexPath) {
        cvCellForItemAtIndexPathCalled = [[UICollectionViewCell alloc] init];
        return cvCellForItemAtIndexPathCalled;
    });
    
    __block UICollectionReusableView *cvViewForSupplementaryElementCalled = nil;
    collectionView.okidoki.cvViewForSupplementaryElement(^UICollectionReusableView *(UICollectionView *collectionView, NSString *kind, NSIndexPath *indexPath) {
        cvViewForSupplementaryElementCalled = [[UICollectionReusableView alloc] init];
        return cvViewForSupplementaryElementCalled;
    });
    
    __block BOOL cvDidSelectItemAtIndexPathCalled = NO;
    collectionView.okidoki.cvDidSelectItemAtIndexPath(^(UICollectionView *collectionView, NSIndexPath *indexPath) {
        cvDidSelectItemAtIndexPathCalled = YES;
    });
    
    __block BOOL cvDidDeselectItemAtIndexPathCalled = NO;
    collectionView.okidoki.cvDidDeselectItemAtIndexPath(^(UICollectionView *collectionView, NSIndexPath *indexPath) {
        cvDidDeselectItemAtIndexPathCalled = YES;
    });
    
    __block BOOL cvWillDisplayCellCalled = NO;
    collectionView.okidoki.cvWillDisplayCell(^(UICollectionView *collectionView, UICollectionViewCell *cell, NSIndexPath *indexPath) {
        cvWillDisplayCellCalled = YES;
    });
    
    __block BOOL cvDidEndDisplayingCellCalled = NO;
    collectionView.okidoki.cvDidEndDisplayingCell(^(UICollectionView *collectionView, UICollectionViewCell *cell, NSIndexPath *indexPath) {
        cvDidEndDisplayingCellCalled = YES;
    });
    
    __block CGSize cvSizeForItemAtIndexPathCalled = CGSizeZero;
    collectionView.okidoki.cvSizeForItemAtIndexPath(^CGSize(UICollectionView *collectionView, UICollectionViewLayout *layout, NSIndexPath *indexPath) {
        cvSizeForItemAtIndexPathCalled = CGSizeMake(100, 100);
        return cvSizeForItemAtIndexPathCalled;
    });
    
    __block UIEdgeInsets cvInsetForSectionAtIndexCalled = UIEdgeInsetsZero;
    collectionView.okidoki.cvInsetForSectionAtIndex(^UIEdgeInsets(UICollectionView *collectionView, UICollectionViewLayout *layout, NSInteger section) {
        cvInsetForSectionAtIndexCalled = UIEdgeInsetsMake(10, 10, 10, 10);
        return cvInsetForSectionAtIndexCalled;
    });
    
    __block CGFloat cvMinimumLineSpacingCalled = 0;
    collectionView.okidoki.cvMinimumLineSpacing(^CGFloat(UICollectionView *collectionView, UICollectionViewLayout *layout, NSInteger section) {
        cvMinimumLineSpacingCalled = 10;
        return cvMinimumLineSpacingCalled;
    });
    
    __block CGFloat cvMinimumInteritemSpacingCalled = 0;
    collectionView.okidoki.cvMinimumInteritemSpacing(^CGFloat(UICollectionView *collectionView, UICollectionViewLayout *layout, NSInteger section) {
        cvMinimumInteritemSpacingCalled = 5;
        return cvMinimumInteritemSpacingCalled;
    });
    
    UITextField *textField = [[UITextField alloc] init];
    
    __block BOOL tfShouldBeginEditingCalled = NO;
    textField.okidoki.tfShouldBeginEditing(^BOOL(UITextField *textField) {
        tfShouldBeginEditingCalled = YES;
        return YES;
    });
    
    __block BOOL tfDidBeginEditingCalled = NO;
    textField.okidoki.tfDidBeginEditing(^(UITextField *textField) {
        tfDidBeginEditingCalled = YES;
    });
    
    __block BOOL tfShouldEndEditingCalled = NO;
    textField.okidoki.tfShouldEndEditing(^BOOL(UITextField *textField) {
        tfShouldEndEditingCalled = YES;
        return YES;
    });
    
    __block BOOL tfDidEndEditingCalled = NO;
    textField.okidoki.tfDidEndEditing(^(UITextField *textField) {
        tfDidEndEditingCalled = YES;
    });
    
    __block BOOL tfShouldChangeCharactersCalled = NO;
    textField.okidoki.tfShouldChangeCharacters(^BOOL(UITextField *textField, NSRange range, NSString *replacementString) {
        tfShouldChangeCharactersCalled = YES;
        return YES;
    });
    
    __block BOOL tfShouldClearCalled = NO;
    textField.okidoki.tfShouldClear(^BOOL(UITextField *textField) {
        tfShouldClearCalled = YES;
        return YES;
    });
    
    __block BOOL tfShouldReturnCalled = NO;
    textField.okidoki.tfShouldReturn(^BOOL(UITextField *textField) {
        tfShouldReturnCalled = YES;
        return YES;
    });
    
    UITextView *textView = [[UITextView alloc] init];
    
    __block BOOL tvShouldBeginEditingCalled = NO;
    textView.okidoki.tvShouldBeginEditing(^BOOL(UITextView *textView) {
        tvShouldBeginEditingCalled = YES;
        return YES;
    });
    
    __block BOOL tvDidBeginEditingCalled = NO;
    textView.okidoki.tvDidBeginEditing(^(UITextView *textView) {
        tvDidBeginEditingCalled = YES;
    });
    
    __block BOOL tvShouldEndEditingCalled = NO;
    textView.okidoki.tvShouldEndEditing(^BOOL(UITextView *textView) {
        tvShouldEndEditingCalled = YES;
        return YES;
    });
    
    __block BOOL tvDidEndEditingCalled = NO;
    textView.okidoki.tvDidEndEditing(^(UITextView *textView) {
        tvDidEndEditingCalled = YES;
    });
    
    __block BOOL tvDidChangeCalled = NO;
    textView.okidoki.tvDidChange(^(UITextView *textView) {
        tvDidChangeCalled = YES;
    });
    
    __block BOOL tvDidChangeSelectionCalled = NO;
    textView.okidoki.tvDidChangeSelection(^(UITextView *textView) {
        tvDidChangeSelectionCalled = YES;
    });
    
    __block BOOL tvShouldChangeTextCalled = NO;
    textView.okidoki.tvShouldChangeText(^BOOL(UITextView *textView, NSRange range, NSString *replacementText) {
        tvShouldChangeTextCalled = YES;
        return YES;
    });
    
    __block BOOL tvShouldChangeTextInRangesCalled = NO;
    textView.okidoki.tvShouldChangeTextInRanges(^BOOL(UITextView *textView, NSArray<NSValue *> *ranges, NSString *replacementText) {
        tvShouldChangeTextInRangesCalled = YES;
        return YES;
    });
}

- (void)testViewProperty {
    UIView *view = [[UIView alloc] init];
    
    view.ok_left = 10;
    XCTAssert(view.ok_left == 10, @"");
    
    view.ok_top = 20;
    XCTAssert(view.ok_top == 20, @"");
    
    view.ok_right = 30;
    XCTAssert(view.ok_right == 30, @"");
    
    view.ok_bottom = 40;
    XCTAssert(view.ok_bottom == 40, @"");
    
    view.ok_width = 50;
    XCTAssert(view.ok_width == 50, @"");
    
    view.ok_height = 60;
    XCTAssert(view.ok_height == 60, @"");
    
    view.ok_centerX = 70;
    XCTAssert(view.ok_centerX == 70, @"");
    
    view.ok_centerY = 80;
    XCTAssert(view.ok_centerY == 80, @"");
    
    view.ok_origin = CGPointMake(90, 100);
    XCTAssert(CGPointEqualToPoint(view.ok_origin, CGPointMake(90, 100)), @"");
    
    view.ok_size = CGSizeMake(110, 120);
    XCTAssert(CGSizeEqualToSize(view.ok_size, CGSizeMake(110, 120)), @"");
    
    view.ok_leftRight = 130;
    XCTAssert(view.ok_leftRight == 130, @"");
    
    view.ok_topBottom = 140;
    XCTAssert(view.ok_topBottom == 140, @"");
}

- (void)testColor {
    UIColor *color = [UIColor okidokiColor:@"ff0000"];
    XCTAssert([color isEqual:[UIColor redColor]], @"");
    
    UIColor *color2 = [UIColor okidokiColor:@"#00ff00"];
    XCTAssert([color2 isEqual:[UIColor greenColor]], @"");
    
    UIColor *color3 = [UIColor okidokiColor:@"0x0000ff"];
    XCTAssert([color3 isEqual:[UIColor blueColor]], @"");
    
    UIColor *color4 = [UIColor okidokiColor:[UIColor blackColor]];
    XCTAssert([color4 isEqual:[UIColor blackColor]], @"");
}

- (void)testFont {
    UIFont *font = [UIFont okidokiFont:@"17"];
    XCTAssert([font isEqual:[UIFont systemFontOfSize:17]], @"");
    
    UIFont *font2 = [UIFont okidokiFont:@"b18"];
    XCTAssert([font2 isEqual:[UIFont boldSystemFontOfSize:18]], @"");
    
    UIFont *font3 = [UIFont okidokiFont:@"i19"];
    XCTAssert([font3 isEqual:[UIFont italicSystemFontOfSize:19]], @"");
    
    UIFont *font4 = [UIFont okidokiFont:[UIFont systemFontOfSize:20]];
    XCTAssert([font4 isEqual:[UIFont systemFontOfSize:20]], @"");
}

- (void)testAlertController {
    UIAlertController *alert = [UIAlertController okidoki_alertWithTitle:@"Test" image:@"test" imageSize:CGSizeMake(100, 100) viewOffset:CGPointZero preferredStyle:UIAlertControllerStyleAlert];
    XCTAssert(alert != nil, @"");
    
    UIView *customView = [[UIView alloc] init];
    UIAlertController *alert2 = [UIAlertController okidoki_alertWithTitle:@"Test" customView:customView viewSize:CGSizeMake(100, 100) viewOffset:CGPointZero preferredStyle:UIAlertControllerStyleActionSheet];
    XCTAssert(alert2 != nil, @"");
}

- (void)testViewMethod {
    UIView *view = [[UIView alloc] init];
    UIView *returnedView = view.okidoki.bgColor(@"ff0000").view;
    XCTAssert(returnedView == view, @"");
}

- (void)testChain {
    UIView *view = [[UIView alloc] init];
    
    view.okidoki
        .bgColor(@"ff0000")
        .frame(@"{{10,20},{100,200}}")
        .alpha(@"0.5")
        .hidden(@"0")
        .tag(@"1");
    
    XCTAssert([view.backgroundColor isEqual:[UIColor redColor]], @"");
    XCTAssert(CGRectEqualToRect(view.frame, CGRectMake(10, 20, 100, 200)), @"");
    XCTAssert(view.alpha == 0.5, @"");
    XCTAssert(view.hidden == NO, @"");
    XCTAssert(view.tag == 1, @"");
}

@end
