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

@implementation NSMutableAttributedString (AttachMent)

+ (NSMutableAttributedString *)attributedStringWithImage:(NSImage *)image {
    CustomAttachMentCell *attCell = [[CustomAttachMentCell alloc] init];
    attCell.attachImage = image;
    attCell.attachSize = CGSizeMake(28, 28);
    return [self attributedStringWithAttachmentCell:attCell];
}

+ (NSMutableAttributedString *)attributedStringWithAttachmentCell:(NSTextAttachmentCell *)attachmentCell {
    NSTextAttachment *att = [[NSTextAttachment alloc] init];
    att.attachmentCell = attachmentCell;
    NSAttributedString *attString = [NSAttributedString attributedStringWithAttachment:att];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithAttributedString:attString];
    [attStr setFont:[NSFont systemFontOfSize:28]];
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
    NSMutableAttributedString *resultAttString = [[NSMutableAttributedString alloc] initWithString:string];
    [resultAttString setFont:[NSFont systemFontOfSize:14.0]];
    NSString *patternStr = @"\\[[0-9a-zA-Z\\u4e00-\\u9fa5]+\\]";
    
    [string enumerateStringsMatchedByRegex:patternStr usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        NSMutableAttributedString *attach = [self attributedStringWithImage:[NSImage imageNamed:@"haha@2x"]];
        NSRange range = *capturedRanges;
        [resultAttString replaceCharactersInRange:NSMakeRange(range.location, 1) withAttributedString:attach];
    }];
    


    
    
    
    
    return resultAttString;
    
}
@end
