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

// version: 0.1.0
// 2026-04-20 11:08:14

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#define kNumberAdaptor(x) Okidoki_NumberAdaptor(x)

CGFloat Okidoki_NumberAdaptor(CGFloat number);

// AutoLayout constraint identifiers
FOUNDATION_EXPORT NSString * _Nonnull const kOkidokiConstraintLeading;
FOUNDATION_EXPORT NSString * _Nonnull const kOkidokiConstraintLeadingGTE;
FOUNDATION_EXPORT NSString * _Nonnull const kOkidokiConstraintLeadingLTE;
FOUNDATION_EXPORT NSString * _Nonnull const kOkidokiConstraintTrailing;
FOUNDATION_EXPORT NSString * _Nonnull const kOkidokiConstraintTrailingGTE;
FOUNDATION_EXPORT NSString * _Nonnull const kOkidokiConstraintTrailingLTE;
FOUNDATION_EXPORT NSString * _Nonnull const kOkidokiConstraintLeft;
FOUNDATION_EXPORT NSString * _Nonnull const kOkidokiConstraintLeftGTE;
FOUNDATION_EXPORT NSString * _Nonnull const kOkidokiConstraintLeftLTE;
FOUNDATION_EXPORT NSString * _Nonnull const kOkidokiConstraintRight;
FOUNDATION_EXPORT NSString * _Nonnull const kOkidokiConstraintRightGTE;
FOUNDATION_EXPORT NSString * _Nonnull const kOkidokiConstraintRightLTE;
FOUNDATION_EXPORT NSString * _Nonnull const kOkidokiConstraintTop;
FOUNDATION_EXPORT NSString * _Nonnull const kOkidokiConstraintTopGTE;
FOUNDATION_EXPORT NSString * _Nonnull const kOkidokiConstraintTopLTE;
FOUNDATION_EXPORT NSString * _Nonnull const kOkidokiConstraintBottom;
FOUNDATION_EXPORT NSString * _Nonnull const kOkidokiConstraintBottomGTE;
FOUNDATION_EXPORT NSString * _Nonnull const kOkidokiConstraintBottomLTE;
FOUNDATION_EXPORT NSString * _Nonnull const kOkidokiConstraintWidth;
FOUNDATION_EXPORT NSString * _Nonnull const kOkidokiConstraintWidthGTE;
FOUNDATION_EXPORT NSString * _Nonnull const kOkidokiConstraintWidthLTE;
FOUNDATION_EXPORT NSString * _Nonnull const kOkidokiConstraintHeight;
FOUNDATION_EXPORT NSString * _Nonnull const kOkidokiConstraintHeightGTE;
FOUNDATION_EXPORT NSString * _Nonnull const kOkidokiConstraintHeightLTE;
FOUNDATION_EXPORT NSString * _Nonnull const kOkidokiConstraintCenterX;
FOUNDATION_EXPORT NSString * _Nonnull const kOkidokiConstraintCenterXGTE;
FOUNDATION_EXPORT NSString * _Nonnull const kOkidokiConstraintCenterXLTE;
FOUNDATION_EXPORT NSString * _Nonnull const kOkidokiConstraintCenterY;
FOUNDATION_EXPORT NSString * _Nonnull const kOkidokiConstraintCenterYGTE;
FOUNDATION_EXPORT NSString * _Nonnull const kOkidokiConstraintCenterYLTE;

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
@property (nonatomic, strong, readonly) Okidoki *(^tag)(id tag);

/** NSValue,NSString */
@property (nonatomic, strong, readonly) Okidoki *(^frame)(id frame);

/** NSNumber,NSString */
@property (nonatomic, strong, readonly) Okidoki *(^alpha)(id alpha);

/** NSNumber,NSString */
@property (nonatomic, strong, readonly) Okidoki *(^hidden)(id hidden);

/** UIColor,NSString(eg.FFFEEE,#FFFEEE,0xFFFEEE,0XFFFEEE) */
@property (nonatomic, strong, readonly) Okidoki *(^bgColor)(id bgColor);

/** UIColor,NSString(eg.FFFEEE,#FFFEEE,0xFFFEEE,0XFFFEEE) */
@property (nonatomic, strong, readonly) Okidoki *(^bdColor)(id bdColor);

/** NSNumber,NSString */
@property (nonatomic, strong, readonly) Okidoki *(^bdWidth)(id bdWidth);

/** NSNumber,NSString */
@property (nonatomic, strong, readonly) Okidoki *(^cnRadius)(id cnRadius);

/** NSArray: @[@1,@2,@3,@4] */
@property (nonatomic, strong, readonly) Okidoki *(^mkCorners)(id mkCorners);

/** @(YES) or @(NO),NSString */
@property (nonatomic, strong, readonly) Okidoki *(^mtBounds)(id mtBounds);

/** UIColor,NSString(eg.FFFEEE,#FFFEEE,0xFFFEEE,0XFFFEEE) */
@property (nonatomic, strong, readonly) Okidoki *(^shadowColor)(id shadowColor);

/** NSNumber,NSString */
@property (nonatomic, strong, readonly) Okidoki *(^shadowOpacity)(id shadowOpacity);

/** NSValue,NSString */
@property (nonatomic, strong, readonly) Okidoki *(^shadowOffset)(id shadowOffset);

/** NSNumber,NSString */
@property (nonatomic, strong, readonly) Okidoki *(^shadowRadius)(id shadowRadius);

/** UIBezierPath,CGPathRef */
@property (nonatomic, strong, readonly) Okidoki *(^shadowPath)(id shadowPath);

/** UIView */
@property (nonatomic, strong, readonly) Okidoki *(^addSubview)(id addSubview);

/**
 UIView, block: void(^)(Okidoki *ok)
 @code
 .addSubviewWithConfig(childView, ^(Okidoki *ok) {
     ok.bgColor(@"FF0000").frame(@"{{0,0},{100,100}}");
 })
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^addSubviewWithConfig)(UIView *subview, void(^config)(Okidoki *ok));

/**
 UIView, block: void(^)(Okidoki *ok, UIView *superView)
 @code
 .addSubviewWithConfig_superView(childView, ^(Okidoki *ok, UIView *superView) {
     ok.bgColor(@"00FF00").frame(CGRectMake(0, 0, superView.bounds.size.width, 50));
 })
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^addSubviewWithConfig_superView)(UIView *subview, void(^config)(Okidoki *ok, UIView *superView));

/** UIView */
@property (nonatomic, strong, readonly) Okidoki *(^addToSuperview)(UIView *superView);

/** @(YES) or @(NO),NSString */
@property (nonatomic, strong, readonly) Okidoki *(^userInteractionEnabled)(id userInteractionEnabled);


#pragma mark - Gesture

/** 
 Tap gesture, block: void(^)(UITapGestureRecognizer *tap)
 @code
 .tapGesture(^(UITapGestureRecognizer *tap) {
     NSLog(@"Tapped");
 })
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^tapGesture)(void(^block)(UITapGestureRecognizer *tap));

/**
 LongPress gesture, block: void(^)(UILongPressGestureRecognizer *longPress)
 @code
 .longPressGesture(^(UILongPressGestureRecognizer *longPress) {
     NSLog(@"Long pressed");
 })
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^longPressGesture)(void(^block)(UILongPressGestureRecognizer *longPress));

/**
 Swipe gesture, direction: UISwipeGestureRecognizerDirection, block: void(^)(UISwipeGestureRecognizer *swipe)
 @code
 .swipeGesture(UISwipeGestureRecognizerDirectionLeft, ^(UISwipeGestureRecognizer *swipe) {
     NSLog(@"Swiped");
 })
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^swipeGesture)(NSUInteger direction, void(^block)(UISwipeGestureRecognizer *swipe));

/**
 Pan gesture, block: void(^)(UIPanGestureRecognizer *pan)
 @code
 .panGesture(^(UIPanGestureRecognizer *pan) {
     CGPoint translation = [pan translationInView:pan.view];
     NSLog(@"Pan: %@", NSStringFromCGPoint(translation));
 })
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^panGesture)(void(^block)(UIPanGestureRecognizer *pan));

/**
 Pinch gesture, block: void(^)(UIPinchGestureRecognizer *pinch)
 @code
 .pinchGesture(^(UIPinchGestureRecognizer *pinch) {
     NSLog(@"Scale: %f", pinch.scale);
 })
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^pinchGesture)(void(^block)(UIPinchGestureRecognizer *pinch));

/**
 Rotation gesture, block: void(^)(UIRotationGestureRecognizer *rotation)
 @code
 .rotationGesture(^(UIRotationGestureRecognizer *rotation) {
     NSLog(@"Rotation: %f", rotation.rotation);
 })
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^rotationGesture)(void(^block)(UIRotationGestureRecognizer *rotation));

/** Remove gesture by class, example: .removeGesture([UITapGestureRecognizer class]) */
@property (nonatomic, strong, readonly) Okidoki *(^removeGesture)(Class gestureClass);

/** Remove all gestures */
@property (nonatomic, strong, readonly) Okidoki *(^removeAllGestures)(void);


#pragma mark - UILabel & UITextView & UITextField

/** NSString */
@property (nonatomic, strong, readonly) Okidoki *(^text)(id text);

/** UIFont,NSString(@"17",@"s17",@"b17",@"i17") */
@property (nonatomic, strong, readonly) Okidoki *(^font)(id font);

/** UIColor,NSString(eg.FFFEEE,#FFFEEE,0xFFFEEE,0XFFFEEE) */
@property (nonatomic, strong, readonly) Okidoki *(^color)(id color);

/** NSNumber: @0,@1,@2,NSString */
@property (nonatomic, strong, readonly) Okidoki *(^align)(id align);

/**
 substring: NSString, value:color(UIColor,NSString) or font(UIFont,NSString).
 @code
 .text(@"Hello World").attributedSubstring(@"World", @"FF0000")
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^attributedSubstring)(id substring, id value);

/**
 substring: NSString, value:color(UIColor,NSString) or font(UIFont,NSString), range: NSValue.
 @code
 .text(@"Hello World").attributedSubstringInRange(@"World", @"FF0000", [NSValue valueWithRange:NSMakeRange(6, 5)])
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^attributedSubstringInRange)(id substring, id value, id range);

/**
 substring: NSString, key: NSAttributedStringKey, value: color/font/number etc.
 @code
 .text(@"Hello World").attributedSubstringKeyValue(@"World", NSForegroundColorAttributeName, [UIColor redColor])
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^attributedSubstringKeyValue)(id substring, id key, id value);

/**
 substring: NSString, key: NSAttributedStringKey, value: color/font/number etc. range: NSValue.
 @code
 .attributedSubstringKeyValueInRange(@"World", NSForegroundColorAttributeName, [UIColor redColor], [NSValue valueWithRange:NSMakeRange(6, 5)])
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^attributedSubstringKeyValueInRange)(id substring, id key, id value, id range);


#pragma mark - UILabel

/** NSNumber(NSInteger) ,NSString*/
@property (nonatomic, strong, readonly) Okidoki *(^lines)(id lines);

/** adjustsFontSizeToFitWidth: @(YES) or @(NO), NSString*/
@property (nonatomic, strong, readonly) Okidoki *(^adjust)(id adjust);

/** NSNumber(CGFloat), NSString*/
@property (nonatomic, strong, readonly) Okidoki *(^lineSpace)(id lineSpace);

/** NSNumber(CGFloat), 0 means no max width limit. NSString */
@property (nonatomic, strong, readonly) Okidoki *(^autoWidth)(id autoWidth);

/** NSNumber(CGFloat), 0 means no max height limit. NSString */
@property (nonatomic, strong, readonly) Okidoki *(^autoHeight)(id autoHeight);

/** UIColor,NSString(eg.FFFEEE,#FFFEEE,0xFFFEEE,0XFFFEEE) */
@property (nonatomic, strong, readonly) Okidoki *(^highlightedTextColor)(id highlightedTextColor);


#pragma mark - UIControl

/** @(YES) or @(NO),NSString */
@property (nonatomic, strong, readonly) Okidoki *(^enabled)(id enabled);

/** @(YES) or @(NO),NSString */
@property (nonatomic, strong, readonly) Okidoki *(^selected)(id selected);

/** @(YES) or @(NO),NSString */
@property (nonatomic, strong, readonly) Okidoki *(^highlighted)(id highlighted);

/** NSNumber: @0,@1,@2,@3, NSString */
@property (nonatomic, strong, readonly) Okidoki *(^contentVerticalAlignment)(id contentVerticalAlignment);

/** NSNumber: @0,@1,@2,@3,@4,@5, NSString */
@property (nonatomic, strong, readonly) Okidoki *(^contentHorizontalAlignment)(id contentHorizontalAlignment);

/**
 Add block for control events, controlEvents: UIControlEvents, block: void(^)(__kindof UIControl *sender)
 @code
 .addControlEvent(UIControlEventTouchUpInside, ^(UIButton *sender) {
     NSLog(@"Button tapped");
 })
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^addControlEvent)(UIControlEvents controlEvents, void(^block)(__kindof UIControl *sender));

/** Remove all blocks for control events, controlEvents: UIControlEvents */
@property (nonatomic, strong, readonly) Okidoki *(^removeControlEvent)(UIControlEvents controlEvents);

/** Remove all targets and blocks for all events */
@property (nonatomic, strong, readonly) Okidoki *(^removeAllControlEvents)(void);


#pragma mark - UIButton

/** title: NSString state: normal*/
@property (nonatomic, strong, readonly) Okidoki *(^title)(id title);

/**
 title: NSString, state: NSNumber
 @code
 .titleForState(@"Highlighted", @(UIControlStateHighlighted))
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^titleForState)(id title, id state);

/**
 color: UIColor,NSString(eg.#FFFEEE,0xFFFEEE,0XFFFEEE) , state: NSNumber
 @code
 .colorForState(@"FF0000", @(UIControlStateNormal))
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^colorForState)(id color, id state);

/**
 image: NSString, UIImage, state: NSNumber
 @code
 .imageForState(@"icon_home", @(UIControlStateNormal))
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^imageForState)(id image, id state);

/**
 bgImage: NSString, UIImage, state: NSNumber
 @code
 .bgImageForState(@"bg_button", @(UIControlStateNormal))
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^bgImageForState)(id bgImage, id state);

/**
 lineSpace: NSNumber, state: NSNumber
 @code
 .lineSpaceForState(@5, @(UIControlStateNormal))
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^lineSpaceForState)(id lineSpace, id state);

/** space: NSNumber */
@property (nonatomic, strong, readonly) Okidoki *(^imageUpTitleDown)(id imageUpTitleDown);

/** space: NSNumber */
@property (nonatomic, strong, readonly) Okidoki *(^imageDownTitleUp)(id imageDownTitleUp);

/** space: NSNumber */
@property (nonatomic, strong, readonly) Okidoki *(^imageRightTitleLeft)(id imageRightTitleLeft);

/** space: NSNumber */
@property (nonatomic, strong, readonly) Okidoki *(^imageLeftTitleRight)(id imageLeftTitleRight);

/** all center */
@property (nonatomic, strong, readonly) Okidoki *(^imageCenterTitleCenter)(void);

/**
 substring: NSString, value:color or font, state: NSNumber
 @code
 .titleForState(@"Hello World", @(UIControlStateNormal)).attributedSubstringForState(@"World", @"FF0000", @(UIControlStateNormal))
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^attributedSubstringForState)(id substring, id value, id state);

/**
 substring: NSString, value:color or font, range: NSValue, state: NSNumber
 @code
 .attributedSubstringInRangeForState(@"World", @"FF0000", [NSValue valueWithRange:NSMakeRange(6, 5)], @(UIControlStateNormal))
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^attributedSubstringInRangeForState)(id substring, id value, id range, id state);

/**
 substring: NSString, key: NSAttributedStringKey, value: color/font/number etc.
 @code
 .attributedSubstringKeyValueForState(@"World", NSForegroundColorAttributeName, [UIColor redColor], @(UIControlStateNormal))
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^attributedSubstringKeyValueForState)(id substring, id key, id value, id state);

/**
 substring: NSString, key: NSAttributedStringKey, value: color/font/number etc. range: NSValue.
 @code
 .attributedSubstringKeyValueInRangeForState(@"World", NSForegroundColorAttributeName, [UIColor redColor], [NSValue valueWithRange:NSMakeRange(6, 5)], @(UIControlStateNormal))
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^attributedSubstringKeyValueInRangeForState)(id substring, id key, id value, id range, id state);


#pragma mark - UIImageView

/** image: UIImage, NSString */
@property (nonatomic, strong, readonly) Okidoki *(^image)(id image);

/** highlightedImage: UIImage, NSString */
@property (nonatomic, strong, readonly) Okidoki *(^highlightedImage)(id highlightedImage);

/**
 image: UIImage,NSString, color: UIColor
 @code
 .imageForTintColor(@"icon_home", [UIColor redColor])
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^imageForTintColor)(id image, id color);


#pragma mark - UITextField

/** borderStyle, NSString,NSNumber: @1,@2,@3,@4 */
@property (nonatomic, strong, readonly) Okidoki *(^bdStyle)(id bdStyle);

/** placeholder, NSString */
@property (nonatomic, strong, readonly) Okidoki *(^pHolder)(id pHolder);

/** placeholder color, UIColor,NSString(eg.#FFFEEE,0xFFFEEE,0XFFFEEE) */
@property (nonatomic, strong, readonly) Okidoki *(^pHColor)(id pHColor);

/** placeholder font, UIFont */
@property (nonatomic, strong, readonly) Okidoki *(^pHFont)(id pHFont);

/** clearButtonMode, NSNumber: @1,@2,@3,@4 */
@property (nonatomic, strong, readonly) Okidoki *(^cbMode)(id cbMode);

/** leftViewMode, NSNumber: @1,@2,@3,@4 */
@property (nonatomic, strong, readonly) Okidoki *(^lvMode)(id lvMode);

/** rightViewMode, NSNumber: @1,@2,@3,@4 */
@property (nonatomic, strong, readonly) Okidoki *(^rvMode)(id rvMode);

/** leftView, UIView */
@property (nonatomic, strong, readonly) Okidoki *(^lfView)(id lfView);

/** rightView, UIView */
@property (nonatomic, strong, readonly) Okidoki *(^rtView)(id rtView);

/** secureTextEntry, BOOL: @YES, @NO */
@property (nonatomic, strong, readonly) Okidoki *(^secure)(id secure);


#pragma mark - UIScrollView

/** NSValue(CGPoint), NSString */
@property (nonatomic, strong, readonly) Okidoki *(^contentOffset)(id contentOffset);

/** NSValue(CGSize), NSString */
@property (nonatomic, strong, readonly) Okidoki *(^contentSize)(id contentSize);

/** NSValue(UIEdgeInsets), NSString */
@property (nonatomic, strong, readonly) Okidoki *(^contentInset)(id contentInset);

/** @(YES) or @(NO), NSString */
@property (nonatomic, strong, readonly) Okidoki *(^directionalLockEnabled)(id directionalLockEnabled);

/** @(YES) or @(NO), NSString */
@property (nonatomic, strong, readonly) Okidoki *(^alwaysBounceVertical)(id alwaysBounceVertical);

/** @(YES) or @(NO), NSString */
@property (nonatomic, strong, readonly) Okidoki *(^alwaysBounceHorizontal)(id alwaysBounceHorizontal);

/** @(YES) or @(NO), NSString */
@property (nonatomic, strong, readonly) Okidoki *(^scrollEnabled)(id scrollEnabled);

/** NSNumber: @0,@1,@2, NSString */
@property (nonatomic, strong, readonly) Okidoki *(^indicatorStyle)(id indicatorStyle);

/** @(YES) or @(NO), NSString */
@property (nonatomic, strong, readonly) Okidoki *(^delaysContentTouches)(id delaysContentTouches);

/** @(YES) or @(NO), NSString */
@property (nonatomic, strong, readonly) Okidoki *(^canCancelContentTouches)(id canCancelContentTouches);

/** NSNumber, NSString */
@property (nonatomic, strong, readonly) Okidoki *(^minimumZoomScale)(id minimumZoomScale);

/** NSNumber, NSString */
@property (nonatomic, strong, readonly) Okidoki *(^maximumZoomScale)(id maximumZoomScale);

/** @(YES) or @(NO), NSString */
@property (nonatomic, strong, readonly) Okidoki *(^bouncesZoom)(id bouncesZoom);

/** @(YES) or @(NO), NSString */
@property (nonatomic, strong, readonly) Okidoki *(^scrollsToTop)(id scrollsToTop);

/** NSNumber, NSString */
@property (nonatomic, strong, readonly) Okidoki *(^decelerationRate)(id decelerationRate);

/** NSNumber, NSString */
@property (nonatomic, strong, readonly) Okidoki *(^zoomScale)(id zoomScale);

/** NSNumber: @0,@1,@2, NSString */
@property (nonatomic, strong, readonly) Okidoki *(^keyboardDismissMode)(id keyboardDismissMode);

/** NSNumber: @0,@1,@2,@3,@4, NSString (iOS 11+) */
@property (nonatomic, strong, readonly) Okidoki *(^contentInsetAdjustmentBehavior)(id contentInsetAdjustmentBehavior);

/** NSValue(UIEdgeInsets), NSString (iOS 11.1+) */
@property (nonatomic, strong, readonly) Okidoki *(^verticalScrollIndicatorInsets)(id verticalScrollIndicatorInsets);

/** NSValue(UIEdgeInsets), NSString (iOS 11.1+) */
@property (nonatomic, strong, readonly) Okidoki *(^horizontalScrollIndicatorInsets)(id horizontalScrollIndicatorInsets);

/** showsVerticalScrollIndicator: @(YES) or @(NO), NSString */
@property (nonatomic, strong, readonly) Okidoki *(^verInd)(id verInd);

/** showsHorizontalScrollIndicator: @(YES) or @(NO), NSString */
@property (nonatomic, strong, readonly) Okidoki *(^horInd)(id horInd);

/** pagingEnabled: @(YES) or @(NO), NSString */
@property (nonatomic, strong, readonly) Okidoki *(^paging)(id paging);

/** bounces: @(YES) or @(NO), NSString */
@property (nonatomic, strong, readonly) Okidoki *(^bounces)(id bounces);


#pragma mark - UITextView

/** 
 editable: @(YES) or @(NO), NSString
 @code
 .editable(@YES)
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^editable)(id editable);

/**
 selectable: @(YES) or @(NO), NSString
 @code
 .selectable(@YES)
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^selectable)(id selectable);

/**
 attributedText: NSAttributedString
 @code
 .attributedText(attributedString)
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^attributedText)(id attributedText);

/**
 inputView: UIView
 @code
 .inputView(customInputView)
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^inputView)(id inputView);

/**
 inputAccessoryView: UIView
 @code
 .inputAccessoryView(accessoryView)
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^inputAccessoryView)(id inputAccessoryView);

/**
 textContainerInset: NSValue(UIEdgeInsets), NSString
 @code
 .textContainerInset([NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)])
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^textContainerInset)(id textContainerInset);

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
@property (nonatomic, strong, readonly) Okidoki *(^didScroll)(OkidokiScrollViewDidScrollBlock block);

/**
 scrollViewDidZoom delegate block
 @code
 scrollView.okidoki.didZoom(^(UIScrollView *scrollView) {
     NSLog(@"zoom scale: %f", scrollView.zoomScale);
 });
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^didZoom)(OkidokiScrollViewDidZoomBlock block);

/**
 scrollViewWillBeginDragging delegate block
 @code
 scrollView.okidoki.willBeginDragging(^(UIScrollView *scrollView) {
     NSLog(@"will begin dragging");
 });
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^willBeginDragging)(OkidokiScrollViewWillBeginDraggingBlock block);

/**
 scrollViewWillEndDragging:withVelocity: delegate block
 @code
 scrollView.okidoki.willEndDragging(^(UIScrollView *scrollView, CGPoint velocity) {
     NSLog(@"velocity: %@", NSStringFromCGPoint(velocity));
 });
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^willEndDragging)(OkidokiScrollViewWillEndDraggingBlock block);

/**
 scrollViewDidEndDragging:willDecelerate: delegate block
 @code
 scrollView.okidoki.didEndDragging(^(UIScrollView *scrollView, BOOL decelerate) {
     NSLog(@"will decelerate: %d", decelerate);
 });
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^didEndDragging)(OkidokiScrollViewDidEndDraggingBlock block);

/**
 scrollViewWillBeginDecelerating delegate block
 @code
 scrollView.okidoki.willBeginDecelerating(^(UIScrollView *scrollView) {
     NSLog(@"will begin decelerating");
 });
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^willBeginDecelerating)(OkidokiScrollViewWillBeginDeceleratingBlock block);

/**
 scrollViewDidEndDecelerating delegate block
 @code
 scrollView.okidoki.didEndDecelerating(^(UIScrollView *scrollView) {
     NSLog(@"did end decelerating");
 });
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^didEndDecelerating)(OkidokiScrollViewDidEndDeceleratingBlock block);

/**
 scrollViewDidEndScrollingAnimation delegate block
 @code
 scrollView.okidoki.didEndScrollingAnimation(^(UIScrollView *scrollView) {
     NSLog(@"animation ended");
 });
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^didEndScrollingAnimation)(OkidokiScrollViewDidEndScrollingAnimationBlock block);

/**
 viewForZoomingInScrollView delegate block
 @code
 scrollView.okidoki.viewForZooming(^UIView *(UIScrollView *scrollView) {
     return imageView;
 });
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^viewForZooming)(OkidokiScrollViewViewForZoomingBlock block);

/**
 scrollViewWillBeginZooming:withView: delegate block
 @code
 scrollView.okidoki.willBeginZooming(^(UIScrollView *scrollView, UIView *view) {
     NSLog(@"will begin zooming view: %@", view);
 });
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^willBeginZooming)(OkidokiScrollViewWillBeginZoomingBlock block);

/**
 scrollViewDidEndZooming:withView:atScale: delegate block
 @code
 scrollView.okidoki.didEndZooming(^(UIScrollView *scrollView, UIView *view, CGFloat scale) {
     NSLog(@"did end zooming at scale: %f", scale);
 });
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^didEndZooming)(OkidokiScrollViewDidEndZoomingBlock block);

/**
 scrollViewShouldScrollToTop delegate block
 @code
 scrollView.okidoki.shouldScrollToTop(^BOOL(UIScrollView *scrollView) {
     return YES;
 });
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^shouldScrollToTop)(OkidokiScrollViewShouldScrollToTopBlock block);

/**
 scrollViewDidScrollToTop delegate block
 @code
 scrollView.okidoki.didScrollToTop(^(UIScrollView *scrollView) {
     NSLog(@"did scroll to top");
 });
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^didScrollToTop)(OkidokiScrollViewDidScrollToTopBlock block);

/**
 scrollViewDidChangeAdjustedContentInset delegate block (iOS 11+)
 @code
 scrollView.okidoki.didChangeAdjustedContentInset(^(UIScrollView *scrollView) {
     NSLog(@"content inset changed");
 });
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^didChangeAdjustedContentInset)(OkidokiScrollViewDidChangeAdjustedContentInsetBlock block);

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
@property (nonatomic, strong, readonly) Okidoki *(^registerCellClass)(NSArray *params);

/** 
 Register cell nib with identifier
 params: NSArray: @[nibName, @"identifier"] or @[UINib, @"identifier"]
 @code
 .registerCellNib(@[@"MyCell", @"Cell"])
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^registerCellNib)(NSArray *params);

/** 
 Register multiple cell classes with identifiers
 params: NSArray: @[@[cellClass1, @"identifier1"], @[cellClass2, @"identifier2"], ...]
 @code
 .registerMultiCellClass(@[@[[MyCell class], @"Cell1"], @[[OtherCell class], @"Cell2"]])
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^registerMultiCellClass)(NSArray *params);


// UITableViewDataSource
/** 
 numberOfSectionsInTableView: block
 @code
 .numberOfSections(^NSInteger(UITableView *tableView) {
     return 2;
 })
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^numberOfSections)(OkidokiTableViewNumberOfSectionsBlock block);

/** 
 tableView:numberOfRowsInSection: block
 @code
 .numberOfRowsInSection(^NSInteger(UITableView *tableView, NSInteger section) {
     return 10;
 })
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^numberOfRowsInSection)(OkidokiTableViewNumberOfRowsInSectionBlock block);

/** 
 tableView:cellForRowAtIndexPath: block
 @code
 .cellForRowAtIndexPath(^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
     return cell;
 })
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^cellForRowAtIndexPath)(OkidokiTableViewCellForRowAtIndexPathBlock block);

/** 
 tableView:titleForHeaderInSection: block
 @code
 .titleForHeaderInSection(^NSString *(UITableView *tableView, NSInteger section) {
     return @"Header";
 })
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^titleForHeaderInSection)(OkidokiTableViewTitleForHeaderBlock block);

/** 
 tableView:titleForFooterInSection: block
 @code
 .titleForFooterInSection(^NSString *(UITableView *tableView, NSInteger section) {
     return @"Footer";
 })
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^titleForFooterInSection)(OkidokiTableViewTitleForFooterBlock block);

/** 
 tableView:canEditRowAtIndexPath: block
 @code
 .canEditRowAtIndexPath(^BOOL(UITableView *tableView, NSIndexPath *indexPath) {
     return YES;
 })
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^canEditRowAtIndexPath)(OkidokiTableViewCanEditRowBlock block);

/** 
 tableView:commitEditingStyle:forRowAtIndexPath: block
 @code
 .commitEditingStyle(^(UITableView *tableView, UITableViewCellEditingStyle style, NSIndexPath *indexPath) {
     // Handle editing
 })
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^commitEditingStyle)(OkidokiTableViewCommitEditingStyleBlock block);


// UITableViewDelegate
/** 
 tableView:heightForRowAtIndexPath: block
 @code
 .heightForRowAtIndexPath(^CGFloat(UITableView *tableView, NSIndexPath *indexPath) {
     return 44;
 })
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^heightForRowAtIndexPath)(OkidokiTableViewHeightForRowBlock block);

/** 
 tableView:heightForHeaderInSection: block
 @code
 .heightForHeaderInSection(^CGFloat(UITableView *tableView, NSInteger section) {
     return 30;
 })
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^heightForHeaderInSection)(OkidokiTableViewHeightForHeaderBlock block);

/** 
 tableView:heightForFooterInSection: block
 @code
 .heightForFooterInSection(^CGFloat(UITableView *tableView, NSInteger section) {
     return 20;
 })
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^heightForFooterInSection)(OkidokiTableViewHeightForFooterBlock block);

/** 
 tableView:viewForHeaderInSection: block
 @code
 .viewForHeaderInSection(^UIView *(UITableView *tableView, NSInteger section) {
     return headerView;
 })
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^viewForHeaderInSection)(OkidokiTableViewViewForHeaderBlock block);

/** 
 tableView:viewForFooterInSection: block
 @code
 .viewForFooterInSection(^UIView *(UITableView *tableView, NSInteger section) {
     return footerView;
 })
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^viewForFooterInSection)(OkidokiTableViewViewForFooterBlock block);

/** 
 tableView:didSelectRowAtIndexPath: block
 @code
 .didSelectRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath) {
     NSLog(@"Selected");
 })
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^didSelectRowAtIndexPath)(OkidokiTableViewDidSelectRowBlock block);

/** 
 tableView:didDeselectRowAtIndexPath: block
 @code
 .didDeselectRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath) {
     NSLog(@"Deselected");
 })
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^didDeselectRowAtIndexPath)(OkidokiTableViewDidDeselectRowBlock block);

/** 
 tableView:willDisplayCell:forRowAtIndexPath: block
 @code
 .willDisplayCell(^(UITableView *tableView, UITableViewCell *cell, NSIndexPath *indexPath) {
     // Configure cell display
 })
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^willDisplayCell)(OkidokiTableViewWillDisplayCellBlock block);

/** 
 tableView:didEndDisplayingCell:forRowAtIndexPath: block
 @code
 .didEndDisplayingCell(^(UITableView *tableView, UITableViewCell *cell, NSIndexPath *indexPath) {
     // Cleanup after cell
 })
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^didEndDisplayingCell)(OkidokiTableViewDidEndDisplayingCellBlock block);

/** 
 tableView:editingStyleForRowAtIndexPath: block
 @code
 .editingStyleForRowAtIndexPath(^UITableViewCellEditingStyle(UITableView *tableView, NSIndexPath *indexPath) {
     return UITableViewCellEditingStyleDelete;
 })
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^editingStyleForRowAtIndexPath)(OkidokiTableViewEditingStyleBlock block);

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
@property (nonatomic, strong, readonly) Okidoki *(^cvRegisterCellClass)(NSArray *params);

/** 
 Register cell nib with identifier
 params: NSArray: @[nibName, @"identifier"] or @[UINib, @"identifier"]
 @code
 .cvRegisterCellNib(@[@"MyCell", @"Cell"])
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^cvRegisterCellNib)(NSArray *params);

/** 
 Register supplementary view class with identifier
 params: NSArray: @[viewClass, @"kind", @"identifier"]
 @code
 .cvRegisterSupplementaryViewClass(@[[UICollectionReusableView class], UICollectionElementKindSectionHeader, @"Header"])
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^cvRegisterSupplementaryViewClass)(NSArray *params);

/** 
 Register supplementary view nib with identifier
 params: NSArray: @[nibName, @"kind", @"identifier"] or @[UINib, @"kind", @"identifier"]
 @code
 .cvRegisterSupplementaryViewNib(@[@"HeaderView", UICollectionElementKindSectionHeader, @"Header"])
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^cvRegisterSupplementaryViewNib)(NSArray *params);

// UICollectionViewDataSource
/** 
 numberOfSectionsInCollectionView: block
 @code
 .cvNumberOfSections(^NSInteger(UICollectionView *collectionView) {
     return 2;
 })
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^cvNumberOfSections)(OkidokiCollectionViewNumberOfSectionsBlock block);

/** 
 collectionView:numberOfItemsInSection: block
 @code
 .cvNumberOfItemsInSection(^NSInteger(UICollectionView *collectionView, NSInteger section) {
     return 10;
 })
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^cvNumberOfItemsInSection)(OkidokiCollectionViewNumberOfItemsInSectionBlock block);

/** 
 collectionView:cellForItemAtIndexPath: block
 @code
 .cvCellForItemAtIndexPath(^UICollectionViewCell *(UICollectionView *collectionView, NSIndexPath *indexPath) {
     return cell;
 })
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^cvCellForItemAtIndexPath)(OkidokiCollectionViewCellForItemAtIndexPathBlock block);

/** 
 collectionView:viewForSupplementaryElementOfKind:atIndexPath: block
 @code
 .cvViewForSupplementaryElement(^UICollectionReusableView *(UICollectionView *collectionView, NSString *kind, NSIndexPath *indexPath) {
     return headerView;
 })
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^cvViewForSupplementaryElement)(OkidokiCollectionViewViewForSupplementaryElementBlock block);

// UICollectionViewDelegate
/** 
 collectionView:didSelectItemAtIndexPath: block
 @code
 .cvDidSelectItemAtIndexPath(^(UICollectionView *collectionView, NSIndexPath *indexPath) {
     NSLog(@"Selected");
 })
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^cvDidSelectItemAtIndexPath)(OkidokiCollectionViewDidSelectItemBlock block);

/** 
 collectionView:didDeselectItemAtIndexPath: block
 @code
 .cvDidDeselectItemAtIndexPath(^(UICollectionView *collectionView, NSIndexPath *indexPath) {
     NSLog(@"Deselected");
 })
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^cvDidDeselectItemAtIndexPath)(OkidokiCollectionViewDidDeselectItemBlock block);

/** 
 collectionView:willDisplayCell:forItemAtIndexPath: block
 @code
 .cvWillDisplayCell(^(UICollectionView *collectionView, UICollectionViewCell *cell, NSIndexPath *indexPath) {
     // Configure cell display
 })
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^cvWillDisplayCell)(OkidokiCollectionViewWillDisplayCellBlock block);

/** 
 collectionView:didEndDisplayingCell:forItemAtIndexPath: block
 @code
 .cvDidEndDisplayingCell(^(UICollectionView *collectionView, UICollectionViewCell *cell, NSIndexPath *indexPath) {
     // Cleanup after cell
 })
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^cvDidEndDisplayingCell)(OkidokiCollectionViewDidEndDisplayingCellBlock block);

// UICollectionViewDelegateFlowLayout
/** 
 collectionView:layout:sizeForItemAtIndexPath: block
 @code
 .cvSizeForItemAtIndexPath(^CGSize(UICollectionView *collectionView, UICollectionViewLayout *layout, NSIndexPath *indexPath) {
     return CGSizeMake(100, 100);
 })
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^cvSizeForItemAtIndexPath)(OkidokiCollectionViewSizeForItemBlock block);

/** 
 collectionView:layout:insetForSectionAtIndex: block
 @code
 .cvInsetForSectionAtIndex(^UIEdgeInsets(UICollectionView *collectionView, UICollectionViewLayout *layout, NSInteger section) {
     return UIEdgeInsetsMake(10, 10, 10, 10);
 })
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^cvInsetForSectionAtIndex)(OkidokiCollectionViewInsetForSectionBlock block);

/** 
 collectionView:layout:minimumLineSpacingForSectionAtIndex: block
 @code
 .cvMinimumLineSpacing(^CGFloat(UICollectionView *collectionView, UICollectionViewLayout *layout, NSInteger section) {
     return 10;
 })
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^cvMinimumLineSpacing)(OkidokiCollectionViewMinimumLineSpacingBlock block);

/** 
 collectionView:layout:minimumInteritemSpacingForSectionAtIndex: block
 @code
 .cvMinimumInteritemSpacing(^CGFloat(UICollectionView *collectionView, UICollectionViewLayout *layout, NSInteger section) {
     return 10;
 })
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^cvMinimumInteritemSpacing)(OkidokiCollectionViewMinimumInteritemSpacingBlock block);

@end


// Keyboard Handler Block Type
typedef void(^OkidokiKeyboardHandlerBlock)(NSNotificationName name, CGRect beginFrame, CGRect endFrame, CGFloat duration, UIViewAnimationCurve curve);

// Input Limit Types
typedef NS_OPTIONS(NSUInteger, OkidokiInputLimitType) {
    OkidokiInputLimitTypeNone           = 0,
    OkidokiInputLimitTypeDigital        = 1 << 0,  // 数字 0-9
    OkidokiInputLimitTypeAlphabet       = 1 << 1,  // 字母 a-z A-Z
    OkidokiInputLimitTypeAlphabetUpper  = 1 << 2,  // 大写字母 A-Z
    OkidokiInputLimitTypeAlphabetLower  = 1 << 3,  // 小写字母 a-z
    OkidokiInputLimitTypeChinese        = 1 << 4,  // 中文
    OkidokiInputLimitTypeCustom         = 1 << 5,  // 自定义字符集
};

// Input Limit Change Block Type
typedef void(^OkidokiInputLimitDidChangeBlock)(NSString *originalText, NSString *matchedText);

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
@property (nonatomic, strong, readonly) Okidoki *(^tfShouldBeginEditing)(OkidokiTextFieldShouldBeginEditingBlock block);

/** 
 textFieldDidBeginEditing: block
 @code
 .tfDidBeginEditing(^(UITextField *textField) {
     NSLog(@"Begin editing");
 })
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^tfDidBeginEditing)(OkidokiTextFieldDidBeginEditingBlock block);

/** 
 textFieldShouldEndEditing: block
 @code
 .tfShouldEndEditing(^BOOL(UITextField *textField) {
     return YES;
 })
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^tfShouldEndEditing)(OkidokiTextFieldShouldEndEditingBlock block);

/** 
 textFieldDidEndEditing: block
 @code
 .tfDidEndEditing(^(UITextField *textField) {
     NSLog(@"End editing");
 })
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^tfDidEndEditing)(OkidokiTextFieldDidEndEditingBlock block);

/** 
 textField:shouldChangeCharactersInRange:replacementString: block
 @code
 .tfShouldChangeCharacters(^BOOL(UITextField *textField, NSRange range, NSString *replacementString) {
     return YES;
 })
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^tfShouldChangeCharacters)(OkidokiTextFieldShouldChangeCharactersBlock block);

/** 
 textFieldShouldClear: block
 @code
 .tfShouldClear(^BOOL(UITextField *textField) {
     return YES;
 })
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^tfShouldClear)(OkidokiTextFieldShouldClearBlock block);

/** 
 textFieldShouldReturn: block
 @code
 .tfShouldReturn(^BOOL(UITextField *textField) {
     [textField resignFirstResponder];
     return YES;
 })
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^tfShouldReturn)(OkidokiTextFieldShouldReturnBlock block);

/** 
 Keyboard notification handler for UITextField
 @code
 .keyboardHandler(^(NSNotificationName name, CGRect beginFrame, CGRect endFrame, CGFloat duration, UIViewAnimationCurve curve) {
     if ([name isEqualToString:UIKeyboardWillShowNotification]) {
         NSLog(@"Keyboard will show");
     }
 })
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^keyboardHandler)(OkidokiKeyboardHandlerBlock block);

/** 
 Configure input limit for UITextField
 param:  type The type(s) of allowed characters (can be combined with | operator)
 param:  length Maximum length (0 means no limit)
 param:  customCharacters Custom character set (only used when type includes OkidokiInputLimitTypeCustom)
 param:  changeBlock Called when text changes with original and matched text
 @code
 // Only allow digits, max 6 characters
 .tfInputLimit(OkidokiInputLimitTypeDigital, 6, nil, ^(NSString *original, NSString *matched) {
     NSLog(@"Original: %@, Matched: %@", original, matched);
 })
 
 // Allow digits and lowercase letters
 .tfInputLimit(OkidokiInputLimitTypeDigital | OkidokiInputLimitTypeAlphabetLower, 10, nil, nil)
 
 // Allow only custom characters
 .tfInputLimit(OkidokiInputLimitTypeCustom, 0, @"0123456789.-", nil)
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^tfInputLimit)(OkidokiInputLimitType type, NSUInteger length, NSString * _Nullable customCharacters, OkidokiInputLimitDidChangeBlock _Nullable changeBlock);

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
@property (nonatomic, strong, readonly) Okidoki *(^tvShouldBeginEditing)(OkidokiTextViewShouldBeginEditingBlock block);

/** 
 textViewDidBeginEditing: block
 @code
 .tvDidBeginEditing(^(UITextView *textView) {
     NSLog(@"Begin editing");
 })
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^tvDidBeginEditing)(OkidokiTextViewDidBeginEditingBlock block);

/** 
 textViewShouldEndEditing: block
 @code
 .tvShouldEndEditing(^BOOL(UITextView *textView) {
     return YES;
 })
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^tvShouldEndEditing)(OkidokiTextViewShouldEndEditingBlock block);

/** 
 textViewDidEndEditing: block
 @code
 .tvDidEndEditing(^(UITextView *textView) {
     NSLog(@"End editing");
 })
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^tvDidEndEditing)(OkidokiTextViewDidEndEditingBlock block);

/** 
 textViewDidChange: block
 @code
 .tvDidChange(^(UITextView *textView) {
     NSLog(@"Text changed: %@", textView.text);
 })
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^tvDidChange)(OkidokiTextViewDidChangeBlock block);

/** 
 textViewDidChangeSelection: block
 @code
 .tvDidChangeSelection(^(UITextView *textView) {
     NSLog(@"Selection changed");
 })
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^tvDidChangeSelection)(OkidokiTextViewDidChangeSelectionBlock block);

/** 
 textView:shouldChangeTextInRange:replacementText: block
 @code
 .tvShouldChangeText(^BOOL(UITextView *textView, NSRange range, NSString *replacementText) {
     return YES;
 })
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^tvShouldChangeText)(OkidokiTextViewShouldChangeTextBlock block);

/** 
 textView:shouldChangeTextInRanges:replacementText: block (iOS 26+)
 Compatible with new API, automatically fallbacks to old method on older iOS
 @code
 .tvShouldChangeTextInRanges(^BOOL(UITextView *textView, NSArray<NSValue *> *ranges, NSString *replacementText) {
     return YES;
 }) API_AVAILABLE(ios(26.0), tvos(26.0), visionos(26.0), watchos(26.0))
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^tvShouldChangeTextInRanges)(OkidokiTextViewShouldChangeTextInRangesBlock block) API_AVAILABLE(ios(26.0), tvos(26.0), visionos(26.0), watchos(26.0));

/** 
 Keyboard notification handler for UITextView
 @code
 .keyboardHandler(^(NSNotificationName name, CGRect beginFrame, CGRect endFrame, CGFloat duration, UIViewAnimationCurve curve) {
     if ([name isEqualToString:UIKeyboardWillShowNotification]) {
         NSLog(@"Keyboard will show");
     }
 })
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^keyboardHandler)(OkidokiKeyboardHandlerBlock block);

/** 
 Configure input limit for UITextView
 param:  type The type(s) of allowed characters (can be combined with | operator)
 param:  length Maximum length (0 means no limit)
 param:  customCharacters Custom character set (only used when type includes OkidokiInputLimitTypeCustom)
 param:  changeBlock Called when text changes with original and matched text
 @code
 // Only allow digits, max 100 characters
 .tvInputLimit(OkidokiInputLimitTypeDigital, 100, nil, ^(NSString *original, NSString *matched) {
     NSLog(@"Original: %@, Matched: %@", original, matched);
 })
 
 // Allow Chinese and letters
 .tvInputLimit(OkidokiInputLimitTypeChinese | OkidokiInputLimitTypeAlphabet, 200, nil, nil)
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^tvInputLimit)(OkidokiInputLimitType type, NSUInteger length, NSString * _Nullable customCharacters, OkidokiInputLimitDidChangeBlock _Nullable changeBlock);

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
 .leadingAnchor(@[brotherView.trailingAnchor, @20])
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^leadingAnchor)(id params);

/**
 Leading anchor constraint (greater than or equal)
 params:  NSArray: @[toView, @(constant)] or @[toView] (constant default 0)
 @code
 .leadingAnchorGreaterOrEqual(@[superview, @20])
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^leadingAnchorGreaterOrEqual)(id params);

/**
 Leading anchor constraint (less than or equal)
 params:  NSArray: @[toView, @(constant)] or @[toView] (constant default 0)
 @code
 .leadingAnchorLessOrEqual(@[superview, @20])
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^leadingAnchorLessOrEqual)(id params);

/**
 Trailing anchor constraint
 params:  NSArray: @[toView, @(constant)] or @[toView] (constant default 0)
        toView can be UIView (use its trailingAnchor) or NSLayoutXAxisAnchor
 @code
 .trailingAnchor(@[superview, @(-20)])
 .trailingAnchor(@[brotherView.leadingAnchor, @(-20)])
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^trailingAnchor)(id params);

/**
 Trailing anchor constraint (greater than or equal)
 params:  NSArray: @[toView, @(constant)] or @[toView] (constant default 0)
 @code
 .trailingAnchorGreaterOrEqual(@[superview, @(-20)])
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^trailingAnchorGreaterOrEqual)(id params);

/**
 Trailing anchor constraint (less than or equal)
 params:  NSArray: @[toView, @(constant)] or @[toView] (constant default 0)
 @code
 .trailingAnchorLessOrEqual(@[superview, @(-20)])
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^trailingAnchorLessOrEqual)(id params);

/**
 Left anchor constraint
 params:  NSArray: @[toView, @(constant)] or @[toView] (constant default 0)
        toView can be UIView (use its leftAnchor) or NSLayoutXAxisAnchor
 @code
 .leftAnchor(@[superview, @20])
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^leftAnchor)(id params);

/**
 Left anchor constraint (greater than or equal)
 params:  NSArray: @[toView, @(constant)] or @[toView] (constant default 0)
 @code
 .leftAnchorGreaterOrEqual(@[superview, @20])
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^leftAnchorGreaterOrEqual)(id params);

/**
 Left anchor constraint (less than or equal)
 params:  NSArray: @[toView, @(constant)] or @[toView] (constant default 0)
 @code
 .leftAnchorLessOrEqual(@[superview, @20])
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^leftAnchorLessOrEqual)(id params);

/**
 Right anchor constraint
 params:  NSArray: @[toView, @(constant)] or @[toView] (constant default 0)
        toView can be UIView (use its rightAnchor) or NSLayoutXAxisAnchor
 @code
 .rightAnchor(@[superview, @(-20)])
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^rightAnchor)(id params);

/**
 Right anchor constraint (greater than or equal)
 params:  NSArray: @[toView, @(constant)] or @[toView] (constant default 0)
 @code
 .rightAnchorGreaterOrEqual(@[superview, @(-20)])
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^rightAnchorGreaterOrEqual)(id params);

/**
 Right anchor constraint (less than or equal)
 params:  NSArray: @[toView, @(constant)] or @[toView] (constant default 0)
 @code
 .rightAnchorLessOrEqual(@[superview, @(-20)])
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^rightAnchorLessOrEqual)(id params);

/**
 Top anchor constraint
 params:  NSArray: @[toView, @(constant)] or @[toView] (constant default 0)
        toView can be UIView (use its topAnchor) or NSLayoutYAxisAnchor
 @code
 .topAnchor(@[superview])
 .topAnchor(@[superview, @10])
 .topAnchor(@[brotherView.bottomAnchor, @10])
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^topAnchor)(id params);

/**
 Top anchor constraint (greater than or equal)
 params:  NSArray: @[toView, @(constant)] or @[toView] (constant default 0)
 @code
 .topAnchorGreaterOrEqual(@[superview, @10])
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^topAnchorGreaterOrEqual)(id params);

/**
 Top anchor constraint (less than or equal)
 params:  NSArray: @[toView, @(constant)] or @[toView] (constant default 0)
 @code
 .topAnchorLessOrEqual(@[superview, @10])
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^topAnchorLessOrEqual)(id params);

/**
 Bottom anchor constraint
 params:  NSArray: @[toView, @(constant)] or @[toView] (constant default 0)
        toView can be UIView (use its bottomAnchor) or NSLayoutYAxisAnchor
 @code
 .bottomAnchor(@[superview, @(-10)])
 .bottomAnchor(@[brotherView.topAnchor, @(-10)])
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^bottomAnchor)(id params);

/**
 Bottom anchor constraint (greater than or equal)
 params:  NSArray: @[toView, @(constant)] or @[toView] (constant default 0)
 @code
 .bottomAnchorGreaterOrEqual(@[superview, @(-10)])
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^bottomAnchorGreaterOrEqual)(id params);

/**
 Bottom anchor constraint (less than or equal)
 params:  NSArray: @[toView, @(constant)] or @[toView] (constant default 0)
 @code
 .bottomAnchorLessOrEqual(@[superview, @(-10)])
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^bottomAnchorLessOrEqual)(id params);

/**
 Width anchor constraint
 params:  NSNumber: @(width) for constant width
        NSArray: @[toView, @(multiplier), @(constant)] for relative width
 @code
 .widthAnchor(@100)
 .widthAnchor(@[superview, @0.5, @(-20)])
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^widthAnchor)(id params);

/**
 Width anchor constraint (greater than or equal)
 params:  NSNumber: @(width) for constant minimum width
        NSArray: @[toView, @(multiplier), @(constant)] for relative minimum width
 @code
 .widthAnchorGreaterOrEqual(@100)
 .widthAnchorGreaterOrEqual(@[superview, @0.5, @0])
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^widthAnchorGreaterOrEqual)(id params);

/**
 Width anchor constraint (less than or equal)
 params:  NSNumber: @(width) for constant maximum width
        NSArray: @[toView, @(multiplier), @(constant)] for relative maximum width
 @code
 .widthAnchorLessOrEqual(@200)
 .widthAnchorLessOrEqual(@[superview, @1.0, @(-20)])
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^widthAnchorLessOrEqual)(id params);

/**
 Height anchor constraint
 params:  NSNumber: @(height) for constant height
        NSArray: @[toView, @(multiplier), @(constant)] for relative height
 @code
 .heightAnchor(@50)
 .heightAnchor(@[superview, @0.5, @0])
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^heightAnchor)(id params);

/**
 Height anchor constraint (greater than or equal)
 params:  NSNumber: @(height) for constant minimum height
        NSArray: @[toView, @(multiplier), @(constant)] for relative minimum height
 @code
 .heightAnchorGreaterOrEqual(@50)
 .heightAnchorGreaterOrEqual(@[superview, @0.5, @0])
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^heightAnchorGreaterOrEqual)(id params);

/**
 Height anchor constraint (less than or equal)
 params:  NSNumber: @(height) for constant maximum height
        NSArray: @[toView, @(multiplier), @(constant)] for relative maximum height
 @code
 .heightAnchorLessOrEqual(@300)
 .heightAnchorLessOrEqual(@[superview, @1.0, @0])
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^heightAnchorLessOrEqual)(id params);

/**
 CenterX anchor constraint
 params:  NSArray: @[toView, @(constant)] or @[toView] (constant default 0)
        toView can be UIView (use its centerXAnchor) or NSLayoutXAxisAnchor
 @code
 .centerXAnchor(@[superview, @10])
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^centerXAnchor)(id params);

/**
 CenterX anchor constraint (greater than or equal)
 params:  NSArray: @[toView, @(constant)] or @[toView] (constant default 0)
 @code
 .centerXAnchorGreaterOrEqual(@[superview, @10])
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^centerXAnchorGreaterOrEqual)(id params);

/**
 CenterX anchor constraint (less than or equal)
 params:  NSArray: @[toView, @(constant)] or @[toView] (constant default 0)
 @code
 .centerXAnchorLessOrEqual(@[superview, @10])
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^centerXAnchorLessOrEqual)(id params);

/**
 CenterY anchor constraint
 params:  NSArray: @[toView, @(constant)] or @[toView] (constant default 0)
        toView can be UIView (use its centerYAnchor) or NSLayoutYAxisAnchor
 @code
 .centerYAnchor(@[superview, @0])
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^centerYAnchor)(id params);

/**
 CenterY anchor constraint (greater than or equal)
 params:  NSArray: @[toView, @(constant)] or @[toView] (constant default 0)
 @code
 .centerYAnchorGreaterOrEqual(@[superview, @0])
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^centerYAnchorGreaterOrEqual)(id params);

/**
 CenterY anchor constraint (less than or equal)
 params:  NSArray: @[toView, @(constant)] or @[toView] (constant default 0)
 @code
 .centerYAnchorLessOrEqual(@[superview, @0])
 @endcode
 */
@property (nonatomic, strong, readonly) Okidoki *(^centerYAnchorLessOrEqual)(id params);

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
@property (nonatomic, strong, readonly) Okidoki *(^edgeToSuperView)(id _Nullable params);

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

/** Return a new color with the specified alpha. eg. [UIColor redColor].okidokiAlpha(0.5) */
@property (nonatomic,  strong,  readonly) UIColor *(^okidokiAlpha)(CGFloat alphaValue);
@end


@interface NSString (Okidoki)
/** Convert hex color string to UIColor. eg. @"FF0000".okidokiHexColor */
@property (nonatomic,  strong,  readonly) UIColor *okidokiHexColor;
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
