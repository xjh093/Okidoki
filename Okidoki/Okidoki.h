//
//  Okidoki.h
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

// version: 0.0.7
// 2026-04-02 12:02:44

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#define kNumberAdaptor(x) Okidoki_NumberAdaptor(x)

CGFloat Okidoki_NumberAdaptor(CGFloat number);

NS_ASSUME_NONNULL_BEGIN

// UIScrollView Delegate Block Types
typedef void(^OkidokiScrollViewDidScrollBlock)(UIScrollView *scrollView);
typedef void(^OkidokiScrollViewDidZoomBlock)(UIScrollView *scrollView);
typedef void(^OkidokiScrollViewWillBeginDraggingBlock)(UIScrollView *scrollView);
typedef void(^OkidokiScrollViewWillEndDraggingBlock)(UIScrollView *scrollView, CGPoint velocity);
typedef void(^OkidokiScrollViewDidEndDraggingBlock)(UIScrollView *scrollView, BOOL decelerate);
typedef void(^OkidokiScrollViewWillBeginDeceleratingBlock)(UIScrollView *scrollView);
typedef void(^OkidokiScrollViewDidEndDeceleratingBlock)(UIScrollView *scrollView);
typedef void(^OkidokiScrollViewDidEndScrollingAnimationBlock)(UIScrollView *scrollView);
typedef UIView * _Nullable (^OkidokiScrollViewViewForZoomingBlock)(UIScrollView *scrollView);
typedef void(^OkidokiScrollViewWillBeginZoomingBlock)(UIScrollView *scrollView, UIView * _Nullable view);
typedef void(^OkidokiScrollViewDidEndZoomingBlock)(UIScrollView *scrollView, UIView * _Nullable view, CGFloat scale);
typedef BOOL(^OkidokiScrollViewShouldScrollToTopBlock)(UIScrollView *scrollView);
typedef void(^OkidokiScrollViewDidScrollToTopBlock)(UIScrollView *scrollView);
typedef void(^OkidokiScrollViewDidChangeAdjustedContentInsetBlock)(UIScrollView *scrollView);

@interface Okidoki : NSObject

#pragma mark - UIView

/** NSNumber,NSString */
- (Okidoki*(^)(id))tag;
/** NSValue,NSString */
- (Okidoki*(^)(id))frame;
/** NSNumber,NSString */
- (Okidoki*(^)(id))alpha;
/** NSNumber,NSString */
- (Okidoki*(^)(id))hidden;
/** UIColor,NSString(eg.FFFEEE,#FFFEEE,0xFFFEEE,0XFFFEEE) */
- (Okidoki*(^)(id))bgColor;
/** UIColor,NSString(eg.FFFEEE,#FFFEEE,0xFFFEEE,0XFFFEEE) */
- (Okidoki*(^)(id))bdColor;
/** NSNumber,NSString */
- (Okidoki*(^)(id))bdWidth;
/** NSNumber,NSString */
- (Okidoki*(^)(id))cnRadius;
/** NSArray: @[@1,@2,@3,@4] */
- (Okidoki*(^)(id))mkCorners;
/** @(YES) or @(NO),NSString */
- (Okidoki*(^)(id))mtBounds;
/** UIColor,NSString(eg.FFFEEE,#FFFEEE,0xFFFEEE,0XFFFEEE) */
- (Okidoki*(^)(id))shadowColor;
/** NSNumber,NSString */
- (Okidoki*(^)(id))shadowOpacity;
/** NSValue,NSString */
- (Okidoki*(^)(id))shadowOffset;
/** NSNumber,NSString */
- (Okidoki*(^)(id))shadowRadius;
/** UIBezierPath,CGPathRef */
- (Okidoki*(^)(id))shadowPath;
/** UIView */
- (Okidoki*(^)(id))addSubview;
/** UIView, block: void(^)(Okidoki *ok) */
- (Okidoki*(^)(id, void(^)(Okidoki *ok)))addSubviewWithConfig;
/** UIView, block: void(^)(Okidoki *ok, UIView *superView) */
- (Okidoki*(^)(id, void(^)(Okidoki *ok, UIView *superView)))addSubviewWithConfig_superView;
/** UIView */
- (Okidoki*(^)(id))addToSuperview;
/** @(YES) or @(NO),NSString */
- (Okidoki*(^)(id))userInteractionEnabled;


#pragma mark - Gesture

/** Tap gesture, block: void(^)(UITapGestureRecognizer *tap) */
- (Okidoki*(^)(void(^)(UITapGestureRecognizer *tap)))tapGesture;
/** LongPress gesture, block: void(^)(UILongPressGestureRecognizer *longPress) */
- (Okidoki*(^)(void(^)(UILongPressGestureRecognizer *longPress)))longPressGesture;
/** Swipe gesture, direction: UISwipeGestureRecognizerDirection, block: void(^)(UISwipeGestureRecognizer *swipe) */
- (Okidoki*(^)(NSUInteger, void(^)(UISwipeGestureRecognizer *swipe)))swipeGesture;
/** Pan gesture, block: void(^)(UIPanGestureRecognizer *pan) */
- (Okidoki*(^)(void(^)(UIPanGestureRecognizer *pan)))panGesture;
/** Pinch gesture, block: void(^)(UIPinchGestureRecognizer *pinch) */
- (Okidoki*(^)(void(^)(UIPinchGestureRecognizer *pinch)))pinchGesture;
/** Rotation gesture, block: void(^)(UIRotationGestureRecognizer *rotation) */
- (Okidoki*(^)(void(^)(UIRotationGestureRecognizer *rotation)))rotationGesture;
/** Remove gesture by class, example: .removeGesture([UITapGestureRecognizer class]) */
- (Okidoki*(^)(Class))removeGesture;
/** Remove all gestures */
- (Okidoki*(^)(void))removeAllGestures;


#pragma mark - UILabel & UITextView & UITextField

/** NSString */
- (Okidoki*(^)(id))text;
/** UIFont,NSString(@"17",@"s17",@"b17",@"i17") */
- (Okidoki*(^)(id))font;
/** UIColor,NSString(eg.FFFEEE,#FFFEEE,0xFFFEEE,0XFFFEEE) */
- (Okidoki*(^)(id))color;
/** NSNumber: @0,@1,@2,NSString */
- (Okidoki*(^)(id))align;
/** substring: NSString, value:color(UIColor,NSString) or font(UIFont,NSString). */
- (Okidoki*(^)(id,id))attributedSubstring;
/** substring: NSString, value:color(UIColor,NSString) or font(UIFont,NSString), range: NSValue. */
- (Okidoki*(^)(id,id,id))attributedSubstringInRange;
/** substring: NSString, key: NSAttributedStringKey, value: color/font/number etc. */
- (Okidoki*(^)(id,id,id))attributedSubstringKeyValue;
/** substring: NSString, key: NSAttributedStringKey, value: color/font/number etc. range: NSValue. */
- (Okidoki*(^)(id,id,id,id))attributedSubstringKeyValueInRange;


#pragma mark - UILabel

/** NSNumber(NSInteger) ,NSString*/
- (Okidoki*(^)(id))lines;
/** adjustsFontSizeToFitWidth: @(YES) or @(NO), NSString*/
- (Okidoki*(^)(id))adjust;
/** NSNumber(CGFloat), NSString*/
- (Okidoki*(^)(id))lineSpace;
/** NSNumber(CGFloat), 0 means no max width limit. NSString */
- (Okidoki*(^)(id))autoWidth;
/** NSNumber(CGFloat), 0 means no max height limit. NSString */
- (Okidoki*(^)(id))autoHeight;
/** UIColor,NSString(eg.FFFEEE,#FFFEEE,0xFFFEEE,0XFFFEEE) */
- (Okidoki*(^)(id))highlightedTextColor;


#pragma mark - UIControl

/** @(YES) or @(NO),NSString */
- (Okidoki*(^)(id))enabled;
/** @(YES) or @(NO),NSString */
- (Okidoki*(^)(id))selected;
/** @(YES) or @(NO),NSString */
- (Okidoki*(^)(id))highlighted;
/** NSNumber: @0,@1,@2,@3, NSString */
- (Okidoki*(^)(id))contentVerticalAlignment;
/** NSNumber: @0,@1,@2,@3,@4,@5, NSString */
- (Okidoki*(^)(id))contentHorizontalAlignment;
/** Add block for control events, controlEvents: UIControlEvents, block: void(^)(__kindof UIControl *sender) */
- (Okidoki*(^)(UIControlEvents, void(^)(__kindof UIControl *sender)))addControlEvent;
/** Remove all blocks for control events, controlEvents: UIControlEvents */
- (Okidoki*(^)(UIControlEvents))removeControlEvent;
/** Remove all targets and blocks for all events */
- (Okidoki*(^)(void))removeAllControlEvents;

#pragma mark - UIButton

/** title: NSString state: normal*/
- (Okidoki*(^)(id))title;
/** title: NSString, state: NSNumber */
- (Okidoki*(^)(id,id))titleForState;
/** color: UIColor,NSString(eg.#FFFEEE,0xFFFEEE,0XFFFEEE) , state: NSNumber */
- (Okidoki*(^)(id,id))colorForState;
/** image: NSString, UIImage, state: NSNumber */
- (Okidoki*(^)(id,id))imageForState;
/** bgImage: NSString, UIImage, state: NSNumber */
- (Okidoki*(^)(id,id))bgImageForState;
/** lineSpace: NSNumber, state: NSNumber */
- (Okidoki*(^)(id,id))lineSpaceForState;
/** space: NSNumber */
- (Okidoki*(^)(id))imageUpTitleDown;
/** space: NSNumber */
- (Okidoki*(^)(id))imageDownTitleUp;
/** space: NSNumber */
- (Okidoki*(^)(id))imageRightTitleLeft;
/** space: NSNumber */
- (Okidoki*(^)(id))imageLeftTitleRight;
/** all center */
- (Okidoki*(^)(void))imageCenterTitleCenter;
/** substring: NSString, value:color or font, state: NSNumber */
- (Okidoki*(^)(id,id,id))attributedSubstringForState;
/** substring: NSString, value:color or font, range: NSValue, state: NSNumber */
- (Okidoki*(^)(id,id,id,id))attributedSubstringInRangeForState;
/** substring: NSString, key: NSAttributedStringKey, value: color/font/number etc. */
- (Okidoki*(^)(id,id,id,id))attributedSubstringKeyValueForState;
/** substring: NSString, key: NSAttributedStringKey, value: color/font/number etc. range: NSValue. */
- (Okidoki*(^)(id,id,id,id,id))attributedSubstringKeyValueInRangeForState;


#pragma mark - UIImageView

/** image: UIImage, NSString */
- (Okidoki*(^)(id))image;
/** highlightedImage: UIImage, NSString */
- (Okidoki*(^)(id))highlightedImage;
/** image: UIImage,NSString, color: UIColor */
- (Okidoki*(^)(id,id))imageForTintColor;


#pragma mark - UITextField

/** borderStyle, NSString,NSNumber: @1,@2,@3,@4 */
- (Okidoki*(^)(id))bdStyle;
/** placeholder, NSString */
- (Okidoki*(^)(id))pHolder;
/** placeholder color, UIColor,NSString(eg.#FFFEEE,0xFFFEEE,0XFFFEEE) */
- (Okidoki*(^)(id))pHColor;
/** placeholder font, UIFont */
- (Okidoki*(^)(id))pHFont;
/** clearButtonMode, NSNumber: @1,@2,@3,@4 */
- (Okidoki*(^)(id))cbMode;
/** leftViewMode, NSNumber: @1,@2,@3,@4 */
- (Okidoki*(^)(id))lvMode;
/** rightViewMode, NSNumber: @1,@2,@3,@4 */
- (Okidoki*(^)(id))rvMode;
/** leftView, UIView */
- (Okidoki*(^)(id))lfView;
/** rightView, UIView */
- (Okidoki*(^)(id))rtView;
/** secureTextEntry, BOOL: @YES, @NO */
- (Okidoki*(^)(id))secure;


#pragma mark - UIScrollView

/** NSValue(CGPoint), NSString */
- (Okidoki*(^)(id))contentOffset;
/** NSValue(CGSize), NSString */
- (Okidoki*(^)(id))contentSize;
/** NSValue(UIEdgeInsets), NSString */
- (Okidoki*(^)(id))contentInset;
/** @(YES) or @(NO), NSString */
- (Okidoki*(^)(id))directionalLockEnabled;
/** @(YES) or @(NO), NSString */
- (Okidoki*(^)(id))alwaysBounceVertical;
/** @(YES) or @(NO), NSString */
- (Okidoki*(^)(id))alwaysBounceHorizontal;
/** @(YES) or @(NO), NSString */
- (Okidoki*(^)(id))scrollEnabled;
/** NSNumber: @0,@1,@2, NSString */
- (Okidoki*(^)(id))indicatorStyle;
/** @(YES) or @(NO), NSString */
- (Okidoki*(^)(id))delaysContentTouches;
/** @(YES) or @(NO), NSString */
- (Okidoki*(^)(id))canCancelContentTouches;
/** NSNumber, NSString */
- (Okidoki*(^)(id))minimumZoomScale;
/** NSNumber, NSString */
- (Okidoki*(^)(id))maximumZoomScale;
/** @(YES) or @(NO), NSString */
- (Okidoki*(^)(id))bouncesZoom;
/** @(YES) or @(NO), NSString */
- (Okidoki*(^)(id))scrollsToTop;
/** NSNumber, NSString */
- (Okidoki*(^)(id))decelerationRate;
/** NSNumber, NSString */
- (Okidoki*(^)(id))zoomScale;
/** NSNumber: @0,@1,@2, NSString */
- (Okidoki*(^)(id))keyboardDismissMode;
/** NSNumber: @0,@1,@2,@3,@4, NSString (iOS 11+) */
- (Okidoki*(^)(id))contentInsetAdjustmentBehavior;
/** NSValue(UIEdgeInsets), NSString (iOS 11.1+) */
- (Okidoki*(^)(id))verticalScrollIndicatorInsets;
/** NSValue(UIEdgeInsets), NSString (iOS 11.1+) */
- (Okidoki*(^)(id))horizontalScrollIndicatorInsets;
/** showsVerticalScrollIndicator: @(YES) or @(NO), NSString */
- (Okidoki*(^)(id))verInd;
/** showsHorizontalScrollIndicator: @(YES) or @(NO), NSString */
- (Okidoki*(^)(id))horInd;
/** pagingEnabled: @(YES) or @(NO), NSString */
- (Okidoki*(^)(id))paging;
/** bounces: @(YES) or @(NO), NSString */
- (Okidoki*(^)(id))bounces;

// UIScrollView Delegate Blocks
/**
 scrollViewDidScroll delegate block
 @code
 scrollView.okidoki.didScroll(^(UIScrollView *scrollView) {
     NSLog(@"offset: %@", NSStringFromCGPoint(scrollView.contentOffset));
 });
 @endcode
 */
- (Okidoki*(^)(OkidokiScrollViewDidScrollBlock block))didScroll;

/**
 scrollViewDidZoom delegate block
 @code
 scrollView.okidoki.didZoom(^(UIScrollView *scrollView) {
     NSLog(@"zoom scale: %f", scrollView.zoomScale);
 });
 @endcode
 */
- (Okidoki*(^)(OkidokiScrollViewDidZoomBlock block))didZoom;

/**
 scrollViewWillBeginDragging delegate block
 @code
 scrollView.okidoki.willBeginDragging(^(UIScrollView *scrollView) {
     NSLog(@"will begin dragging");
 });
 @endcode
 */
- (Okidoki*(^)(OkidokiScrollViewWillBeginDraggingBlock block))willBeginDragging;

/**
 scrollViewWillEndDragging:withVelocity: delegate block
 @code
 scrollView.okidoki.willEndDragging(^(UIScrollView *scrollView, CGPoint velocity) {
     NSLog(@"velocity: %@", NSStringFromCGPoint(velocity));
 });
 @endcode
 */
- (Okidoki*(^)(OkidokiScrollViewWillEndDraggingBlock block))willEndDragging;

/**
 scrollViewDidEndDragging:willDecelerate: delegate block
 @code
 scrollView.okidoki.didEndDragging(^(UIScrollView *scrollView, BOOL decelerate) {
     NSLog(@"will decelerate: %d", decelerate);
 });
 @endcode
 */
- (Okidoki*(^)(OkidokiScrollViewDidEndDraggingBlock block))didEndDragging;

/**
 scrollViewWillBeginDecelerating delegate block
 @code
 scrollView.okidoki.willBeginDecelerating(^(UIScrollView *scrollView) {
     NSLog(@"will begin decelerating");
 });
 @endcode
 */
- (Okidoki*(^)(OkidokiScrollViewWillBeginDeceleratingBlock block))willBeginDecelerating;

/**
 scrollViewDidEndDecelerating delegate block
 @code
 scrollView.okidoki.didEndDecelerating(^(UIScrollView *scrollView) {
     NSLog(@"did end decelerating");
 });
 @endcode
 */
- (Okidoki*(^)(OkidokiScrollViewDidEndDeceleratingBlock block))didEndDecelerating;

/**
 scrollViewDidEndScrollingAnimation delegate block
 @code
 scrollView.okidoki.didEndScrollingAnimation(^(UIScrollView *scrollView) {
     NSLog(@"animation ended");
 });
 @endcode
 */
- (Okidoki*(^)(OkidokiScrollViewDidEndScrollingAnimationBlock block))didEndScrollingAnimation;

/**
 viewForZoomingInScrollView delegate block
 @code
 scrollView.okidoki.viewForZooming(^UIView *(UIScrollView *scrollView) {
     return imageView;
 });
 @endcode
 */
- (Okidoki*(^)(OkidokiScrollViewViewForZoomingBlock block))viewForZooming;

/**
 scrollViewWillBeginZooming:withView: delegate block
 @code
 scrollView.okidoki.willBeginZooming(^(UIScrollView *scrollView, UIView *view) {
     NSLog(@"will begin zooming view: %@", view);
 });
 @endcode
 */
- (Okidoki*(^)(OkidokiScrollViewWillBeginZoomingBlock block))willBeginZooming;

/**
 scrollViewDidEndZooming:withView:atScale: delegate block
 @code
 scrollView.okidoki.didEndZooming(^(UIScrollView *scrollView, UIView *view, CGFloat scale) {
     NSLog(@"did end zooming at scale: %f", scale);
 });
 @endcode
 */
- (Okidoki*(^)(OkidokiScrollViewDidEndZoomingBlock block))didEndZooming;

/**
 scrollViewShouldScrollToTop delegate block
 @code
 scrollView.okidoki.shouldScrollToTop(^BOOL(UIScrollView *scrollView) {
     return YES;
 });
 @endcode
 */
- (Okidoki*(^)(OkidokiScrollViewShouldScrollToTopBlock block))shouldScrollToTop;

/**
 scrollViewDidScrollToTop delegate block
 @code
 scrollView.okidoki.didScrollToTop(^(UIScrollView *scrollView) {
     NSLog(@"did scroll to top");
 });
 @endcode
 */
- (Okidoki*(^)(OkidokiScrollViewDidScrollToTopBlock block))didScrollToTop;

/**
 scrollViewDidChangeAdjustedContentInset delegate block (iOS 11+)
 @code
 scrollView.okidoki.didChangeAdjustedContentInset(^(UIScrollView *scrollView) {
     NSLog(@"content inset changed");
 });
 @endcode
 */
- (Okidoki*(^)(OkidokiScrollViewDidChangeAdjustedContentInsetBlock block))didChangeAdjustedContentInset;


#pragma mark - UITextView

- (Okidoki*(^)(id))editable;
- (Okidoki*(^)(id))selectable;

@end


@interface Okidoki (AutoLayout)

#pragma mark - AutoLayout Anchors

/**
 Leading anchor constraint
 params:  NSArray: @[toView, @(constant)] or @[toView] (constant default 0)
        toView can be UIView (use its leadingAnchor) or NSLayoutXAxisAnchor
 Example: .leadingAnchor(@[superview, @20]) or .leadingAnchor(@[superview])
 */
- (Okidoki*(^)(id params))leadingAnchor;

/**
 Trailing anchor constraint
 params:  NSArray: @[toView, @(constant)] or @[toView] (constant default 0)
        toView can be UIView (use its trailingAnchor) or NSLayoutXAxisAnchor
 Example: .trailingAnchor(@[superview, @(-20)])
 */
- (Okidoki*(^)(id params))trailingAnchor;

/**
 Left anchor constraint
 params:  NSArray: @[toView, @(constant)] or @[toView] (constant default 0)
        toView can be UIView (use its leftAnchor) or NSLayoutXAxisAnchor
 Example: .leftAnchor(@[superview, @20])
 */
- (Okidoki*(^)(id params))leftAnchor;

/**
 Right anchor constraint
 params:  NSArray: @[toView, @(constant)] or @[toView] (constant default 0)
        toView can be UIView (use its rightAnchor) or NSLayoutXAxisAnchor
 Example: .rightAnchor(@[superview, @(-20)])
 */
- (Okidoki*(^)(id params))rightAnchor;

/**
 Top anchor constraint
 params:  NSArray: @[toView, @(constant)] or @[toView] (constant default 0)
        toView can be UIView (use its topAnchor) or NSLayoutYAxisAnchor
 Example: .topAnchor(@[superview, @10])
 */
- (Okidoki*(^)(id params))topAnchor;

/**
 Bottom anchor constraint
 params:  NSArray: @[toView, @(constant)] or @[toView] (constant default 0)
        toView can be UIView (use its bottomAnchor) or NSLayoutYAxisAnchor
 Example: .bottomAnchor(@[superview, @(-10)])
 */
- (Okidoki*(^)(id params))bottomAnchor;

/**
 Width anchor constraint
 params:  NSNumber: @(width) for constant width
        NSArray: @[toView, @(multiplier), @(constant)] for relative width
 Example: .widthAnchor(@100) or .widthAnchor(@[superview, @0.5, @(-20)])
 */
- (Okidoki*(^)(id params))widthAnchor;

/**
 Height anchor constraint
 params:  NSNumber: @(height) for constant height
        NSArray: @[toView, @(multiplier), @(constant)] for relative height
 Example: .heightAnchor(@50) or .heightAnchor(@[superview, @0.5, @0])
 */
- (Okidoki*(^)(id params))heightAnchor;

/**
 CenterX anchor constraint
 params:  NSArray: @[toView, @(constant)] or @[toView] (constant default 0)
        toView can be UIView (use its centerXAnchor) or NSLayoutXAxisAnchor
 Example: .centerXAnchor(@[superview, @10])
 */
- (Okidoki*(^)(id params))centerXAnchor;

/**
 CenterY anchor constraint
 params:  NSArray: @[toView, @(constant)] or @[toView] (constant default 0)
        toView can be UIView (use its centerYAnchor) or NSLayoutYAxisAnchor
 Example: .centerYAnchor(@[superview, @0])
 */
- (Okidoki*(^)(id params))centerYAnchor;


#pragma mark - Convenience Methods

/**
 Edge to superview with insets
 params:  NSNumber: @(inset) for all edges
        NSArray: @[@(top), @(left), @(bottom), @(right)]
        NSValue: UIEdgeInsets
        nil: all edges = 0
 Example: .edgeToSuperView(@20) or .edgeToSuperView(@[@10, @20, @10, @20]) or .edgeToSuperView(nil)
 */
- (Okidoki*(^)(id _Nullable params))edgeToSuperView;

@end


@interface UIView (Okidoki)
@property (nonatomic,  strong) Okidoki *okidoki;

@property (nonatomic) CGFloat ok_left;
@property (nonatomic) CGFloat ok_top;
@property (nonatomic) CGFloat ok_right;
@property (nonatomic) CGFloat ok_bottom;
@property (nonatomic) CGFloat ok_width;
@property (nonatomic) CGFloat ok_height;
@property (nonatomic) CGFloat ok_centerX;
@property (nonatomic) CGFloat ok_centerY;
@property (nonatomic) CGPoint ok_origin;
@property (nonatomic) CGSize  ok_size;
@property (nonatomic) CGFloat ok_leftRight;
@property (nonatomic) CGFloat ok_topBottom;
@end


@interface UIColor (Okidoki)
/** color: UIColor,NSString(eg.FFFEEE,#FFFEEE,0xFFFEEE,0XFFFEEE) */
+ (UIColor *)okidokiColor:(id)color;
@end


@interface UIFont (Okidoki)
/** color: UIFont,NSString(eg.@"17",@"s17",@"b17",@"i17") */
+ (UIFont *)okidokiFont:(id)font;
@end

NS_ASSUME_NONNULL_END
