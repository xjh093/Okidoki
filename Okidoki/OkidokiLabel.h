//
//  OkidokiLabel.h
//
//  Created by HaoCold on 2026-06-26
//  Copyright © 2026年 HaoCold. All rights reserved.
//
//  UILabel 子类，支持四方向文字内边距，且兼容阿拉伯语等 RTL 语言。
//  textInsets 的 left/right 按「语义（leading/trailing）」解释：
//    LTR：left = 起始边距，right = 结束边距
//    RTL：left/right 自动互换，保持视觉一致
//
//  MIT License

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// UILabel 子类，支持四方向文字内边距。
/// left/right 按 leading/trailing 语义自动适配 RTL。
@interface OkidokiLabel : UILabel

/// 文字内边距。left/right 按 leading/trailing 语义自动适配 RTL。
@property (nonatomic, assign) UIEdgeInsets textInsets;

#ifdef DEBUG
/// 调试开关：可视化展示 textInsets 区域。仅 DEBUG 编译时生效。
///
/// 开启后叠加绘制：
/// - 红色虚线框：标签 bounds 边界
/// - 蓝色实线框：文字实际绘制区域（insets 收缩后）
/// - 半透明红色填充：四个 inset 区域
@property (nonatomic, assign) BOOL debugBorder;
#endif

@end

NS_ASSUME_NONNULL_END
