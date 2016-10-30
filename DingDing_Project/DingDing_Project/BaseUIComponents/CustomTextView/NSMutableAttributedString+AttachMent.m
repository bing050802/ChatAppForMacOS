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

@implementation NSMutableAttributedString (AttachMent)

+ (NSMutableAttributedString *)attributedStringWithImage:(NSImage *)image {
    CustomAttachMentCell *attCell = [[CustomAttachMentCell alloc] init];
    attCell.attachImage = image;
    CGFloat size = [NSFont systemFontOfSize:24].ascender - [NSFont systemFontOfSize:24].descender ;
    attCell.attachSize = CGSizeMake(size, size);
    return [self attributedStringWithAttachmentCell:attCell];
}

+ (NSMutableAttributedString *)attributedStringWithAttachmentCell:(NSTextAttachmentCell *)attachmentCell {
    NSTextAttachment *att = [[NSTextAttachment alloc] init];
    att.attachmentCell = attachmentCell;
    NSAttributedString *attString = [NSAttributedString attributedStringWithAttachment:att];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithAttributedString:attString];
    [attStr setFont:[NSFont systemFontOfSize:24]];
    return attStr;
}

- (void)apppendAttachmentCell:(NSTextAttachmentCell *)attachmentCell {
    NSTextAttachment *att = [[NSTextAttachment alloc] init];
    att.attachmentCell = attachmentCell;
    NSAttributedString *attString = [NSAttributedString attributedStringWithAttachment:att];
    [self appendAttributedString:attString];
}

+ (NSMutableAttributedString *)parseFaceWordFromString:(NSString *)string {
        //  NSString *str = @"womenshi[哈哈]打算[rwrqw]发顺丰[觉得]分手季阿卡丽放假[偷笑]";
    NSMutableAttributedString *resultAttString = [[NSMutableAttributedString alloc] init];
    // 表情的规则
    NSString *emotionPattern = @"\\[[0-9a-zA-Z\\u4e00-\\u9fa5]+\\]";
    // url链接的规则
    NSString *urlPattern = @"\\b(([\\w-]+://?|www[.])[^\\s()<>]+(?:\\([\\w\\d]+\\)|([^[:punct:]\\s]|/)))";
    NSString *pattern = [NSString stringWithFormat:@"%@|%@", emotionPattern,urlPattern];
    
//    [string enumerateStringsMatchedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
//        NSMutableAttributedString *attach = [self attributedStringWithImage:[NSImage imageNamed:@"haha@2x"]];
//        NSRange range = *capturedRanges;
//        [resultAttString replaceCharactersInRange:NSMakeRange(range.location, 1) withAttributedString:attach];
//    }];

    // 遍历所有的特殊字符串
    NSMutableArray *parts = [NSMutableArray array];
    [string enumerateStringsMatchedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        if ((*capturedRanges).length == 0) return;
        
        HXTextPart *part = [[HXTextPart alloc] init];
        part.special = YES;
        part.text = *capturedStrings;
        part.emotion = [part.text hasPrefix:@"["] && [part.text hasSuffix:@"]"];
        part.range = *capturedRanges;
        [parts addObject:part];
    }];
    // 遍历所有的非特殊字符
    [string enumerateStringsSeparatedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        if ((*capturedRanges).length == 0) return;
        
        HXTextPart *part = [[HXTextPart alloc] init];
        part.text = *capturedStrings;
        part.range = *capturedRanges;
        [parts addObject:part];
    }];
    
    // 系统是按照从小 -> 大的顺序排列对象
    [parts sortUsingComparator:^NSComparisonResult(HXTextPart *part1, HXTextPart *part2) {
        // NSOrderedAscending = -1L, NSOrderedSame, NSOrderedDescending
        // 返回NSOrderedSame:两个一样大
        // NSOrderedAscending(升序):part2>part1
        // NSOrderedDescending(降序):part1>part2
        if (part1.range.location > part2.range.location) {
            // part1>part2
            // part1放后面, part2放前面
            return NSOrderedDescending;
        }
        // part1<part2
        // part1放前面, part2放后面
        return NSOrderedAscending;
    }];
    // 按顺序拼接每一段文字
    for (HXTextPart *part in parts) {
        // 等会需要拼接的子串
        NSMutableAttributedString *substr = nil;
        if (part.isEmotion) { // 表情
                substr = [self attributedStringWithImage:[NSImage imageNamed:@"haha@2x"]];;
        } else if (part.special) { // 非表情的特殊文字

        } else { // 非特殊文字
            substr = [[NSMutableAttributedString alloc] initWithString:part.text];
            [substr setFont:[NSFont systemFontOfSize:14] range:NSMakeRange(0, part.text.length)];
        }
        [resultAttString appendAttributedString:substr];
    }
    
    return resultAttString;
    
}
@end
