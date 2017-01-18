//
//  HXTextGraphicsParser.h
//  DingDing_Project
//
//  Created by hanxiaoqing on 2017/1/16.
//  Copyright © 2017年 HXQ. All rights reserved.
//

#import <AppKit/AppKit.h>
#import "NSMutableAttributedString+HXPromote.h"

#import "CustomAttachMentCell.h"



@interface HXTextGraphicsParser : NSObject

+ (instancetype)shareParser;


/** 解析特殊字符串的正则表达式*/
@property (copy, nonatomic) NSString *pattarnRegex;

/** 图片文字附件的一些属性 Size（大小） BaselineOffset（基准线的偏移量） */
@property (nonatomic,assign) CGSize  attachGraphicsSize;
@property (nonatomic,assign) CGPoint attachGraphicsCharBaselineOffset;


/**
 生成的attributedString的一些属性
 */
@property (assign, nonatomic) CGFloat attributedStringLineSpace;

- (NSMutableAttributedString *)resultAttributedStringFromText:(NSString *)text;

- (CGFloat)resultAttributeTextHeightForLayoutWidth:(CGFloat)width;

- (CGSize)resultAttributeTextHeightForSingleLine;
@end
