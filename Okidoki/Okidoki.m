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

// 内部 Target 类，用于持有手势的 block
@interface _OkidokiGestureTarget : NSObject
@property (nonatomic, copy) void (^block)(id gesture);
- (instancetype)initWithBlock:(void (^)(id gesture))block;
- (void)invoke:(id)gesture;
@end

@implementation _OkidokiGestureTarget
- (instancetype)initWithBlock:(void (^)(id gesture))block {
    self = [super init];
    if (self) {
        _block = [block copy];
    }
    return self;
}
- (void)invoke:(id)gesture {
    if (_block) _block(gesture);
}
@end

// 内部 Delegate Handler 类，用于处理 UIScrollView 代理回调
@interface _OkidokiScrollViewDelegateHandler : NSObject <UIScrollViewDelegate>
@property (nonatomic, copy) void (^didScrollBlock)(UIScrollView *scrollView);
@property (nonatomic, copy) void (^didZoomBlock)(UIScrollView *scrollView);
@property (nonatomic, copy) void (^willBeginDraggingBlock)(UIScrollView *scrollView);
@property (nonatomic, copy) void (^willEndDraggingBlock)(UIScrollView *scrollView, CGPoint velocity);
@property (nonatomic, copy) void (^didEndDraggingBlock)(UIScrollView *scrollView, BOOL decelerate);
@property (nonatomic, copy) void (^willBeginDeceleratingBlock)(UIScrollView *scrollView);
@property (nonatomic, copy) void (^didEndDeceleratingBlock)(UIScrollView *scrollView);
@property (nonatomic, copy) void (^didEndScrollingAnimationBlock)(UIScrollView *scrollView);
@property (nonatomic, copy) UIView * (^viewForZoomingBlock)(UIScrollView *scrollView);
@property (nonatomic, copy) void (^willBeginZoomingBlock)(UIScrollView *scrollView, UIView *view);
@property (nonatomic, copy) void (^didEndZoomingBlock)(UIScrollView *scrollView, UIView *view, CGFloat scale);
@property (nonatomic, copy) BOOL (^shouldScrollToTopBlock)(UIScrollView *scrollView);
@property (nonatomic, copy) void (^didScrollToTopBlock)(UIScrollView *scrollView);
@property (nonatomic, copy) void (^didChangeAdjustedContentInsetBlock)(UIScrollView *scrollView);
@end

@implementation _OkidokiScrollViewDelegateHandler

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.didScrollBlock) {
        self.didScrollBlock(scrollView);
    }
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    if (self.didZoomBlock) {
        self.didZoomBlock(scrollView);
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (self.willBeginDraggingBlock) {
        self.willBeginDraggingBlock(scrollView);
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity {
    if (self.willEndDraggingBlock) {
        self.willEndDraggingBlock(scrollView, velocity);
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (self.didEndDraggingBlock) {
        self.didEndDraggingBlock(scrollView, decelerate);
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    if (self.willBeginDeceleratingBlock) {
        self.willBeginDeceleratingBlock(scrollView);
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (self.didEndDeceleratingBlock) {
        self.didEndDeceleratingBlock(scrollView);
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (self.didEndScrollingAnimationBlock) {
        self.didEndScrollingAnimationBlock(scrollView);
    }
}

- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    if (self.viewForZoomingBlock) {
        return self.viewForZoomingBlock(scrollView);
    }
    return nil;
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view {
    if (self.willBeginZoomingBlock) {
        self.willBeginZoomingBlock(scrollView, view);
    }
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale {
    if (self.didEndZoomingBlock) {
        self.didEndZoomingBlock(scrollView, view, scale);
    }
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView {
    if (self.shouldScrollToTopBlock) {
        return self.shouldScrollToTopBlock(scrollView);
    }
    return YES;
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    if (self.didScrollToTopBlock) {
        self.didScrollToTopBlock(scrollView);
    }
}

- (void)scrollViewDidChangeAdjustedContentInset:(UIScrollView *)scrollView {
    if (self.didChangeAdjustedContentInsetBlock) {
        self.didChangeAdjustedContentInsetBlock(scrollView);
    }
}

@end

// 内部 Delegate Handler 类，用于处理 UITableView 代理回调
@interface _OkidokiTableViewDelegateHandler : NSObject <UITableViewDataSource, UITableViewDelegate>
// DataSource blocks
@property (nonatomic, copy) OkidokiTableViewNumberOfSectionsBlock numberOfSectionsBlock;
@property (nonatomic, copy) OkidokiTableViewNumberOfRowsInSectionBlock numberOfRowsInSectionBlock;
@property (nonatomic, copy) OkidokiTableViewCellForRowAtIndexPathBlock cellForRowAtIndexPathBlock;
@property (nonatomic, copy) OkidokiTableViewTitleForHeaderBlock titleForHeaderInSectionBlock;
@property (nonatomic, copy) OkidokiTableViewTitleForFooterBlock titleForFooterInSectionBlock;
@property (nonatomic, copy) OkidokiTableViewCanEditRowBlock canEditRowAtIndexPathBlock;
@property (nonatomic, copy) OkidokiTableViewCommitEditingStyleBlock commitEditingStyleBlock;

// Delegate blocks
@property (nonatomic, copy) OkidokiTableViewHeightForRowBlock heightForRowAtIndexPathBlock;
@property (nonatomic, copy) OkidokiTableViewHeightForHeaderBlock heightForHeaderInSectionBlock;
@property (nonatomic, copy) OkidokiTableViewHeightForFooterBlock heightForFooterInSectionBlock;
@property (nonatomic, copy) OkidokiTableViewViewForHeaderBlock viewForHeaderInSectionBlock;
@property (nonatomic, copy) OkidokiTableViewViewForFooterBlock viewForFooterInSectionBlock;
@property (nonatomic, copy) OkidokiTableViewDidSelectRowBlock didSelectRowAtIndexPathBlock;
@property (nonatomic, copy) OkidokiTableViewDidDeselectRowBlock didDeselectRowAtIndexPathBlock;
@property (nonatomic, copy) OkidokiTableViewWillDisplayCellBlock willDisplayCellBlock;
@property (nonatomic, copy) OkidokiTableViewDidEndDisplayingCellBlock didEndDisplayingCellBlock;
@property (nonatomic, copy) OkidokiTableViewEditingStyleBlock editingStyleForRowAtIndexPathBlock;
@end

@implementation _OkidokiTableViewDelegateHandler

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.numberOfSectionsBlock) {
        return self.numberOfSectionsBlock(tableView);
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.numberOfRowsInSectionBlock) {
        return self.numberOfRowsInSectionBlock(tableView, section);
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    
    if (self.cellForRowAtIndexPathBlock) {
        cell = self.cellForRowAtIndexPathBlock(tableView, indexPath);
    }
    
    // 如果 block 没有设置或返回了 nil，使用默认 cell
    if (!cell) {
        static NSString *identifier = @"OkidokiDefaultCell";
        cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (self.titleForHeaderInSectionBlock) {
        return self.titleForHeaderInSectionBlock(tableView, section);
    }
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if (self.titleForFooterInSectionBlock) {
        return self.titleForFooterInSectionBlock(tableView, section);
    }
    return nil;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.canEditRowAtIndexPathBlock) {
        return self.canEditRowAtIndexPathBlock(tableView, indexPath);
    }
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.commitEditingStyleBlock) {
        self.commitEditingStyleBlock(tableView, editingStyle, indexPath);
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.heightForRowAtIndexPathBlock) {
        return self.heightForRowAtIndexPathBlock(tableView, indexPath);
    }
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.heightForHeaderInSectionBlock) {
        return self.heightForHeaderInSectionBlock(tableView, section);
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (self.heightForFooterInSectionBlock) {
        return self.heightForFooterInSectionBlock(tableView, section);
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.viewForHeaderInSectionBlock) {
        return self.viewForHeaderInSectionBlock(tableView, section);
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (self.viewForFooterInSectionBlock) {
        return self.viewForFooterInSectionBlock(tableView, section);
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.didSelectRowAtIndexPathBlock) {
        self.didSelectRowAtIndexPathBlock(tableView, indexPath);
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.didDeselectRowAtIndexPathBlock) {
        self.didDeselectRowAtIndexPathBlock(tableView, indexPath);
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.willDisplayCellBlock) {
        self.willDisplayCellBlock(tableView, cell, indexPath);
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.didEndDisplayingCellBlock) {
        self.didEndDisplayingCellBlock(tableView, cell, indexPath);
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.editingStyleForRowAtIndexPathBlock) {
        return self.editingStyleForRowAtIndexPathBlock(tableView, indexPath);
    }
    return UITableViewCellEditingStyleNone;
}

@end

// 内部 Delegate Handler 类，用于处理 UICollectionView 代理回调
@interface _OkidokiCollectionViewDelegateHandler : NSObject <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
// DataSource blocks
@property (nonatomic, copy) OkidokiCollectionViewNumberOfSectionsBlock numberOfSectionsBlock;
@property (nonatomic, copy) OkidokiCollectionViewNumberOfItemsInSectionBlock numberOfItemsInSectionBlock;
@property (nonatomic, copy) OkidokiCollectionViewCellForItemAtIndexPathBlock cellForItemAtIndexPathBlock;
@property (nonatomic, copy) OkidokiCollectionViewViewForSupplementaryElementBlock viewForSupplementaryElementBlock;

// Delegate blocks
@property (nonatomic, copy) OkidokiCollectionViewDidSelectItemBlock didSelectItemAtIndexPathBlock;
@property (nonatomic, copy) OkidokiCollectionViewDidDeselectItemBlock didDeselectItemAtIndexPathBlock;
@property (nonatomic, copy) OkidokiCollectionViewWillDisplayCellBlock willDisplayCellBlock;
@property (nonatomic, copy) OkidokiCollectionViewDidEndDisplayingCellBlock didEndDisplayingCellBlock;

// FlowLayout blocks
@property (nonatomic, copy) OkidokiCollectionViewSizeForItemBlock sizeForItemAtIndexPathBlock;
@property (nonatomic, copy) OkidokiCollectionViewInsetForSectionBlock insetForSectionAtIndexBlock;
@property (nonatomic, copy) OkidokiCollectionViewMinimumLineSpacingBlock minimumLineSpacingBlock;
@property (nonatomic, copy) OkidokiCollectionViewMinimumInteritemSpacingBlock minimumInteritemSpacingBlock;
@end

@implementation _OkidokiCollectionViewDelegateHandler

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (self.numberOfSectionsBlock) {
        return self.numberOfSectionsBlock(collectionView);
    }
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.numberOfItemsInSectionBlock) {
        return self.numberOfItemsInSectionBlock(collectionView, section);
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = nil;
    
    if (self.cellForItemAtIndexPathBlock) {
        cell = self.cellForItemAtIndexPathBlock(collectionView, indexPath);
    }
    
    // 如果 block 没有设置或返回了 nil，使用默认 cell
    if (!cell) {
        static NSString *identifier = @"OkidokiDefaultCollectionCell";
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    }
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (self.viewForSupplementaryElementBlock) {
        return self.viewForSupplementaryElementBlock(collectionView, kind, indexPath);
    }
    
    // 返回默认的 supplementary view
    static NSString *identifier = @"OkidokiDefaultSupplementaryView";
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:kind withReuseIdentifier:identifier];
    return [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:identifier forIndexPath:indexPath];
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.didSelectItemAtIndexPathBlock) {
        self.didSelectItemAtIndexPathBlock(collectionView, indexPath);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.didDeselectItemAtIndexPathBlock) {
        self.didDeselectItemAtIndexPathBlock(collectionView, indexPath);
    }
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.willDisplayCellBlock) {
        self.willDisplayCellBlock(collectionView, cell, indexPath);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.didEndDisplayingCellBlock) {
        self.didEndDisplayingCellBlock(collectionView, cell, indexPath);
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.sizeForItemAtIndexPathBlock) {
        return self.sizeForItemAtIndexPathBlock(collectionView, collectionViewLayout, indexPath);
    }
    
    // 返回默认大小
    if ([collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]) {
        return ((UICollectionViewFlowLayout *)collectionViewLayout).itemSize;
    }
    return CGSizeMake(50, 50);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (self.insetForSectionAtIndexBlock) {
        return self.insetForSectionAtIndexBlock(collectionView, collectionViewLayout, section);
    }
    
    // 返回默认 inset
    if ([collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]) {
        return ((UICollectionViewFlowLayout *)collectionViewLayout).sectionInset;
    }
    return UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (self.minimumLineSpacingBlock) {
        return self.minimumLineSpacingBlock(collectionView, collectionViewLayout, section);
    }
    
    // 返回默认行间距
    if ([collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]) {
        return ((UICollectionViewFlowLayout *)collectionViewLayout).minimumLineSpacing;
    }
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    if (self.minimumInteritemSpacingBlock) {
        return self.minimumInteritemSpacingBlock(collectionView, collectionViewLayout, section);
    }
    
    // 返回默认item间距
    if ([collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]) {
        return ((UICollectionViewFlowLayout *)collectionViewLayout).minimumInteritemSpacing;
    }
    return 10;
}

@end

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

- (Okidoki*(^)(id, void(^)(Okidoki *ok)))addSubviewWithConfig {
    return ^id(id subview, void(^config)(Okidoki *ok)) {
        UIView *view = self.view;
        
        if ([subview isKindOfClass:[UIView class]]) {
            UIView *subView = (UIView *)subview;
            [view addSubview:subView];
            
            if (config) {
                config(subView.okidoki);
            }
        }
        
        return view.okidoki;
    };
}

- (Okidoki*(^)(id, void(^)(Okidoki *ok, UIView *superView)))addSubviewWithConfig_superView {
    return ^id(id subview, void(^config)(Okidoki *ok, UIView *superView)) {
        UIView *view = self.view;
        
        if ([subview isKindOfClass:[UIView class]]) {
            UIView *subView = (UIView *)subview;
            [view addSubview:subView];
            
            if (config) {
                config(subView.okidoki, view);
            }
        }
        
        return view.okidoki;
    };
}

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

#pragma mark - Gesture

- (Okidoki*(^)(void(^)(UITapGestureRecognizer *tap)))tapGesture {
    return ^id(void(^block)(UITapGestureRecognizer *tap)) {
        UIView *view = self.view;
        view.userInteractionEnabled = YES;
        
        _OkidokiGestureTarget *target = [[_OkidokiGestureTarget alloc] initWithBlock:block];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:@selector(invoke:)];
        [view addGestureRecognizer:tap];
        
        // 使用 associated object 持有 target，保证其生命周期
        objc_setAssociatedObject(tap, _cmd, target, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        return view.okidoki;
    };
}

- (Okidoki*(^)(void(^)(UILongPressGestureRecognizer *longPress)))longPressGesture {
    return ^id(void(^block)(UILongPressGestureRecognizer *longPress)) {
        UIView *view = self.view;
        view.userInteractionEnabled = YES;
        
        _OkidokiGestureTarget *target = [[_OkidokiGestureTarget alloc] initWithBlock:block];
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:target action:@selector(invoke:)];
        [view addGestureRecognizer:longPress];
        
        objc_setAssociatedObject(longPress, _cmd, target, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        return view.okidoki;
    };
}

- (Okidoki*(^)(NSUInteger, void(^)(UISwipeGestureRecognizer *swipe)))swipeGesture {
    return ^id(NSUInteger direction, void(^block)(UISwipeGestureRecognizer *swipe)) {
        UIView *view = self.view;
        view.userInteractionEnabled = YES;
        
        _OkidokiGestureTarget *target = [[_OkidokiGestureTarget alloc] initWithBlock:block];
        UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:target action:@selector(invoke:)];
        swipe.direction = direction;
        [view addGestureRecognizer:swipe];
        
        objc_setAssociatedObject(swipe, _cmd, target, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        // 让 Pan 手势在 Swipe 手势失败后才触发
        for (UIGestureRecognizer *gesture in view.gestureRecognizers) {
            if ([gesture isKindOfClass:[UIPanGestureRecognizer class]]) {
                [gesture requireGestureRecognizerToFail:swipe];
            }
        }
        
        return view.okidoki;
    };
}

- (Okidoki*(^)(void(^)(UIPanGestureRecognizer *pan)))panGesture {
    return ^id(void(^block)(UIPanGestureRecognizer *pan)) {
        UIView *view = self.view;
        view.userInteractionEnabled = YES;
        
        _OkidokiGestureTarget *target = [[_OkidokiGestureTarget alloc] initWithBlock:block];
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(invoke:)];
        [view addGestureRecognizer:pan];
        
        objc_setAssociatedObject(pan, _cmd, target, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        // 让 Pan 手势在已有的 Swipe 手势失败后才触发
        for (UIGestureRecognizer *gesture in view.gestureRecognizers) {
            if ([gesture isKindOfClass:[UISwipeGestureRecognizer class]]) {
                [pan requireGestureRecognizerToFail:gesture];
            }
        }
        
        return view.okidoki;
    };
}

- (Okidoki*(^)(void(^)(UIPinchGestureRecognizer *pinch)))pinchGesture {
    return ^id(void(^block)(UIPinchGestureRecognizer *pinch)) {
        UIView *view = self.view;
        view.userInteractionEnabled = YES;
        
        _OkidokiGestureTarget *target = [[_OkidokiGestureTarget alloc] initWithBlock:block];
        UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:target action:@selector(invoke:)];
        [view addGestureRecognizer:pinch];
        
        objc_setAssociatedObject(pinch, _cmd, target, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        return view.okidoki;
    };
}

- (Okidoki*(^)(void(^)(UIRotationGestureRecognizer *rotation)))rotationGesture {
    return ^id(void(^block)(UIRotationGestureRecognizer *rotation)) {
        UIView *view = self.view;
        view.userInteractionEnabled = YES;
        
        _OkidokiGestureTarget *target = [[_OkidokiGestureTarget alloc] initWithBlock:block];
        UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:target action:@selector(invoke:)];
        [view addGestureRecognizer:rotation];
        
        objc_setAssociatedObject(rotation, _cmd, target, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        return view.okidoki;
    };
}

- (Okidoki*(^)(Class))removeGesture {
    return ^id(Class gestureClass) {
        UIView *view = self.view;
        
        NSArray *gestures = [view.gestureRecognizers copy];
        for (UIGestureRecognizer *gesture in gestures) {
            if ([gesture isKindOfClass:gestureClass]) {
                [view removeGestureRecognizer:gesture];
            }
        }
        
        return view.okidoki;
    };
}

- (Okidoki*(^)(void))removeAllGestures {
    return ^id() {
        UIView *view = self.view;
        
        NSArray *gestures = [view.gestureRecognizers copy];
        for (UIGestureRecognizer *gesture in gestures) {
            [view removeGestureRecognizer:gesture];
        }
        
        return view.okidoki;
    };
}

#pragma mark - UILabel

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

kOkidoki_imp(highlightedTextColor, ({
    if ([view isKindOfClass:[UILabel class]]) {
        UIColor *color = [UIColor okidokiColor:highlightedTextColor];
        if (color) {
            [(UILabel *)view setHighlightedTextColor:color];
        }
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

- (Okidoki*(^)(UIControlEvents, void(^)(__kindof UIControl *sender)))addControlEvent {
    return ^id(UIControlEvents events, void(^block)(__kindof UIControl *sender)) {
        UIView *view = self.view;
        
        if ([view isKindOfClass:[UIControl class]]) {
            UIControl *control = (UIControl *)view;
            
            _OkidokiGestureTarget *target = [[_OkidokiGestureTarget alloc] initWithBlock:block];
            [control addTarget:target action:@selector(invoke:) forControlEvents:events];
            
            // 使用 associated object 持有 target，保证其生命周期
            // 使用 events 作为 key 的一部分来区分不同事件
            NSString *key = [NSString stringWithFormat:@"okidoki_control_event_%lu", (unsigned long)events];
            
            // 获取已有的 targets 数组，或创建新数组
            NSMutableArray *targets = objc_getAssociatedObject(control, (__bridge const void *)(key));
            if (!targets) {
                targets = [NSMutableArray array];
                objc_setAssociatedObject(control, (__bridge const void *)(key), targets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
            [targets addObject:target];
        }
        
        return view.okidoki;
    };
}

- (Okidoki*(^)(UIControlEvents))removeControlEvent {
    return ^id(UIControlEvents events) {
        UIView *view = self.view;
        
        if ([view isKindOfClass:[UIControl class]]) {
            UIControl *control = (UIControl *)view;
            
            NSString *key = [NSString stringWithFormat:@"okidoki_control_event_%lu", (unsigned long)events];
            NSMutableArray *targets = objc_getAssociatedObject(control, (__bridge const void *)(key));
            
            // 移除所有相关的 target
            for (_OkidokiGestureTarget *target in targets) {
                [control removeTarget:target action:@selector(invoke:) forControlEvents:events];
            }
            
            // 清空 targets 数组
            [targets removeAllObjects];
        }
        
        return view.okidoki;
    };
}

- (Okidoki*(^)(void))removeAllControlEvents {
    return ^id() {
        UIView *view = self.view;
        
        if ([view isKindOfClass:[UIControl class]]) {
            UIControl *control = (UIControl *)view;
            [control removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
            
            // 清空所有关联的 targets
            objc_removeAssociatedObjects(control);
        }
        
        return view.okidoki;
    };
}

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

kOkidoki_imp(contentOffset, ({
    if ([view isKindOfClass:[UIScrollView class]]) {
        if ([contentOffset isKindOfClass:[NSValue class]]) {
            [(UIScrollView *)view setContentOffset:[contentOffset CGPointValue]];
        } else if ([contentOffset isKindOfClass:[NSString class]]) {
            [(UIScrollView *)view setContentOffset:CGPointFromString(contentOffset)];
        }
    }
}))

kOkidoki_imp(contentSize, ({
    if ([view isKindOfClass:[UIScrollView class]]) {
        if ([contentSize isKindOfClass:[NSValue class]]) {
            [(UIScrollView *)view setContentSize:[contentSize CGSizeValue]];
        } else if ([contentSize isKindOfClass:[NSString class]]) {
            [(UIScrollView *)view setContentSize:CGSizeFromString(contentSize)];
        }
    }
}))

kOkidoki_imp(contentInset, ({
    if ([view isKindOfClass:[UIScrollView class]]) {
        if ([contentInset isKindOfClass:[NSValue class]]) {
            [(UIScrollView *)view setContentInset:[contentInset UIEdgeInsetsValue]];
        } else if ([contentInset isKindOfClass:[NSString class]]) {
            [(UIScrollView *)view setContentInset:UIEdgeInsetsFromString(contentInset)];
        }
    }
}))

kOkidoki_imp(directionalLockEnabled, ({
    if ([view isKindOfClass:[UIScrollView class]]) {
        [(UIScrollView *)view setDirectionalLockEnabled:[directionalLockEnabled boolValue]];
    }
}))

kOkidoki_imp(alwaysBounceVertical, ({
    if ([view isKindOfClass:[UIScrollView class]]) {
        [(UIScrollView *)view setAlwaysBounceVertical:[alwaysBounceVertical boolValue]];
    }
}))

kOkidoki_imp(alwaysBounceHorizontal, ({
    if ([view isKindOfClass:[UIScrollView class]]) {
        [(UIScrollView *)view setAlwaysBounceHorizontal:[alwaysBounceHorizontal boolValue]];
    }
}))

kOkidoki_imp(scrollEnabled, ({
    if ([view isKindOfClass:[UIScrollView class]]) {
        [(UIScrollView *)view setScrollEnabled:[scrollEnabled boolValue]];
    }
}))

kOkidoki_imp(indicatorStyle, ({
    if ([view isKindOfClass:[UIScrollView class]] &&
        ([indicatorStyle isKindOfClass:[NSNumber class]] ||
         [indicatorStyle isKindOfClass:[NSString class]])) {
        [(UIScrollView *)view setIndicatorStyle:[indicatorStyle integerValue]];
    }
}))

kOkidoki_imp(delaysContentTouches, ({
    if ([view isKindOfClass:[UIScrollView class]]) {
        [(UIScrollView *)view setDelaysContentTouches:[delaysContentTouches boolValue]];
    }
}))

kOkidoki_imp(canCancelContentTouches, ({
    if ([view isKindOfClass:[UIScrollView class]]) {
        [(UIScrollView *)view setCanCancelContentTouches:[canCancelContentTouches boolValue]];
    }
}))

kOkidoki_imp(minimumZoomScale, ({
    if ([view isKindOfClass:[UIScrollView class]] &&
        ([minimumZoomScale isKindOfClass:[NSNumber class]] ||
         [minimumZoomScale isKindOfClass:[NSString class]])) {
        [(UIScrollView *)view setMinimumZoomScale:[minimumZoomScale floatValue]];
    }
}))

kOkidoki_imp(maximumZoomScale, ({
    if ([view isKindOfClass:[UIScrollView class]] &&
        ([maximumZoomScale isKindOfClass:[NSNumber class]] ||
         [maximumZoomScale isKindOfClass:[NSString class]])) {
        [(UIScrollView *)view setMaximumZoomScale:[maximumZoomScale floatValue]];
    }
}))

kOkidoki_imp(bouncesZoom, ({
    if ([view isKindOfClass:[UIScrollView class]]) {
        [(UIScrollView *)view setBouncesZoom:[bouncesZoom boolValue]];
    }
}))

kOkidoki_imp(scrollsToTop, ({
    if ([view isKindOfClass:[UIScrollView class]]) {
        [(UIScrollView *)view setScrollsToTop:[scrollsToTop boolValue]];
    }
}))

kOkidoki_imp(decelerationRate, ({
    if ([view isKindOfClass:[UIScrollView class]] &&
        ([decelerationRate isKindOfClass:[NSNumber class]] ||
         [decelerationRate isKindOfClass:[NSString class]])) {
        [(UIScrollView *)view setDecelerationRate:[decelerationRate floatValue]];
    }
}))

kOkidoki_imp(zoomScale, ({
    if ([view isKindOfClass:[UIScrollView class]] &&
        ([zoomScale isKindOfClass:[NSNumber class]] ||
         [zoomScale isKindOfClass:[NSString class]])) {
        [(UIScrollView *)view setZoomScale:[zoomScale floatValue]];
    }
}))

kOkidoki_imp(keyboardDismissMode, ({
    if ([view isKindOfClass:[UIScrollView class]] &&
        ([keyboardDismissMode isKindOfClass:[NSNumber class]] ||
         [keyboardDismissMode isKindOfClass:[NSString class]])) {
        [(UIScrollView *)view setKeyboardDismissMode:[keyboardDismissMode integerValue]];
    }
}))

kOkidoki_imp(contentInsetAdjustmentBehavior, ({
    if ([view isKindOfClass:[UIScrollView class]] &&
        ([contentInsetAdjustmentBehavior isKindOfClass:[NSNumber class]] ||
         [contentInsetAdjustmentBehavior isKindOfClass:[NSString class]])) {
        if (@available(iOS 11.0, *)) {
            [(UIScrollView *)view setContentInsetAdjustmentBehavior:[contentInsetAdjustmentBehavior integerValue]];
        }
    }
}))

kOkidoki_imp(verticalScrollIndicatorInsets, ({
    if ([view isKindOfClass:[UIScrollView class]]) {
        if (@available(iOS 11.1, *)) {
            if ([verticalScrollIndicatorInsets isKindOfClass:[NSValue class]]) {
                [(UIScrollView *)view setVerticalScrollIndicatorInsets:[verticalScrollIndicatorInsets UIEdgeInsetsValue]];
            } else if ([verticalScrollIndicatorInsets isKindOfClass:[NSString class]]) {
                [(UIScrollView *)view setVerticalScrollIndicatorInsets:UIEdgeInsetsFromString(verticalScrollIndicatorInsets)];
            }
        }
    }
}))

kOkidoki_imp(horizontalScrollIndicatorInsets, ({
    if ([view isKindOfClass:[UIScrollView class]]) {
        if (@available(iOS 11.1, *)) {
            if ([horizontalScrollIndicatorInsets isKindOfClass:[NSValue class]]) {
                [(UIScrollView *)view setHorizontalScrollIndicatorInsets:[horizontalScrollIndicatorInsets UIEdgeInsetsValue]];
            } else if ([horizontalScrollIndicatorInsets isKindOfClass:[NSString class]]) {
                [(UIScrollView *)view setHorizontalScrollIndicatorInsets:UIEdgeInsetsFromString(horizontalScrollIndicatorInsets)];
            }
        }
    }
}))

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

// UIScrollView Delegate Block Methods

- (Okidoki*(^)(OkidokiScrollViewDidScrollBlock block))didScroll {
    return ^id(OkidokiScrollViewDidScrollBlock block) {
        UIView *view = self.view;
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scrollView = (UIScrollView *)view;
            _OkidokiScrollViewDelegateHandler *handler = [self _scrollViewDelegateHandlerForScrollView:scrollView];
            handler.didScrollBlock = block;
        }
        return view.okidoki;
    };
}

- (Okidoki*(^)(OkidokiScrollViewDidZoomBlock block))didZoom {
    return ^id(OkidokiScrollViewDidZoomBlock block) {
        UIView *view = self.view;
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scrollView = (UIScrollView *)view;
            _OkidokiScrollViewDelegateHandler *handler = [self _scrollViewDelegateHandlerForScrollView:scrollView];
            handler.didZoomBlock = block;
        }
        return view.okidoki;
    };
}

- (Okidoki*(^)(OkidokiScrollViewWillBeginDraggingBlock block))willBeginDragging {
    return ^id(OkidokiScrollViewWillBeginDraggingBlock block) {
        UIView *view = self.view;
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scrollView = (UIScrollView *)view;
            _OkidokiScrollViewDelegateHandler *handler = [self _scrollViewDelegateHandlerForScrollView:scrollView];
            handler.willBeginDraggingBlock = block;
        }
        return view.okidoki;
    };
}

- (Okidoki*(^)(OkidokiScrollViewWillEndDraggingBlock block))willEndDragging {
    return ^id(OkidokiScrollViewWillEndDraggingBlock block) {
        UIView *view = self.view;
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scrollView = (UIScrollView *)view;
            _OkidokiScrollViewDelegateHandler *handler = [self _scrollViewDelegateHandlerForScrollView:scrollView];
            handler.willEndDraggingBlock = block;
        }
        return view.okidoki;
    };
}

- (Okidoki*(^)(OkidokiScrollViewDidEndDraggingBlock block))didEndDragging {
    return ^id(OkidokiScrollViewDidEndDraggingBlock block) {
        UIView *view = self.view;
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scrollView = (UIScrollView *)view;
            _OkidokiScrollViewDelegateHandler *handler = [self _scrollViewDelegateHandlerForScrollView:scrollView];
            handler.didEndDraggingBlock = block;
        }
        return view.okidoki;
    };
}

- (Okidoki*(^)(OkidokiScrollViewWillBeginDeceleratingBlock block))willBeginDecelerating {
    return ^id(OkidokiScrollViewWillBeginDeceleratingBlock block) {
        UIView *view = self.view;
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scrollView = (UIScrollView *)view;
            _OkidokiScrollViewDelegateHandler *handler = [self _scrollViewDelegateHandlerForScrollView:scrollView];
            handler.willBeginDeceleratingBlock = block;
        }
        return view.okidoki;
    };
}

- (Okidoki*(^)(OkidokiScrollViewDidEndDeceleratingBlock block))didEndDecelerating {
    return ^id(OkidokiScrollViewDidEndDeceleratingBlock block) {
        UIView *view = self.view;
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scrollView = (UIScrollView *)view;
            _OkidokiScrollViewDelegateHandler *handler = [self _scrollViewDelegateHandlerForScrollView:scrollView];
            handler.didEndDeceleratingBlock = block;
        }
        return view.okidoki;
    };
}

- (Okidoki*(^)(OkidokiScrollViewDidEndScrollingAnimationBlock block))didEndScrollingAnimation {
    return ^id(OkidokiScrollViewDidEndScrollingAnimationBlock block) {
        UIView *view = self.view;
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scrollView = (UIScrollView *)view;
            _OkidokiScrollViewDelegateHandler *handler = [self _scrollViewDelegateHandlerForScrollView:scrollView];
            handler.didEndScrollingAnimationBlock = block;
        }
        return view.okidoki;
    };
}

- (Okidoki*(^)(OkidokiScrollViewViewForZoomingBlock block))viewForZooming {
    return ^id(OkidokiScrollViewViewForZoomingBlock block) {
        UIView *view = self.view;
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scrollView = (UIScrollView *)view;
            _OkidokiScrollViewDelegateHandler *handler = [self _scrollViewDelegateHandlerForScrollView:scrollView];
            handler.viewForZoomingBlock = block;
        }
        return view.okidoki;
    };
}

- (Okidoki*(^)(OkidokiScrollViewWillBeginZoomingBlock block))willBeginZooming {
    return ^id(OkidokiScrollViewWillBeginZoomingBlock block) {
        UIView *view = self.view;
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scrollView = (UIScrollView *)view;
            _OkidokiScrollViewDelegateHandler *handler = [self _scrollViewDelegateHandlerForScrollView:scrollView];
            handler.willBeginZoomingBlock = block;
        }
        return view.okidoki;
    };
}

- (Okidoki*(^)(OkidokiScrollViewDidEndZoomingBlock block))didEndZooming {
    return ^id(OkidokiScrollViewDidEndZoomingBlock block) {
        UIView *view = self.view;
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scrollView = (UIScrollView *)view;
            _OkidokiScrollViewDelegateHandler *handler = [self _scrollViewDelegateHandlerForScrollView:scrollView];
            handler.didEndZoomingBlock = block;
        }
        return view.okidoki;
    };
}

- (Okidoki*(^)(OkidokiScrollViewShouldScrollToTopBlock block))shouldScrollToTop {
    return ^id(OkidokiScrollViewShouldScrollToTopBlock block) {
        UIView *view = self.view;
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scrollView = (UIScrollView *)view;
            _OkidokiScrollViewDelegateHandler *handler = [self _scrollViewDelegateHandlerForScrollView:scrollView];
            handler.shouldScrollToTopBlock = block;
        }
        return view.okidoki;
    };
}

- (Okidoki*(^)(OkidokiScrollViewDidScrollToTopBlock block))didScrollToTop {
    return ^id(OkidokiScrollViewDidScrollToTopBlock block) {
        UIView *view = self.view;
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scrollView = (UIScrollView *)view;
            _OkidokiScrollViewDelegateHandler *handler = [self _scrollViewDelegateHandlerForScrollView:scrollView];
            handler.didScrollToTopBlock = block;
        }
        return view.okidoki;
    };
}

- (Okidoki*(^)(OkidokiScrollViewDidChangeAdjustedContentInsetBlock block))didChangeAdjustedContentInset {
    return ^id(OkidokiScrollViewDidChangeAdjustedContentInsetBlock block) {
        UIView *view = self.view;
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scrollView = (UIScrollView *)view;
            _OkidokiScrollViewDelegateHandler *handler = [self _scrollViewDelegateHandlerForScrollView:scrollView];
            handler.didChangeAdjustedContentInsetBlock = block;
        }
        return view.okidoki;
    };
}

// Helper method to get or create delegate handler
- (_OkidokiScrollViewDelegateHandler *)_scrollViewDelegateHandlerForScrollView:(UIScrollView *)scrollView {
    static const void *kOkidokiScrollViewDelegateHandlerKey = &kOkidokiScrollViewDelegateHandlerKey;
    
    _OkidokiScrollViewDelegateHandler *handler = objc_getAssociatedObject(scrollView, kOkidokiScrollViewDelegateHandlerKey);
    if (!handler) {
        handler = [[_OkidokiScrollViewDelegateHandler alloc] init];
        objc_setAssociatedObject(scrollView, kOkidokiScrollViewDelegateHandlerKey, handler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        scrollView.delegate = handler;
    }
    return handler;
}

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

kOkidoki_imp(borderStyle, ({
    if ([view isKindOfClass:[UITextView class]]) {
        UITextView *textView = (UITextView *)view;
        if ([borderStyle isKindOfClass:[NSNumber class]] ||
            [borderStyle isKindOfClass:[NSString class]]) {
            NSInteger style = [borderStyle integerValue];
            if (@available(iOS 17.0, *)) {
                textView.borderStyle = style;
            }
        }
    }
}))

kOkidoki_imp(attributedText, ({
    if ([view isKindOfClass:[UITextView class]]) {
        UITextView *textView = (UITextView *)view;
        if ([attributedText isKindOfClass:[NSAttributedString class]]) {
            textView.attributedText = attributedText;
        }
    }
}))

kOkidoki_imp(inputView, ({
    if ([view isKindOfClass:[UITextView class]]) {
        UITextView *textView = (UITextView *)view;
        if ([inputView isKindOfClass:[UIView class]]) {
            textView.inputView = inputView;
        }
    }
}))

kOkidoki_imp(inputAccessoryView, ({
    if ([view isKindOfClass:[UITextView class]]) {
        UITextView *textView = (UITextView *)view;
        if ([inputAccessoryView isKindOfClass:[UIView class]]) {
            textView.inputAccessoryView = inputAccessoryView;
        }
    }
}))

kOkidoki_imp(textContainerInset, ({
    if ([view isKindOfClass:[UITextView class]]) {
        UITextView *textView = (UITextView *)view;
        if ([textContainerInset isKindOfClass:[NSValue class]]) {
            textView.textContainerInset = [textContainerInset UIEdgeInsetsValue];
        } else if ([textContainerInset isKindOfClass:[NSString class]]) {
            textView.textContainerInset = UIEdgeInsetsFromString(textContainerInset);
        }
    }
}))


#pragma mark - UITableView

- (Okidoki*(^)(NSArray *params))registerCellClass {
    return ^id(NSArray *params) {
        UIView *view = self.view;
        if ([view isKindOfClass:[UITableView class]] && [params isKindOfClass:[NSArray class]]) {
            UITableView *tableView = (UITableView *)view;
            if (params.count >= 2) {
                Class cellClass = params[0];
                NSString *identifier = params[1];
                if (cellClass && [identifier isKindOfClass:[NSString class]]) {
                    [tableView registerClass:cellClass forCellReuseIdentifier:identifier];
                }
            }
        }
        return view.okidoki;
    };
}

- (Okidoki*(^)(NSArray *params))registerCellNib {
    return ^id(NSArray *params) {
        UIView *view = self.view;
        if ([view isKindOfClass:[UITableView class]] && [params isKindOfClass:[NSArray class]]) {
            UITableView *tableView = (UITableView *)view;
            if (params.count >= 2) {
                id nibOrName = params[0];
                NSString *identifier = params[1];
                
                if ([identifier isKindOfClass:[NSString class]]) {
                    UINib *nib = nil;
                    
                    if ([nibOrName isKindOfClass:[UINib class]]) {
                        nib = (UINib *)nibOrName;
                    } else if ([nibOrName isKindOfClass:[NSString class]]) {
                        nib = [UINib nibWithNibName:nibOrName bundle:nil];
                    }
                    
                    if (nib) {
                        [tableView registerNib:nib forCellReuseIdentifier:identifier];
                    }
                }
            }
        }
        return view.okidoki;
    };
}

- (Okidoki*(^)(NSArray *params))registerMultiCellClass {
    return ^id(NSArray *params) {
        UIView *view = self.view;
        if ([view isKindOfClass:[UITableView class]] && [params isKindOfClass:[NSArray class]]) {
            UITableView *tableView = (UITableView *)view;
            
            for (id item in params) {
                if ([item isKindOfClass:[NSArray class]]) {
                    NSArray *cellInfo = (NSArray *)item;
                    if (cellInfo.count >= 2) {
                        Class cellClass = cellInfo[0];
                        NSString *identifier = cellInfo[1];
                        if (cellClass && [identifier isKindOfClass:[NSString class]]) {
                            [tableView registerClass:cellClass forCellReuseIdentifier:identifier];
                        }
                    }
                }
            }
        }
        return view.okidoki;
    };
}

- (Okidoki*(^)(OkidokiTableViewNumberOfSectionsBlock block))numberOfSections {
    return ^id(OkidokiTableViewNumberOfSectionsBlock block) {
        UIView *view = self.view;
        if ([view isKindOfClass:[UITableView class]]) {
            UITableView *tableView = (UITableView *)view;
            _OkidokiTableViewDelegateHandler *handler = [self _tableViewDelegateHandlerForTableView:tableView];
            handler.numberOfSectionsBlock = block;
        }
        return view.okidoki;
    };
}

- (Okidoki*(^)(OkidokiTableViewNumberOfRowsInSectionBlock block))numberOfRowsInSection {
    return ^id(OkidokiTableViewNumberOfRowsInSectionBlock block) {
        UIView *view = self.view;
        if ([view isKindOfClass:[UITableView class]]) {
            UITableView *tableView = (UITableView *)view;
            _OkidokiTableViewDelegateHandler *handler = [self _tableViewDelegateHandlerForTableView:tableView];
            handler.numberOfRowsInSectionBlock = block;
        }
        return view.okidoki;
    };
}

- (Okidoki*(^)(OkidokiTableViewCellForRowAtIndexPathBlock block))cellForRowAtIndexPath {
    return ^id(OkidokiTableViewCellForRowAtIndexPathBlock block) {
        UIView *view = self.view;
        if ([view isKindOfClass:[UITableView class]]) {
            UITableView *tableView = (UITableView *)view;
            _OkidokiTableViewDelegateHandler *handler = [self _tableViewDelegateHandlerForTableView:tableView];
            handler.cellForRowAtIndexPathBlock = block;
        }
        return view.okidoki;
    };
}

- (Okidoki*(^)(OkidokiTableViewTitleForHeaderBlock block))titleForHeaderInSection {
    return ^id(OkidokiTableViewTitleForHeaderBlock block) {
        UIView *view = self.view;
        if ([view isKindOfClass:[UITableView class]]) {
            UITableView *tableView = (UITableView *)view;
            _OkidokiTableViewDelegateHandler *handler = [self _tableViewDelegateHandlerForTableView:tableView];
            handler.titleForHeaderInSectionBlock = block;
        }
        return view.okidoki;
    };
}

- (Okidoki*(^)(OkidokiTableViewTitleForFooterBlock block))titleForFooterInSection {
    return ^id(OkidokiTableViewTitleForFooterBlock block) {
        UIView *view = self.view;
        if ([view isKindOfClass:[UITableView class]]) {
            UITableView *tableView = (UITableView *)view;
            _OkidokiTableViewDelegateHandler *handler = [self _tableViewDelegateHandlerForTableView:tableView];
            handler.titleForFooterInSectionBlock = block;
        }
        return view.okidoki;
    };
}

- (Okidoki*(^)(OkidokiTableViewCanEditRowBlock block))canEditRowAtIndexPath {
    return ^id(OkidokiTableViewCanEditRowBlock block) {
        UIView *view = self.view;
        if ([view isKindOfClass:[UITableView class]]) {
            UITableView *tableView = (UITableView *)view;
            _OkidokiTableViewDelegateHandler *handler = [self _tableViewDelegateHandlerForTableView:tableView];
            handler.canEditRowAtIndexPathBlock = block;
        }
        return view.okidoki;
    };
}

- (Okidoki*(^)(OkidokiTableViewCommitEditingStyleBlock block))commitEditingStyle {
    return ^id(OkidokiTableViewCommitEditingStyleBlock block) {
        UIView *view = self.view;
        if ([view isKindOfClass:[UITableView class]]) {
            UITableView *tableView = (UITableView *)view;
            _OkidokiTableViewDelegateHandler *handler = [self _tableViewDelegateHandlerForTableView:tableView];
            handler.commitEditingStyleBlock = block;
        }
        return view.okidoki;
    };
}

- (Okidoki*(^)(OkidokiTableViewHeightForRowBlock block))heightForRowAtIndexPath {
    return ^id(OkidokiTableViewHeightForRowBlock block) {
        UIView *view = self.view;
        if ([view isKindOfClass:[UITableView class]]) {
            UITableView *tableView = (UITableView *)view;
            _OkidokiTableViewDelegateHandler *handler = [self _tableViewDelegateHandlerForTableView:tableView];
            handler.heightForRowAtIndexPathBlock = block;
        }
        return view.okidoki;
    };
}

- (Okidoki*(^)(OkidokiTableViewHeightForHeaderBlock block))heightForHeaderInSection {
    return ^id(OkidokiTableViewHeightForHeaderBlock block) {
        UIView *view = self.view;
        if ([view isKindOfClass:[UITableView class]]) {
            UITableView *tableView = (UITableView *)view;
            _OkidokiTableViewDelegateHandler *handler = [self _tableViewDelegateHandlerForTableView:tableView];
            handler.heightForHeaderInSectionBlock = block;
        }
        return view.okidoki;
    };
}

- (Okidoki*(^)(OkidokiTableViewHeightForFooterBlock block))heightForFooterInSection {
    return ^id(OkidokiTableViewHeightForFooterBlock block) {
        UIView *view = self.view;
        if ([view isKindOfClass:[UITableView class]]) {
            UITableView *tableView = (UITableView *)view;
            _OkidokiTableViewDelegateHandler *handler = [self _tableViewDelegateHandlerForTableView:tableView];
            handler.heightForFooterInSectionBlock = block;
        }
        return view.okidoki;
    };
}

- (Okidoki*(^)(OkidokiTableViewViewForHeaderBlock block))viewForHeaderInSection {
    return ^id(OkidokiTableViewViewForHeaderBlock block) {
        UIView *view = self.view;
        if ([view isKindOfClass:[UITableView class]]) {
            UITableView *tableView = (UITableView *)view;
            _OkidokiTableViewDelegateHandler *handler = [self _tableViewDelegateHandlerForTableView:tableView];
            handler.viewForHeaderInSectionBlock = block;
        }
        return view.okidoki;
    };
}

- (Okidoki*(^)(OkidokiTableViewViewForFooterBlock block))viewForFooterInSection {
    return ^id(OkidokiTableViewViewForFooterBlock block) {
        UIView *view = self.view;
        if ([view isKindOfClass:[UITableView class]]) {
            UITableView *tableView = (UITableView *)view;
            _OkidokiTableViewDelegateHandler *handler = [self _tableViewDelegateHandlerForTableView:tableView];
            handler.viewForFooterInSectionBlock = block;
        }
        return view.okidoki;
    };
}

- (Okidoki*(^)(OkidokiTableViewDidSelectRowBlock block))didSelectRowAtIndexPath {
    return ^id(OkidokiTableViewDidSelectRowBlock block) {
        UIView *view = self.view;
        if ([view isKindOfClass:[UITableView class]]) {
            UITableView *tableView = (UITableView *)view;
            _OkidokiTableViewDelegateHandler *handler = [self _tableViewDelegateHandlerForTableView:tableView];
            handler.didSelectRowAtIndexPathBlock = block;
        }
        return view.okidoki;
    };
}

- (Okidoki*(^)(OkidokiTableViewDidDeselectRowBlock block))didDeselectRowAtIndexPath {
    return ^id(OkidokiTableViewDidDeselectRowBlock block) {
        UIView *view = self.view;
        if ([view isKindOfClass:[UITableView class]]) {
            UITableView *tableView = (UITableView *)view;
            _OkidokiTableViewDelegateHandler *handler = [self _tableViewDelegateHandlerForTableView:tableView];
            handler.didDeselectRowAtIndexPathBlock = block;
        }
        return view.okidoki;
    };
}

- (Okidoki*(^)(OkidokiTableViewWillDisplayCellBlock block))willDisplayCell {
    return ^id(OkidokiTableViewWillDisplayCellBlock block) {
        UIView *view = self.view;
        if ([view isKindOfClass:[UITableView class]]) {
            UITableView *tableView = (UITableView *)view;
            _OkidokiTableViewDelegateHandler *handler = [self _tableViewDelegateHandlerForTableView:tableView];
            handler.willDisplayCellBlock = block;
        }
        return view.okidoki;
    };
}

- (Okidoki*(^)(OkidokiTableViewDidEndDisplayingCellBlock block))didEndDisplayingCell {
    return ^id(OkidokiTableViewDidEndDisplayingCellBlock block) {
        UIView *view = self.view;
        if ([view isKindOfClass:[UITableView class]]) {
            UITableView *tableView = (UITableView *)view;
            _OkidokiTableViewDelegateHandler *handler = [self _tableViewDelegateHandlerForTableView:tableView];
            handler.didEndDisplayingCellBlock = block;
        }
        return view.okidoki;
    };
}

- (Okidoki*(^)(OkidokiTableViewEditingStyleBlock block))editingStyleForRowAtIndexPath {
    return ^id(OkidokiTableViewEditingStyleBlock block) {
        UIView *view = self.view;
        if ([view isKindOfClass:[UITableView class]]) {
            UITableView *tableView = (UITableView *)view;
            _OkidokiTableViewDelegateHandler *handler = [self _tableViewDelegateHandlerForTableView:tableView];
            handler.editingStyleForRowAtIndexPathBlock = block;
        }
        return view.okidoki;
    };
}

// Helper method to get or create delegate handler
- (_OkidokiTableViewDelegateHandler *)_tableViewDelegateHandlerForTableView:(UITableView *)tableView {
    static const void *kOkidokiTableViewDelegateHandlerKey = &kOkidokiTableViewDelegateHandlerKey;
    
    _OkidokiTableViewDelegateHandler *handler = objc_getAssociatedObject(tableView, kOkidokiTableViewDelegateHandlerKey);
    if (!handler) {
        handler = [[_OkidokiTableViewDelegateHandler alloc] init];
        objc_setAssociatedObject(tableView, kOkidokiTableViewDelegateHandlerKey, handler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        tableView.dataSource = handler;
        tableView.delegate = handler;
    }
    return handler;
}

#pragma mark - UICollectionView

// Associated object key for delegate handler
static const char kOkidokiCollectionViewDelegateHandlerKey = '\0';

- (Okidoki*(^)(NSArray *params))cvRegisterCellClass {
    return ^id(NSArray *params) {
        UIView *view = self.view;
        if ([view isKindOfClass:[UICollectionView class]] && [params isKindOfClass:[NSArray class]]) {
            UICollectionView *collectionView = (UICollectionView *)view;
            if (params.count >= 2) {
                Class cellClass = params[0];
                NSString *identifier = params[1];
                if (cellClass && [identifier isKindOfClass:[NSString class]]) {
                    [collectionView registerClass:cellClass forCellWithReuseIdentifier:identifier];
                }
            }
        }
        return view.okidoki;
    };
}

- (Okidoki*(^)(NSArray *params))cvRegisterCellNib {
    return ^id(NSArray *params) {
        UIView *view = self.view;
        if ([view isKindOfClass:[UICollectionView class]] && [params isKindOfClass:[NSArray class]]) {
            UICollectionView *collectionView = (UICollectionView *)view;
            if (params.count >= 2) {
                id nibOrString = params[0];
                NSString *identifier = params[1];
                
                UINib *nib = nil;
                if ([nibOrString isKindOfClass:[UINib class]]) {
                    nib = nibOrString;
                } else if ([nibOrString isKindOfClass:[NSString class]]) {
                    nib = [UINib nibWithNibName:nibOrString bundle:nil];
                }
                
                if (nib && [identifier isKindOfClass:[NSString class]]) {
                    [collectionView registerNib:nib forCellWithReuseIdentifier:identifier];
                }
            }
        }
        return view.okidoki;
    };
}

- (Okidoki*(^)(NSArray *params))cvRegisterSupplementaryViewClass {
    return ^id(NSArray *params) {
        UIView *view = self.view;
        if ([view isKindOfClass:[UICollectionView class]] && [params isKindOfClass:[NSArray class]]) {
            UICollectionView *collectionView = (UICollectionView *)view;
            if (params.count >= 3) {
                Class viewClass = params[0];
                NSString *kind = params[1];
                NSString *identifier = params[2];
                if (viewClass && [kind isKindOfClass:[NSString class]] && [identifier isKindOfClass:[NSString class]]) {
                    [collectionView registerClass:viewClass forSupplementaryViewOfKind:kind withReuseIdentifier:identifier];
                }
            }
        }
        return view.okidoki;
    };
}

- (Okidoki*(^)(NSArray *params))cvRegisterSupplementaryViewNib {
    return ^id(NSArray *params) {
        UIView *view = self.view;
        if ([view isKindOfClass:[UICollectionView class]] && [params isKindOfClass:[NSArray class]]) {
            UICollectionView *collectionView = (UICollectionView *)view;
            if (params.count >= 3) {
                id nibOrString = params[0];
                NSString *kind = params[1];
                NSString *identifier = params[2];
                
                UINib *nib = nil;
                if ([nibOrString isKindOfClass:[UINib class]]) {
                    nib = nibOrString;
                } else if ([nibOrString isKindOfClass:[NSString class]]) {
                    nib = [UINib nibWithNibName:nibOrString bundle:nil];
                }
                
                if (nib && [kind isKindOfClass:[NSString class]] && [identifier isKindOfClass:[NSString class]]) {
                    [collectionView registerNib:nib forSupplementaryViewOfKind:kind withReuseIdentifier:identifier];
                }
            }
        }
        return view.okidoki;
    };
}

- (Okidoki*(^)(OkidokiCollectionViewNumberOfSectionsBlock block))cvNumberOfSections {
    return ^id(OkidokiCollectionViewNumberOfSectionsBlock block) {
        UIView *view = self.view;
        if ([view isKindOfClass:[UICollectionView class]]) {
            UICollectionView *collectionView = (UICollectionView *)view;
            _OkidokiCollectionViewDelegateHandler *handler = [self _collectionViewDelegateHandlerForCollectionView:collectionView];
            handler.numberOfSectionsBlock = block;
        }
        return view.okidoki;
    };
}

- (Okidoki*(^)(OkidokiCollectionViewNumberOfItemsInSectionBlock block))cvNumberOfItemsInSection {
    return ^id(OkidokiCollectionViewNumberOfItemsInSectionBlock block) {
        UIView *view = self.view;
        if ([view isKindOfClass:[UICollectionView class]]) {
            UICollectionView *collectionView = (UICollectionView *)view;
            _OkidokiCollectionViewDelegateHandler *handler = [self _collectionViewDelegateHandlerForCollectionView:collectionView];
            handler.numberOfItemsInSectionBlock = block;
        }
        return view.okidoki;
    };
}

- (Okidoki*(^)(OkidokiCollectionViewCellForItemAtIndexPathBlock block))cvCellForItemAtIndexPath {
    return ^id(OkidokiCollectionViewCellForItemAtIndexPathBlock block) {
        UIView *view = self.view;
        if ([view isKindOfClass:[UICollectionView class]]) {
            UICollectionView *collectionView = (UICollectionView *)view;
            _OkidokiCollectionViewDelegateHandler *handler = [self _collectionViewDelegateHandlerForCollectionView:collectionView];
            handler.cellForItemAtIndexPathBlock = block;
        }
        return view.okidoki;
    };
}

- (Okidoki*(^)(OkidokiCollectionViewViewForSupplementaryElementBlock block))cvViewForSupplementaryElement {
    return ^id(OkidokiCollectionViewViewForSupplementaryElementBlock block) {
        UIView *view = self.view;
        if ([view isKindOfClass:[UICollectionView class]]) {
            UICollectionView *collectionView = (UICollectionView *)view;
            _OkidokiCollectionViewDelegateHandler *handler = [self _collectionViewDelegateHandlerForCollectionView:collectionView];
            handler.viewForSupplementaryElementBlock = block;
        }
        return view.okidoki;
    };
}

- (Okidoki*(^)(OkidokiCollectionViewDidSelectItemBlock block))cvDidSelectItemAtIndexPath {
    return ^id(OkidokiCollectionViewDidSelectItemBlock block) {
        UIView *view = self.view;
        if ([view isKindOfClass:[UICollectionView class]]) {
            UICollectionView *collectionView = (UICollectionView *)view;
            _OkidokiCollectionViewDelegateHandler *handler = [self _collectionViewDelegateHandlerForCollectionView:collectionView];
            handler.didSelectItemAtIndexPathBlock = block;
        }
        return view.okidoki;
    };
}

- (Okidoki*(^)(OkidokiCollectionViewDidDeselectItemBlock block))cvDidDeselectItemAtIndexPath {
    return ^id(OkidokiCollectionViewDidDeselectItemBlock block) {
        UIView *view = self.view;
        if ([view isKindOfClass:[UICollectionView class]]) {
            UICollectionView *collectionView = (UICollectionView *)view;
            _OkidokiCollectionViewDelegateHandler *handler = [self _collectionViewDelegateHandlerForCollectionView:collectionView];
            handler.didDeselectItemAtIndexPathBlock = block;
        }
        return view.okidoki;
    };
}

- (Okidoki*(^)(OkidokiCollectionViewWillDisplayCellBlock block))cvWillDisplayCell {
    return ^id(OkidokiCollectionViewWillDisplayCellBlock block) {
        UIView *view = self.view;
        if ([view isKindOfClass:[UICollectionView class]]) {
            UICollectionView *collectionView = (UICollectionView *)view;
            _OkidokiCollectionViewDelegateHandler *handler = [self _collectionViewDelegateHandlerForCollectionView:collectionView];
            handler.willDisplayCellBlock = block;
        }
        return view.okidoki;
    };
}

- (Okidoki*(^)(OkidokiCollectionViewDidEndDisplayingCellBlock block))cvDidEndDisplayingCell {
    return ^id(OkidokiCollectionViewDidEndDisplayingCellBlock block) {
        UIView *view = self.view;
        if ([view isKindOfClass:[UICollectionView class]]) {
            UICollectionView *collectionView = (UICollectionView *)view;
            _OkidokiCollectionViewDelegateHandler *handler = [self _collectionViewDelegateHandlerForCollectionView:collectionView];
            handler.didEndDisplayingCellBlock = block;
        }
        return view.okidoki;
    };
}

- (Okidoki*(^)(OkidokiCollectionViewSizeForItemBlock block))cvSizeForItemAtIndexPath {
    return ^id(OkidokiCollectionViewSizeForItemBlock block) {
        UIView *view = self.view;
        if ([view isKindOfClass:[UICollectionView class]]) {
            UICollectionView *collectionView = (UICollectionView *)view;
            _OkidokiCollectionViewDelegateHandler *handler = [self _collectionViewDelegateHandlerForCollectionView:collectionView];
            handler.sizeForItemAtIndexPathBlock = block;
        }
        return view.okidoki;
    };
}

- (Okidoki*(^)(OkidokiCollectionViewInsetForSectionBlock block))cvInsetForSectionAtIndex {
    return ^id(OkidokiCollectionViewInsetForSectionBlock block) {
        UIView *view = self.view;
        if ([view isKindOfClass:[UICollectionView class]]) {
            UICollectionView *collectionView = (UICollectionView *)view;
            _OkidokiCollectionViewDelegateHandler *handler = [self _collectionViewDelegateHandlerForCollectionView:collectionView];
            handler.insetForSectionAtIndexBlock = block;
        }
        return view.okidoki;
    };
}

- (Okidoki*(^)(OkidokiCollectionViewMinimumLineSpacingBlock block))cvMinimumLineSpacing {
    return ^id(OkidokiCollectionViewMinimumLineSpacingBlock block) {
        UIView *view = self.view;
        if ([view isKindOfClass:[UICollectionView class]]) {
            UICollectionView *collectionView = (UICollectionView *)view;
            _OkidokiCollectionViewDelegateHandler *handler = [self _collectionViewDelegateHandlerForCollectionView:collectionView];
            handler.minimumLineSpacingBlock = block;
        }
        return view.okidoki;
    };
}

- (Okidoki*(^)(OkidokiCollectionViewMinimumInteritemSpacingBlock block))cvMinimumInteritemSpacing {
    return ^id(OkidokiCollectionViewMinimumInteritemSpacingBlock block) {
        UIView *view = self.view;
        if ([view isKindOfClass:[UICollectionView class]]) {
            UICollectionView *collectionView = (UICollectionView *)view;
            _OkidokiCollectionViewDelegateHandler *handler = [self _collectionViewDelegateHandlerForCollectionView:collectionView];
            handler.minimumInteritemSpacingBlock = block;
        }
        return view.okidoki;
    };
}

// Helper method to get or create delegate handler
- (_OkidokiCollectionViewDelegateHandler *)_collectionViewDelegateHandlerForCollectionView:(UICollectionView *)collectionView {
    if (!collectionView) return nil;
    
    _OkidokiCollectionViewDelegateHandler *handler = objc_getAssociatedObject(collectionView, &kOkidokiCollectionViewDelegateHandlerKey);
    if (!handler) {
        handler = [[_OkidokiCollectionViewDelegateHandler alloc] init];
        objc_setAssociatedObject(collectionView, &kOkidokiCollectionViewDelegateHandlerKey, handler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        // Set the handler as delegate and dataSource
        collectionView.delegate = handler;
        collectionView.dataSource = handler;
    }
    return handler;
}


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

- (Okidoki*(^)(id _Nullable))edgeToSuperView {
    return ^id(id _Nullable params) {
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
