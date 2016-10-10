//
//  SWAttributedLabel.h
//  SWAttributedLabel
//
//  Created by mxc235 on 16/8/31.
//  Copyright © 2016年 mxc235. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SWAttributedImageInfo.h"
#import "NSMutableAttributedString+Config.h"
#import "NSMutableAttributedString+Parse.h"
#import "NSMutableAttributedString+CTFrameRef.h"

@interface SWAttributedLabel : NSView

@property (nonatomic, strong) NSFont *font;             //!< 字体
@property (nonatomic, strong) NSColor *textColor;       //!< 文本颜色

@property (nonatomic, assign)  CGFloat          lineSpacing;      //!<  行间距
@property (nonatomic, assign)  CGFloat          paragraphSpacing; //!<  段间距

@property (nonatomic, assign)  CTTextAlignment  textAlignment;     // 文字排版样式
@property (nonatomic, assign)  CTLineBreakMode  lineBreakMode;     // LineBreakMode

@property (nonatomic, assign)  SWImageAlignment imageAlignment;    // 图片相对于文字的排版样式
@property (nonatomic, assign)  NSEdgeInsets     imageMargin;       // 图片与文字之间的间距

@property (nonatomic, assign)  NSUInteger       numberOfLines;     // 行数
@property (nonatomic, assign)  CGSize           imageSize;         // 图片size，针对文本中所有的图片

@property (nonatomic, strong) NSMutableAttributedString *attributedString;

//大小
- (CGSize)sizeThatFits:(CGSize)size;

//普通文本
- (void)setText:(NSString *)text;

//属性文本
- (void)setAttributedText:(NSAttributedString *)attributedText;

@end
