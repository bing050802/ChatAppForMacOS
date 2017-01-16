//
//  NSMutableAttributedString+Config.m
//  SWAttributedLabel
//
//  Created by mxc235 on 16/8/31.
//  Copyright © 2016年 mxc235. All rights reserved.
//

#import "NSMutableAttributedString+Config.h"

@implementation NSMutableAttributedString (Config)

// 设置颜色
- (void)setTextColor:(NSColor *)color {
    [self setTextColor:color range:NSMakeRange(0, [self length])];
}

- (void)setTextColor:(NSColor *)color range:(NSRange)range {
    if (color.CGColor) {
        [self removeAttribute:(NSString *)kCTForegroundColorAttributeName range:range];
        [self addAttribute:(NSString *)kCTForegroundColorAttributeName
                     value:(id)color.CGColor
                     range:range];
    }
}


// 设置字体
- (void)setFont:(NSFont *)font {
    [self setFont:font range:NSMakeRange(0, self.length)];
}

- (void)setFont:(NSFont *)font range:(NSRange)range {
    if (font) {
        [self removeAttribute:(NSString*)kCTFontAttributeName range:range];
        CTFontRef fontRef = CTFontCreateWithName((CFStringRef)font.fontName, font.pointSize, nil);
        if (fontRef) {
            [self addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)fontRef range:range];
            CFRelease(fontRef);
        }
    }
}


- (void)setLineSpacing:(CGFloat)lineSpacing {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];//调整行间距
    [self addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self length])];
}




@end
