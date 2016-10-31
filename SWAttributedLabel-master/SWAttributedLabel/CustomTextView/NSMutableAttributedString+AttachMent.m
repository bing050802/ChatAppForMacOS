//
//  NSMutableAttributedString+AttachMent.m
//  SWAttributedLabel
//
//  Created by han on 2016/10/23.
//  Copyright © 2016年 mxc235. All rights reserved.
//

#import "NSMutableAttributedString+AttachMent.h"
#import "NSMutableAttributedString+Config.h"
#import "RegexKitLite.h"
#import "HXTextPart.h"
#import "CustomAttachMentCell.h"
#import <CoreText/CoreText.h>


@implementation NSMutableAttributedString (AttachMent)

+ (NSMutableAttributedString *)attributedStringWithAttachmentCell:(NSTextAttachmentCell *)attachmentCell {
    NSTextAttachment *att = [[NSTextAttachment alloc] init];
    att.attachmentCell = attachmentCell;
    NSAttributedString *attString = [NSAttributedString attributedStringWithAttachment:att];
    NSMutableAttributedString *mu = [[NSMutableAttributedString alloc] initWithAttributedString:attString];
    return mu;
}

+ (NSMutableAttributedString *)attributedStringWithImage:(NSImage *)image attachSize:(CGSize)size {
    CustomAttachMentCell *attCell = [[CustomAttachMentCell alloc] init];
    attCell.attachImage = image;
    attCell.attachSize = size;
    return [self attributedStringWithAttachmentCell:attCell];
}


+ (NSArray *)patternPartsWithRegex:(NSString *)regex originString:(NSString *)Ostr {
    // 遍历所有的特殊字符串
    NSMutableArray *parts = [NSMutableArray array];
    [Ostr enumerateStringsMatchedByRegex:regex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        if ((*capturedRanges).length == 0) return;
        
        HXTextPart *part = [[HXTextPart alloc] init];
        part.special = YES;
        part.text = *capturedStrings;
        part.emotion = [part.text hasPrefix:@"["] && [part.text hasSuffix:@"]"];
        part.range = *capturedRanges;
        [parts addObject:part];
    }];
    // 遍历所有的非特殊字符
    [Ostr enumerateStringsSeparatedByRegex:regex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        if ((*capturedRanges).length == 0) return;
        
        HXTextPart *part = [[HXTextPart alloc] init];
        part.text = *capturedStrings;
        part.range = *capturedRanges;
        [parts addObject:part];
    }];
    
    // 系统是按照从小 -> 大的顺序排列对象
    [parts sortUsingComparator:^NSComparisonResult(HXTextPart *part1, HXTextPart *part2) {
        if (part1.range.location > part2.range.location) {
            return NSOrderedDescending;
        }
        return NSOrderedAscending;
    }];

    return parts;
}

+ (NSMutableAttributedString *)parseFaceWordFromString:(NSString *)string {
    //  NSString *str = @"womenshi[哈哈]打算[rwrqw]发顺丰[觉得]分手季阿卡丽放假[偷笑]";

    // 表情的规则
    NSString *emotionPattern = @"\\[[0-9a-zA-Z\\u4e00-\\u9fa5]+\\]";
    // url链接的规则
    NSString *urlPattern = @"\\b(([\\w-]+://?|www[.])[^\\s()<>]+(?:\\([\\w\\d]+\\)|([^[:punct:]\\s]|/)))";
    NSString *pattern = [NSString stringWithFormat:@"%@|%@", emotionPattern,urlPattern];
    
    // 按顺序拼接每一段文字
    NSMutableAttributedString *resultAttString = [[NSMutableAttributedString alloc] init];
    NSMutableAttributedString *singelineCalculateString = [[NSMutableAttributedString alloc] init];
    
    for (HXTextPart *part in [self patternPartsWithRegex:pattern originString:string]) {
        // 等会需要拼接的子串
        NSMutableAttributedString *substr = nil;
        // 由于计算含有attachMent的单行属性文字宽度不准确 提供一个临时的用CTRunDelegate代表表情的属性文字用于计算单行宽度
        NSMutableAttributedString *subCalculateString = nil;

        if (part.isEmotion) { // 表情
            CGSize attSize = CGSizeMake(30, 30);
            substr = [self attributedStringWithImage:[NSImage imageNamed:@"haha@2x"] attachSize:attSize];
            subCalculateString = [self createReplacementAttString];
            
        } else if (part.special) { // 非表情的特殊文字
            
        } else { // 非特殊文字
            substr = [[NSMutableAttributedString alloc] initWithString:part.text];
            [substr setFont:[NSFont systemFontOfSize:14] range:NSMakeRange(0, part.text.length)];
            subCalculateString = substr;
        }
        [resultAttString appendAttributedString:substr];
        [singelineCalculateString appendAttributedString:subCalculateString];
    }
    
    // 计算 单行文字宽高
    CGSize singelineSize = [singelineCalculateString calculateSingelineSize];
    [resultAttString addAttribute:@"singelineSize" value:[NSValue valueWithSize:singelineSize] range:NSMakeRange(0, 1)];
//    [resultAttString attribute:@"specials" atIndex:0 effectiveRange:NULL];
    return resultAttString;
}

- (CGSize)singelineSize {
    NSValue *value = [self attribute:@"singelineSize" atIndex:0 effectiveRange:NULL];
    if (!value) {
        return CGSizeZero;
    }
    return [value sizeValue];
}


- (CGSize)calculateSingelineSize {
    CGFloat  ascent;
    CGFloat  descent;
    CGFloat  leading;
    CTLineRef lineRef = CTLineCreateWithAttributedString((CFAttributedStringRef)self);
    CGFloat width = CTLineGetTypographicBounds(lineRef, &ascent, &descent, &leading);
    width = ceil(width);
    CGFloat height = ceil(ascent + leading + descent);
    return CGSizeMake(width, height);
}


+ (NSMutableAttributedString *)createReplacementAttString
{
    CTRunDelegateCallbacks callbacks;
    memset(&callbacks, 0, sizeof(CTRunDelegateCallbacks));
    callbacks.version = kCTRunDelegateVersion1;
    callbacks.getAscent = ascentCallback;
    callbacks.getDescent = descentCallback;
    callbacks.getWidth = widthCallback;
    
    // 创建CTRun回调
    CTRunDelegateRef runDelegate = CTRunDelegateCreate(&callbacks, NULL);
    
    // 使用 0xFFFC 作为空白的占位符
    unichar objectReplacementChar = 0xFFFC;
    NSString *string = [NSString stringWithCharacters:&objectReplacementChar length:1];
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:string];
    [attString addAttribute:(NSString *)kCTRunDelegateAttributeName value:(__bridge id)runDelegate range:NSMakeRange(0, 1)];
    
    CFRelease(runDelegate);
    
    return attString;
}

// 调整图片对齐方式
static CGFloat ascentCallback(void *ref) {
    return 30;
}

// 调整图片对齐方式
static CGFloat descentCallback(void *ref) {
    return 0;
}

// 获取图片宽度
static CGFloat widthCallback(void *ref) {
    return 30;
}



@end
