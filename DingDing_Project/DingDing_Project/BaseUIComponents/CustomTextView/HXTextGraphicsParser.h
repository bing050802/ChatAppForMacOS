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

@property (copy, nonatomic) NSString *pattarnRegex;

@property (nonatomic,assign)  CGSize  attachGraphicsSize;
@property (nonatomic,assign)  CGPoint attachGraphicsCharBaselineOffset;


@property (assign, nonatomic) CGFloat attributedStringLineSpace;

- (NSMutableAttributedString *)resultAttributedStringFromText:(NSString *)text;

- (CGFloat)resultAttributeTextHeightForLayoutWidth:(CGFloat)width;

- (CGSize)resultAttributeTextHeightForSingleLine;
@end
