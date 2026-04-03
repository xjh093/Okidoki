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

// version: 0.0.12
// 2026-04-03 10:42:05

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#define kNumberAdaptor(x) Okidoki_NumberAdaptor(x)

CGFloat Okidoki_NumberAdaptor(CGFloat number);

NS_ASSUME_NONNULL_BEGIN

@interface Okidoki : NSObject

#pragma mark - UIView

/** 
 Get the current view being configured
 @return The UIView instance that this Okidoki object is configuring
 @code
 UIView *myView = view.okidoki.bgColor(@"FF0000").view;
 @endcode
 */
- (__kindof UIView *)view;

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

/**
 UIView, block: void(^)(Okidoki *ok)
 @code
 .addSubviewWithConfig(childView, ^(Okidoki *ok) {
     ok.bgColor(@"FF0000").frame(@"{{0,0},{100,100}}");
 })
 @endcode
 */
- (Okidoki*(^)(id, void(^)(Okidoki *ok)))addSubviewWithConfig;

/**
 UIView, block: void(^)(Okidoki *ok, UIView *superView)
 @code
 .addSubviewWithConfig_superView(childView, ^(Okidoki *ok, UIView *superView) {
     ok.bgColor(@"00FF00").frame(CGRectMake(0, 0, superView.bounds.size.width, 50));
 })
 @endcode
 */
- (Okidoki*(^)(id, void(^)(Okidoki *ok, UIView *superView)))addSubviewWithConfig_superView;

/** UIView */
- (Okidoki*(^)(id))addToSuperview;

/** @(YES) or @(NO),NSString */
- (Okidoki*(^)(id))userInteractionEnabled;


#pragma mark - Gesture

/** 
 Tap gesture, block: void(^)(UITapGestureRecognizer *tap)
 @code
 .tapGesture(^(UITapGestureRecognizer *tap) {
     NSLog(@"Tapped");
 })
 @endcode
 */
- (Okidoki*(^)(void(^)(UITapGestureRecognizer *tap)))tapGesture;

/**
 LongPress gesture, block: void(^)(UILongPressGestureRecognizer *longPress)
 @code
 .longPressGesture(^(UILongPressGestureRecognizer *longPress) {
     NSLog(@"Long pressed");
 })
 @endcode
 */
- (Okidoki*(^)(void(^)(UILongPressGestureRecognizer *longPress)))longPressGesture;

/**
 Swipe gesture, direction: UISwipeGestureRecognizerDirection, block: void(^)(UISwipeGestureRecognizer *swipe)
 @code
 .swipeGesture(UISwipeGestureRecognizerDirectionLeft, ^(UISwipeGestureRecognizer *swipe) {
     NSLog(@"Swiped");
 })
 @endcode
 */
- (Okidoki*(^)(NSUInteger, void(^)(UISwipeGestureRecognizer *swipe)))swipeGesture;

/**
 Pan gesture, block: void(^)(UIPanGestureRecognizer *pan)
 @code
 .panGesture(^(UIPanGestureRecognizer *pan) {
     CGPoint translation = [pan translationInView:pan.view];
     NSLog(@"Pan: %@", NSStringFromCGPoint(translation));
 })
 @endcode
 */
- (Okidoki*(^)(void(^)(UIPanGestureRecognizer *pan)))panGesture;

/**
 Pinch gesture, block: void(^)(UIPinchGestureRecognizer *pinch)
 @code
 .pinchGesture(^(UIPinchGestureRecognizer *pinch) {
     NSLog(@"Scale: %f", pinch.scale);
 })
 @endcode
 */
- (Okidoki*(^)(void(^)(UIPinchGestureRecognizer *pinch)))pinchGesture;

/**
 Rotation gesture, block: void(^)(UIRotationGestureRecognizer *rotation)
 @code
 .rotationGesture(^(UIRotationGestureRecognizer *rotation) {
     NSLog(@"Rotation: %f", rotation.rotation);
 })
 @endcode
 */
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

/**
 substring: NSString, value:color(UIColor,NSString) or font(UIFont,NSString).
 @code
 .text(@"Hello World").attributedSubstring(@"World", @"FF0000")
 @endcode
 */
- (Okidoki*(^)(id,id))attributedSubstring;

/**
 substring: NSString, value:color(UIColor,NSString) or font(UIFont,NSString), range: NSValue.
 @code
 .text(@"Hello World").attributedSubstringInRange(@"World", @"FF0000", [NSValue valueWithRange:NSMakeRange(6, 5)])
 @endcode
 */
- (Okidoki*(^)(id,id,id))attributedSubstringInRange;

/**
 substring: NSString, key: NSAttributedStringKey, value: color/font/number etc.
 @code
 .text(@"Hello World").attributedSubstringKeyValue(@"World", NSForegroundColorAttributeName, [UIColor redColor])
 @endcode
 */
- (Okidoki*(^)(id,id,id))attributedSubstringKeyValue;

/**
 substring: NSString, key: NSAttributedStringKey, value: color/font/number etc. range: NSValue.
 @code
 .attributedSubstringKeyValueInRange(@"World", NSForegroundColorAttributeName, [UIColor redColor], [NSValue valueWithRange:NSMakeRange(6, 5)])
 @endcode
 */
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

/**
 Add block for control events, controlEvents: UIControlEvents, block: void(^)(__kindof UIControl *sender)
 @code
 .addControlEvent(UIControlEventTouchUpInside, ^(UIButton *sender) {
     NSLog(@"Button tapped");
 })
 @endcode
 */
- (Okidoki*(^)(UIControlEvents, void(^)(__kindof UIControl *sender)))addControlEvent;

/** Remove all blocks for control events, controlEvents: UIControlEvents */
- (Okidoki*(^)(UIControlEvents))removeControlEvent;

/** Remove all targets and blocks for all events */
- (Okidoki*(^)(void))removeAllControlEvents;


#pragma mark - UIButton

/** title: NSString state: normal*/
- (Okidoki*(^)(id))title;

/**
 title: NSString, state: NSNumber
 @code
 .titleForState(@"Highlighted", @(UIControlStateHighlighted))
 @endcode
 */
- (Okidoki*(^)(id,id))titleForState;

/**
 color: UIColor,NSString(eg.#FFFEEE,0xFFFEEE,0XFFFEEE) , state: NSNumber
 @code
 .colorForState(@"FF0000", @(UIControlStateNormal))
 @endcode
 */
- (Okidoki*(^)(id,id))colorForState;

/**
 image: NSString, UIImage, state: NSNumber
 @code
 .imageForState(@"icon_home", @(UIControlStateNormal))
 @endcode
 */
- (Okidoki*(^)(id,id))imageForState;

/**
 bgImage: NSString, UIImage, state: NSNumber
 @code
 .bgImageForState(@"bg_button", @(UIControlStateNormal))
 @endcode
 */
- (Okidoki*(^)(id,id))bgImageForState;

/**
 lineSpace: NSNumber, state: NSNumber
 @code
 .lineSpaceForState(@5, @(UIControlStateNormal))
 @endcode
 */
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

/**
 substring: NSString, value:color or font, state: NSNumber
 @code
 .titleForState(@"Hello World", @(UIControlStateNormal)).attributedSubstringForState(@"World", @"FF0000", @(UIControlStateNormal))
 @endcode
 */
- (Okidoki*(^)(id,id,id))attributedSubstringForState;

/**
 substring: NSString, value:color or font, range: NSValue, state: NSNumber
 @code
 .attributedSubstringInRangeForState(@"World", @"FF0000", [NSValue valueWithRange:NSMakeRange(6, 5)], @(UIControlStateNormal))
 @endcode
 */
- (Okidoki*(^)(id,id,id,id))attributedSubstringInRangeForState;

/**
 substring: NSString, key: NSAttributedStringKey, value: color/font/number etc.
 @code
 .attributedSubstringKeyValueForState(@"World", NSForegroundColorAttributeName, [UIColor redColor], @(UIControlStateNormal))
 @endcode
 */
- (Okidoki*(^)(id,id,id,id))attributedSubstringKeyValueForState;

/**
 substring: NSString, key: NSAttributedStringKey, value: color/font/number etc. range: NSValue.
 @code
 .attributedSubstringKeyValueInRangeForState(@"World", NSForegroundColorAttributeName, [UIColor redColor], [NSValue valueWithRange:NSMakeRange(6, 5)], @(UIControlStateNormal))
 @endcode
 */
- (Okidoki*(^)(id,id,id,id,id))attributedSubstringKeyValueInRangeForState;


#pragma mark - UIImageView

/** image: UIImage, NSString */
- (Okidoki*(^)(id))image;

/** highlightedImage: UIImage, NSString */
- (Okidoki*(^)(id))highlightedImage;

/**
 image: UIImage,NSString, color: UIColor
 @code
 .imageForTintColor(@"icon_home", [UIColor redColor])
 @endcode
 */
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


#pragma mark - UITextView

/** 
 editable: @(YES) or @(NO), NSString
 @code
 .editable(@YES)
 @endcode
 */
- (Okidoki*(^)(id))editable;

/**
 selectable: @(YES) or @(NO), NSString
 @code
 .selectable(@YES)
 @endcode
 */
- (Okidoki*(^)(id))selectable;

/** 
 borderStyle: NSNumber, NSString: @0 (None), @1 (RoundedRect)
 @code
 textView.borderStyle(@1)
 @endcode
 */
- (Okidoki*(^)(id))borderStyle;

/**
 attributedText: NSAttributedString
 @code
 .attributedText(attributedString)
 @endcode
 */
- (Okidoki*(^)(id))attributedText;

/**
 inputView: UIView
 @code
 .inputView(customInputView)
 @endcode
 */
- (Okidoki*(^)(id))inputView;

/**
 inputAccessoryView: UIView
 @code
 .inputAccessoryView(accessoryView)
 @endcode
 */
- (Okidoki*(^)(id))inputAccessoryView;

/**
 textContainerInset: NSValue(UIEdgeInsets), NSString
 @code
 .textContainerInset([NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)])
 @endcode
 */
- (Okidoki*(^)(id))textContainerInset;

@end


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

@interface Okidoki (UIScrollView)

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

@end


// UITableView Delegate Block Types
typedef NSInteger(^OkidokiTableViewNumberOfSectionsBlock)(UITableView *tableView);
typedef NSInteger(^OkidokiTableViewNumberOfRowsInSectionBlock)(UITableView *tableView, NSInteger section);
typedef UITableViewCell * _Nonnull(^OkidokiTableViewCellForRowAtIndexPathBlock)(UITableView *tableView, NSIndexPath *indexPath);
typedef CGFloat(^OkidokiTableViewHeightForRowBlock)(UITableView *tableView, NSIndexPath *indexPath);
typedef CGFloat(^OkidokiTableViewHeightForHeaderBlock)(UITableView *tableView, NSInteger section);
typedef CGFloat(^OkidokiTableViewHeightForFooterBlock)(UITableView *tableView, NSInteger section);
typedef UIView * _Nullable (^OkidokiTableViewViewForHeaderBlock)(UITableView *tableView, NSInteger section);
typedef UIView * _Nullable (^OkidokiTableViewViewForFooterBlock)(UITableView *tableView, NSInteger section);
typedef void(^OkidokiTableViewDidSelectRowBlock)(UITableView *tableView, NSIndexPath *indexPath);
typedef void(^OkidokiTableViewDidDeselectRowBlock)(UITableView *tableView, NSIndexPath *indexPath);
typedef void(^OkidokiTableViewWillDisplayCellBlock)(UITableView *tableView, UITableViewCell *cell, NSIndexPath *indexPath);
typedef void(^OkidokiTableViewDidEndDisplayingCellBlock)(UITableView *tableView, UITableViewCell *cell, NSIndexPath *indexPath);
typedef NSString * _Nullable (^OkidokiTableViewTitleForHeaderBlock)(UITableView *tableView, NSInteger section);
typedef NSString * _Nullable (^OkidokiTableViewTitleForFooterBlock)(UITableView *tableView, NSInteger section);
typedef BOOL(^OkidokiTableViewCanEditRowBlock)(UITableView *tableView, NSIndexPath *indexPath);
typedef void(^OkidokiTableViewCommitEditingStyleBlock)(UITableView *tableView, UITableViewCellEditingStyle editingStyle, NSIndexPath *indexPath);
typedef UITableViewCellEditingStyle(^OkidokiTableViewEditingStyleBlock)(UITableView *tableView, NSIndexPath *indexPath);


@interface Okidoki (UITableView)

// Register Cell
/** 
 Register cell class with identifier
 params: NSArray: @[cellClass, @"identifier"]
 @code
 .registerCellClass(@[[UITableViewCell class], @"Cell"])
 @endcode
 */
- (Okidoki*(^)(NSArray *params))registerCellClass;

/** 
 Register cell nib with identifier
 params: NSArray: @[nibName, @"identifier"] or @[UINib, @"identifier"]
 @code
 .registerCellNib(@[@"MyCell", @"Cell"])
 @endcode
 */
- (Okidoki*(^)(NSArray *params))registerCellNib;

/** 
 Register multiple cell classes with identifiers
 params: NSArray: @[@[cellClass1, @"identifier1"], @[cellClass2, @"identifier2"], ...]
 @code
 .registerMultiCellClass(@[@[[MyCell class], @"Cell1"], @[[OtherCell class], @"Cell2"]])
 @endcode
 */
- (Okidoki*(^)(NSArray *params))registerMultiCellClass;


// UITableViewDataSource
/** 
 numberOfSectionsInTableView: block
 @code
 .numberOfSections(^NSInteger(UITableView *tableView) {
     return 2;
 })
 @endcode
 */
- (Okidoki*(^)(OkidokiTableViewNumberOfSectionsBlock block))numberOfSections;

/** 
 tableView:numberOfRowsInSection: block
 @code
 .numberOfRowsInSection(^NSInteger(UITableView *tableView, NSInteger section) {
     return 10;
 })
 @endcode
 */
- (Okidoki*(^)(OkidokiTableViewNumberOfRowsInSectionBlock block))numberOfRowsInSection;

/** 
 tableView:cellForRowAtIndexPath: block
 @code
 .cellForRowAtIndexPath(^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
     return cell;
 })
 @endcode
 */
- (Okidoki*(^)(OkidokiTableViewCellForRowAtIndexPathBlock block))cellForRowAtIndexPath;

/** 
 tableView:titleForHeaderInSection: block
 @code
 .titleForHeaderInSection(^NSString *(UITableView *tableView, NSInteger section) {
     return @"Header";
 })
 @endcode
 */
- (Okidoki*(^)(OkidokiTableViewTitleForHeaderBlock block))titleForHeaderInSection;

/** 
 tableView:titleForFooterInSection: block
 @code
 .titleForFooterInSection(^NSString *(UITableView *tableView, NSInteger section) {
     return @"Footer";
 })
 @endcode
 */
- (Okidoki*(^)(OkidokiTableViewTitleForFooterBlock block))titleForFooterInSection;

/** 
 tableView:canEditRowAtIndexPath: block
 @code
 .canEditRowAtIndexPath(^BOOL(UITableView *tableView, NSIndexPath *indexPath) {
     return YES;
 })
 @endcode
 */
- (Okidoki*(^)(OkidokiTableViewCanEditRowBlock block))canEditRowAtIndexPath;

/** 
 tableView:commitEditingStyle:forRowAtIndexPath: block
 @code
 .commitEditingStyle(^(UITableView *tableView, UITableViewCellEditingStyle style, NSIndexPath *indexPath) {
     // Handle editing
 })
 @endcode
 */
- (Okidoki*(^)(OkidokiTableViewCommitEditingStyleBlock block))commitEditingStyle;


// UITableViewDelegate
/** 
 tableView:heightForRowAtIndexPath: block
 @code
 .heightForRowAtIndexPath(^CGFloat(UITableView *tableView, NSIndexPath *indexPath) {
     return 44;
 })
 @endcode
 */
- (Okidoki*(^)(OkidokiTableViewHeightForRowBlock block))heightForRowAtIndexPath;

/** 
 tableView:heightForHeaderInSection: block
 @code
 .heightForHeaderInSection(^CGFloat(UITableView *tableView, NSInteger section) {
     return 30;
 })
 @endcode
 */
- (Okidoki*(^)(OkidokiTableViewHeightForHeaderBlock block))heightForHeaderInSection;

/** 
 tableView:heightForFooterInSection: block
 @code
 .heightForFooterInSection(^CGFloat(UITableView *tableView, NSInteger section) {
     return 20;
 })
 @endcode
 */
- (Okidoki*(^)(OkidokiTableViewHeightForFooterBlock block))heightForFooterInSection;

/** 
 tableView:viewForHeaderInSection: block
 @code
 .viewForHeaderInSection(^UIView *(UITableView *tableView, NSInteger section) {
     return headerView;
 })
 @endcode
 */
- (Okidoki*(^)(OkidokiTableViewViewForHeaderBlock block))viewForHeaderInSection;

/** 
 tableView:viewForFooterInSection: block
 @code
 .viewForFooterInSection(^UIView *(UITableView *tableView, NSInteger section) {
     return footerView;
 })
 @endcode
 */
- (Okidoki*(^)(OkidokiTableViewViewForFooterBlock block))viewForFooterInSection;

/** 
 tableView:didSelectRowAtIndexPath: block
 @code
 .didSelectRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath) {
     NSLog(@"Selected");
 })
 @endcode
 */
- (Okidoki*(^)(OkidokiTableViewDidSelectRowBlock block))didSelectRowAtIndexPath;

/** 
 tableView:didDeselectRowAtIndexPath: block
 @code
 .didDeselectRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath) {
     NSLog(@"Deselected");
 })
 @endcode
 */
- (Okidoki*(^)(OkidokiTableViewDidDeselectRowBlock block))didDeselectRowAtIndexPath;

/** 
 tableView:willDisplayCell:forRowAtIndexPath: block
 @code
 .willDisplayCell(^(UITableView *tableView, UITableViewCell *cell, NSIndexPath *indexPath) {
     // Configure cell display
 })
 @endcode
 */
- (Okidoki*(^)(OkidokiTableViewWillDisplayCellBlock block))willDisplayCell;

/** 
 tableView:didEndDisplayingCell:forRowAtIndexPath: block
 @code
 .didEndDisplayingCell(^(UITableView *tableView, UITableViewCell *cell, NSIndexPath *indexPath) {
     // Cleanup after cell
 })
 @endcode
 */
- (Okidoki*(^)(OkidokiTableViewDidEndDisplayingCellBlock block))didEndDisplayingCell;

/** 
 tableView:editingStyleForRowAtIndexPath: block
 @code
 .editingStyleForRowAtIndexPath(^UITableViewCellEditingStyle(UITableView *tableView, NSIndexPath *indexPath) {
     return UITableViewCellEditingStyleDelete;
 })
 @endcode
 */
- (Okidoki*(^)(OkidokiTableViewEditingStyleBlock block))editingStyleForRowAtIndexPath;

@end


// UICollectionView Delegate Block Types
typedef NSInteger(^OkidokiCollectionViewNumberOfSectionsBlock)(UICollectionView *collectionView);
typedef NSInteger(^OkidokiCollectionViewNumberOfItemsInSectionBlock)(UICollectionView *collectionView, NSInteger section);
typedef UICollectionViewCell * _Nonnull(^OkidokiCollectionViewCellForItemAtIndexPathBlock)(UICollectionView *collectionView, NSIndexPath *indexPath);
typedef CGSize(^OkidokiCollectionViewSizeForItemBlock)(UICollectionView *collectionView, UICollectionViewLayout *layout, NSIndexPath *indexPath);
typedef UIEdgeInsets(^OkidokiCollectionViewInsetForSectionBlock)(UICollectionView *collectionView, UICollectionViewLayout *layout, NSInteger section);
typedef CGFloat(^OkidokiCollectionViewMinimumLineSpacingBlock)(UICollectionView *collectionView, UICollectionViewLayout *layout, NSInteger section);
typedef CGFloat(^OkidokiCollectionViewMinimumInteritemSpacingBlock)(UICollectionView *collectionView, UICollectionViewLayout *layout, NSInteger section);
typedef UICollectionReusableView * _Nonnull(^OkidokiCollectionViewViewForSupplementaryElementBlock)(UICollectionView *collectionView, NSString *kind, NSIndexPath *indexPath);
typedef void(^OkidokiCollectionViewDidSelectItemBlock)(UICollectionView *collectionView, NSIndexPath *indexPath);
typedef void(^OkidokiCollectionViewDidDeselectItemBlock)(UICollectionView *collectionView, NSIndexPath *indexPath);
typedef void(^OkidokiCollectionViewWillDisplayCellBlock)(UICollectionView *collectionView, UICollectionViewCell *cell, NSIndexPath *indexPath);
typedef void(^OkidokiCollectionViewDidEndDisplayingCellBlock)(UICollectionView *collectionView, UICollectionViewCell *cell, NSIndexPath *indexPath);

@interface Okidoki (UICollectionView)

// Register Cell
/** 
 Register cell class with identifier
 params: NSArray: @[cellClass, @"identifier"]
 @code
 .cvRegisterCellClass(@[[UICollectionViewCell class], @"Cell"])
 @endcode
 */
- (Okidoki*(^)(NSArray *params))cvRegisterCellClass;

/** 
 Register cell nib with identifier
 params: NSArray: @[nibName, @"identifier"] or @[UINib, @"identifier"]
 @code
 .cvRegisterCellNib(@[@"MyCell", @"Cell"])
 @endcode
 */
- (Okidoki*(^)(NSArray *params))cvRegisterCellNib;

/** 
 Register supplementary view class with identifier
 params: NSArray: @[viewClass, @"kind", @"identifier"]
 @code
 .cvRegisterSupplementaryViewClass(@[[UICollectionReusableView class], UICollectionElementKindSectionHeader, @"Header"])
 @endcode
 */
- (Okidoki*(^)(NSArray *params))cvRegisterSupplementaryViewClass;

/** 
 Register supplementary view nib with identifier
 params: NSArray: @[nibName, @"kind", @"identifier"] or @[UINib, @"kind", @"identifier"]
 @code
 .cvRegisterSupplementaryViewNib(@[@"HeaderView", UICollectionElementKindSectionHeader, @"Header"])
 @endcode
 */
- (Okidoki*(^)(NSArray *params))cvRegisterSupplementaryViewNib;

// UICollectionViewDataSource
/** 
 numberOfSectionsInCollectionView: block
 @code
 .cvNumberOfSections(^NSInteger(UICollectionView *collectionView) {
     return 2;
 })
 @endcode
 */
- (Okidoki*(^)(OkidokiCollectionViewNumberOfSectionsBlock block))cvNumberOfSections;

/** 
 collectionView:numberOfItemsInSection: block
 @code
 .cvNumberOfItemsInSection(^NSInteger(UICollectionView *collectionView, NSInteger section) {
     return 10;
 })
 @endcode
 */
- (Okidoki*(^)(OkidokiCollectionViewNumberOfItemsInSectionBlock block))cvNumberOfItemsInSection;

/** 
 collectionView:cellForItemAtIndexPath: block
 @code
 .cvCellForItemAtIndexPath(^UICollectionViewCell *(UICollectionView *collectionView, NSIndexPath *indexPath) {
     return cell;
 })
 @endcode
 */
- (Okidoki*(^)(OkidokiCollectionViewCellForItemAtIndexPathBlock block))cvCellForItemAtIndexPath;

/** 
 collectionView:viewForSupplementaryElementOfKind:atIndexPath: block
 @code
 .cvViewForSupplementaryElement(^UICollectionReusableView *(UICollectionView *collectionView, NSString *kind, NSIndexPath *indexPath) {
     return headerView;
 })
 @endcode
 */
- (Okidoki*(^)(OkidokiCollectionViewViewForSupplementaryElementBlock block))cvViewForSupplementaryElement;

// UICollectionViewDelegate
/** 
 collectionView:didSelectItemAtIndexPath: block
 @code
 .cvDidSelectItemAtIndexPath(^(UICollectionView *collectionView, NSIndexPath *indexPath) {
     NSLog(@"Selected");
 })
 @endcode
 */
- (Okidoki*(^)(OkidokiCollectionViewDidSelectItemBlock block))cvDidSelectItemAtIndexPath;

/** 
 collectionView:didDeselectItemAtIndexPath: block
 @code
 .cvDidDeselectItemAtIndexPath(^(UICollectionView *collectionView, NSIndexPath *indexPath) {
     NSLog(@"Deselected");
 })
 @endcode
 */
- (Okidoki*(^)(OkidokiCollectionViewDidDeselectItemBlock block))cvDidDeselectItemAtIndexPath;

/** 
 collectionView:willDisplayCell:forItemAtIndexPath: block
 @code
 .cvWillDisplayCell(^(UICollectionView *collectionView, UICollectionViewCell *cell, NSIndexPath *indexPath) {
     // Configure cell display
 })
 @endcode
 */
- (Okidoki*(^)(OkidokiCollectionViewWillDisplayCellBlock block))cvWillDisplayCell;

/** 
 collectionView:didEndDisplayingCell:forItemAtIndexPath: block
 @code
 .cvDidEndDisplayingCell(^(UICollectionView *collectionView, UICollectionViewCell *cell, NSIndexPath *indexPath) {
     // Cleanup after cell
 })
 @endcode
 */
- (Okidoki*(^)(OkidokiCollectionViewDidEndDisplayingCellBlock block))cvDidEndDisplayingCell;

// UICollectionViewDelegateFlowLayout
/** 
 collectionView:layout:sizeForItemAtIndexPath: block
 @code
 .cvSizeForItemAtIndexPath(^CGSize(UICollectionView *collectionView, UICollectionViewLayout *layout, NSIndexPath *indexPath) {
     return CGSizeMake(100, 100);
 })
 @endcode
 */
- (Okidoki*(^)(OkidokiCollectionViewSizeForItemBlock block))cvSizeForItemAtIndexPath;

/** 
 collectionView:layout:insetForSectionAtIndex: block
 @code
 .cvInsetForSectionAtIndex(^UIEdgeInsets(UICollectionView *collectionView, UICollectionViewLayout *layout, NSInteger section) {
     return UIEdgeInsetsMake(10, 10, 10, 10);
 })
 @endcode
 */
- (Okidoki*(^)(OkidokiCollectionViewInsetForSectionBlock block))cvInsetForSectionAtIndex;

/** 
 collectionView:layout:minimumLineSpacingForSectionAtIndex: block
 @code
 .cvMinimumLineSpacing(^CGFloat(UICollectionView *collectionView, UICollectionViewLayout *layout, NSInteger section) {
     return 10;
 })
 @endcode
 */
- (Okidoki*(^)(OkidokiCollectionViewMinimumLineSpacingBlock block))cvMinimumLineSpacing;

/** 
 collectionView:layout:minimumInteritemSpacingForSectionAtIndex: block
 @code
 .cvMinimumInteritemSpacing(^CGFloat(UICollectionView *collectionView, UICollectionViewLayout *layout, NSInteger section) {
     return 10;
 })
 @endcode
 */
- (Okidoki*(^)(OkidokiCollectionViewMinimumInteritemSpacingBlock block))cvMinimumInteritemSpacing;

@end


// UITextField Delegate Block Types
typedef BOOL(^OkidokiTextFieldShouldBeginEditingBlock)(UITextField *textField);
typedef void(^OkidokiTextFieldDidBeginEditingBlock)(UITextField *textField);
typedef BOOL(^OkidokiTextFieldShouldEndEditingBlock)(UITextField *textField);
typedef void(^OkidokiTextFieldDidEndEditingBlock)(UITextField *textField);
typedef BOOL(^OkidokiTextFieldShouldChangeCharactersBlock)(UITextField *textField, NSRange range, NSString *replacementString);
typedef BOOL(^OkidokiTextFieldShouldClearBlock)(UITextField *textField);
typedef BOOL(^OkidokiTextFieldShouldReturnBlock)(UITextField *textField);

@interface Okidoki (UITextField)

/** 
 textFieldShouldBeginEditing: block
 @code
 .tfShouldBeginEditing(^BOOL(UITextField *textField) {
     return YES;
 })
 @endcode
 */
- (Okidoki*(^)(OkidokiTextFieldShouldBeginEditingBlock block))tfShouldBeginEditing;

/** 
 textFieldDidBeginEditing: block
 @code
 .tfDidBeginEditing(^(UITextField *textField) {
     NSLog(@"Begin editing");
 })
 @endcode
 */
- (Okidoki*(^)(OkidokiTextFieldDidBeginEditingBlock block))tfDidBeginEditing;

/** 
 textFieldShouldEndEditing: block
 @code
 .tfShouldEndEditing(^BOOL(UITextField *textField) {
     return YES;
 })
 @endcode
 */
- (Okidoki*(^)(OkidokiTextFieldShouldEndEditingBlock block))tfShouldEndEditing;

/** 
 textFieldDidEndEditing: block
 @code
 .tfDidEndEditing(^(UITextField *textField) {
     NSLog(@"End editing");
 })
 @endcode
 */
- (Okidoki*(^)(OkidokiTextFieldDidEndEditingBlock block))tfDidEndEditing;

/** 
 textField:shouldChangeCharactersInRange:replacementString: block
 @code
 .tfShouldChangeCharacters(^BOOL(UITextField *textField, NSRange range, NSString *replacementString) {
     return YES;
 })
 @endcode
 */
- (Okidoki*(^)(OkidokiTextFieldShouldChangeCharactersBlock block))tfShouldChangeCharacters;

/** 
 textFieldShouldClear: block
 @code
 .tfShouldClear(^BOOL(UITextField *textField) {
     return YES;
 })
 @endcode
 */
- (Okidoki*(^)(OkidokiTextFieldShouldClearBlock block))tfShouldClear;

/** 
 textFieldShouldReturn: block
 @code
 .tfShouldReturn(^BOOL(UITextField *textField) {
     [textField resignFirstResponder];
     return YES;
 })
 @endcode
 */
- (Okidoki*(^)(OkidokiTextFieldShouldReturnBlock block))tfShouldReturn;

@end


// UITextView Delegate Block Types
typedef BOOL(^OkidokiTextViewShouldBeginEditingBlock)(UITextView *textView);
typedef void(^OkidokiTextViewDidBeginEditingBlock)(UITextView *textView);
typedef BOOL(^OkidokiTextViewShouldEndEditingBlock)(UITextView *textView);
typedef void(^OkidokiTextViewDidEndEditingBlock)(UITextView *textView);
typedef void(^OkidokiTextViewDidChangeBlock)(UITextView *textView);
typedef void(^OkidokiTextViewDidChangeSelectionBlock)(UITextView *textView);
typedef BOOL(^OkidokiTextViewShouldChangeTextBlock)(UITextView *textView, NSRange range, NSString *replacementText);
typedef BOOL(^OkidokiTextViewShouldChangeTextInRangesBlock)(UITextView *textView, NSArray<NSValue *> *ranges, NSString *replacementText) API_AVAILABLE(ios(26.0), tvos(26.0), visionos(26.0), watchos(26.0));

@interface Okidoki (UITextView)

/** 
 textViewShouldBeginEditing: block
 @code
 .tvShouldBeginEditing(^BOOL(UITextView *textView) {
     return YES;
 })
 @endcode
 */
- (Okidoki*(^)(OkidokiTextViewShouldBeginEditingBlock block))tvShouldBeginEditing;

/** 
 textViewDidBeginEditing: block
 @code
 .tvDidBeginEditing(^(UITextView *textView) {
     NSLog(@"Begin editing");
 })
 @endcode
 */
- (Okidoki*(^)(OkidokiTextViewDidBeginEditingBlock block))tvDidBeginEditing;

/** 
 textViewShouldEndEditing: block
 @code
 .tvShouldEndEditing(^BOOL(UITextView *textView) {
     return YES;
 })
 @endcode
 */
- (Okidoki*(^)(OkidokiTextViewShouldEndEditingBlock block))tvShouldEndEditing;

/** 
 textViewDidEndEditing: block
 @code
 .tvDidEndEditing(^(UITextView *textView) {
     NSLog(@"End editing");
 })
 @endcode
 */
- (Okidoki*(^)(OkidokiTextViewDidEndEditingBlock block))tvDidEndEditing;

/** 
 textViewDidChange: block
 @code
 .tvDidChange(^(UITextView *textView) {
     NSLog(@"Text changed: %@", textView.text);
 })
 @endcode
 */
- (Okidoki*(^)(OkidokiTextViewDidChangeBlock block))tvDidChange;

/** 
 textViewDidChangeSelection: block
 @code
 .tvDidChangeSelection(^(UITextView *textView) {
     NSLog(@"Selection changed");
 })
 @endcode
 */
- (Okidoki*(^)(OkidokiTextViewDidChangeSelectionBlock block))tvDidChangeSelection;

/** 
 textView:shouldChangeTextInRange:replacementText: block
 @code
 .tvShouldChangeText(^BOOL(UITextView *textView, NSRange range, NSString *replacementText) {
     return YES;
 })
 @endcode
 */
- (Okidoki*(^)(OkidokiTextViewShouldChangeTextBlock block))tvShouldChangeText;

/** 
 textView:shouldChangeTextInRanges:replacementText: block (iOS 26+)
 Compatible with new API, automatically fallbacks to old method on older iOS
 @code
 .tvShouldChangeTextInRanges(^BOOL(UITextView *textView, NSArray<NSValue *> *ranges, NSString *replacementText) {
     return YES;
 }) API_AVAILABLE(ios(26.0), tvos(26.0), visionos(26.0), watchos(26.0))
 @endcode
 */
- (Okidoki*(^)(OkidokiTextViewShouldChangeTextInRangesBlock block))tvShouldChangeTextInRanges API_AVAILABLE(ios(26.0), tvos(26.0), visionos(26.0), watchos(26.0));

@end


@interface Okidoki (AutoLayout)

#pragma mark - AutoLayout Anchors

/**
 Leading anchor constraint
 params:  NSArray: @[toView, @(constant)] or @[toView] (constant default 0)
        toView can be UIView (use its leadingAnchor) or NSLayoutXAxisAnchor
 @code
 .leadingAnchor(@[superview, @20])
 .leadingAnchor(@[superview])
 @endcode
 */
- (Okidoki*(^)(id params))leadingAnchor;

/**
 Trailing anchor constraint
 params:  NSArray: @[toView, @(constant)] or @[toView] (constant default 0)
        toView can be UIView (use its trailingAnchor) or NSLayoutXAxisAnchor
 @code
 .trailingAnchor(@[superview, @(-20)])
 @endcode
 */
- (Okidoki*(^)(id params))trailingAnchor;

/**
 Left anchor constraint
 params:  NSArray: @[toView, @(constant)] or @[toView] (constant default 0)
        toView can be UIView (use its leftAnchor) or NSLayoutXAxisAnchor
 @code
 .leftAnchor(@[superview, @20])
 @endcode
 */
- (Okidoki*(^)(id params))leftAnchor;

/**
 Right anchor constraint
 params:  NSArray: @[toView, @(constant)] or @[toView] (constant default 0)
        toView can be UIView (use its rightAnchor) or NSLayoutXAxisAnchor
 @code
 .rightAnchor(@[superview, @(-20)])
 @endcode
 */
- (Okidoki*(^)(id params))rightAnchor;

/**
 Top anchor constraint
 params:  NSArray: @[toView, @(constant)] or @[toView] (constant default 0)
        toView can be UIView (use its topAnchor) or NSLayoutYAxisAnchor
 @code
 .topAnchor(@[superview, @10])
 @endcode
 */
- (Okidoki*(^)(id params))topAnchor;

/**
 Bottom anchor constraint
 params:  NSArray: @[toView, @(constant)] or @[toView] (constant default 0)
        toView can be UIView (use its bottomAnchor) or NSLayoutYAxisAnchor
 @code
 .bottomAnchor(@[superview, @(-10)])
 @endcode
 */
- (Okidoki*(^)(id params))bottomAnchor;

/**
 Width anchor constraint
 params:  NSNumber: @(width) for constant width
        NSArray: @[toView, @(multiplier), @(constant)] for relative width
 @code
 .widthAnchor(@100)
 .widthAnchor(@[superview, @0.5, @(-20)])
 @endcode
 */
- (Okidoki*(^)(id params))widthAnchor;

/**
 Height anchor constraint
 params:  NSNumber: @(height) for constant height
        NSArray: @[toView, @(multiplier), @(constant)] for relative height
 @code
 .heightAnchor(@50)
 .heightAnchor(@[superview, @0.5, @0])
 @endcode
 */
- (Okidoki*(^)(id params))heightAnchor;

/**
 CenterX anchor constraint
 params:  NSArray: @[toView, @(constant)] or @[toView] (constant default 0)
        toView can be UIView (use its centerXAnchor) or NSLayoutXAxisAnchor
 @code
 .centerXAnchor(@[superview, @10])
 @endcode
 */
- (Okidoki*(^)(id params))centerXAnchor;

/**
 CenterY anchor constraint
 params:  NSArray: @[toView, @(constant)] or @[toView] (constant default 0)
        toView can be UIView (use its centerYAnchor) or NSLayoutYAxisAnchor
 @code
 .centerYAnchor(@[superview, @0])
 @endcode
 */
- (Okidoki*(^)(id params))centerYAnchor;

/**
 Edge to superview with insets
 params:  NSNumber: @(inset) for all edges
        NSArray: @[@(top), @(left), @(bottom), @(right)]
        NSValue: UIEdgeInsets
        nil: all edges = 0
 @code
 .edgeToSuperView(@20)
 .edgeToSuperView(@[@10, @20, @10, @20])
 .edgeToSuperView(nil)
 @endcode
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
/** color: UIColor, NSString(eg.FFFEEE,#FFFEEE,0xFFFEEE,0XFFFEEE) */
+ (UIColor *)okidokiColor:(id)color;
@end


@interface UIFont (Okidoki)
/** font: UIFont, NSString(eg.@"17",@"s17",@"b17",@"i17") */
+ (UIFont *)okidokiFont:(id)font;
@end


@interface UIAlertController (Okidoki)

/// 只展示图片的
+ (instancetype)okidoki_alertWithTitle:(nullable NSString *)title image:(NSString *_Nonnull)image imageSize:(CGSize)imageSize viewOffset:(CGPoint)viewOffset preferredStyle:(UIAlertControllerStyle)preferredStyle;

/// 展示自定义视图
+ (instancetype)okidoki_alertWithTitle:(nullable NSString *)title customView:(UIView *_Nonnull)customView viewSize:(CGSize)viewSize viewOffset:(CGPoint)viewOffset preferredStyle:(UIAlertControllerStyle)preferredStyle;

@end

NS_ASSUME_NONNULL_END
