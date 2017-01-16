//
//  NSMutableAttributedString+Config.h
//  SWAttributedLabel
//
//  Created by mxc235 on 16/8/31.
//  Copyright © 2016年 mxc235. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#import <CoreText/CoreText.h>

@interface NSMutableAttributedString (Config)

// 设置颜色
- (void)setTextColor:(NSColor *)color;
- (void)setTextColor:(NSColor *)color range:(NSRange)range;

// 设置字体
- (void)setFont:(NSFont *)font;
- (void)setFont:(NSFont *)font range:(NSRange)range;

- (void)setLineSpacing:(CGFloat)lineSpacing;

@end

