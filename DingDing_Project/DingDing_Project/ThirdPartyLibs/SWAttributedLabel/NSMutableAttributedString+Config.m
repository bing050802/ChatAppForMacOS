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
    [self setFont:font range:NSMakeRange(0, [self length])];
}

- (void)setFont:(NSFont *)font range:(NSRange)range {
    if (font) {
        [self removeAttribute:(NSString*)kCTFontAttributeName range:range];
        
        CTFontRef fontRef = CTFontCreateWithName((CFStringRef)font.fontName, font.pointSize, nil);
        if (nil != fontRef) {
            [self addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)fontRef range:range];
            CFRelease(fontRef);
        }
    }
}

// 设置下划线
- (void)setUnderlineStyle:(CTUnderlineStyle)style
                 modifier:(CTUnderlineStyleModifiers)modifier {
    [self setUnderlineStyle:style
                   modifier:modifier
                      range:NSMakeRange(0, self.length)];
}

- (void)setUnderlineStyle:(CTUnderlineStyle)style
                 modifier:(CTUnderlineStyleModifiers)modifier
                    range:(NSRange)range {
    [self removeAttribute:(NSString *)kCTUnderlineColorAttributeName range:range];
    [self addAttribute:(NSString *)kCTUnderlineStyleAttributeName
                 value:[NSNumber numberWithInt:(style|modifier)]
                 range:range];
    
}


- (void)setLineSpacing:(CGFloat)lineSpacing {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];//调整行间距
    [self addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self length])];
}

- (void)setLineSpacing:(CGFloat)lineSpacing
      paragraphSpacing:(CGFloat)paragraphSpacing
         textAlignment:(CTTextAlignment)textAlignment
         lineBreakMode:(CTLineBreakMode)lineBreakMode {
    
    [self removeAttribute:(id)kCTParagraphStyleAttributeName range:NSMakeRange(0, [self length])];
    
    
    // 设置行间距
    const CFIndex kNumberOfSettings = 6;
    CTParagraphStyleSetting theSettings[kNumberOfSettings] = {
        {kCTParagraphStyleSpecifierLineBreakMode, sizeof(uint8_t), &lineBreakMode},
        {kCTParagraphStyleSpecifierAlignment, sizeof(uint8_t), &textAlignment},
        {kCTParagraphStyleSpecifierParagraphSpacing, sizeof(CGFloat), &paragraphSpacing},
        {kCTParagraphStyleSpecifierLineSpacingAdjustment, sizeof(CGFloat), &lineSpacing},
        {kCTParagraphStyleSpecifierMaximumLineSpacing, sizeof(CGFloat), &lineSpacing},
        {kCTParagraphStyleSpecifierMinimumLineSpacing, sizeof(CGFloat), &lineSpacing}
    };
    
    CTParagraphStyleRef theParagraphRef = CTParagraphStyleCreate(theSettings, kNumberOfSettings);
    [self addAttribute:(id)kCTParagraphStyleAttributeName
                 value:(__bridge id)theParagraphRef
                 range:NSMakeRange(0, [self length])];
    CFRelease(theParagraphRef);

}



@end
