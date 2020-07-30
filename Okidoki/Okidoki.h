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

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#define kNumberAdaptor(x) Okidoki_NumberAdaptor(x)

CGFloat Okidoki_NumberAdaptor(CGFloat number);

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
/** @(YES) or @(NO),NSString */
- (Okidoki*(^)(id))mtBounds;

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

- (Okidoki*(^)(id))verInd;
- (Okidoki*(^)(id))horInd;
- (Okidoki*(^)(id))paging;
- (Okidoki*(^)(id))bounces;

#pragma mark - UITextView

- (Okidoki*(^)(id))editable;
- (Okidoki*(^)(id))selectable;

@end

@interface UIView (Okidoki)
@property (nonatomic,  strong) Okidoki *okidoki;
@end

@interface UIColor (Okidoki)
/** color: UIColor,NSString(eg.FFFEEE,#FFFEEE,0xFFFEEE,0XFFFEEE) */
+ (UIColor *)okidokiColor:(id)color;
@end

@interface UIFont (Okidoki)
/** color: UIFont,NSString(eg.@"17",@"s17",@"b17",@"i17") */
+ (UIFont *)okidokiFont:(id)font;
@end
