//
//  NSMutableAttributedString+AttachMent.m
//  SWAttributedLabel
//
//  Created by han on 2016/10/23.
//  Copyright © 2016年 mxc235. All rights reserved.
//

#import "NSMutableAttributedString+AttachMent.h"

@implementation NSMutableAttributedString (AttachMent)

+ (NSMutableAttributedString *)attributedStringWithImage:(NSImage *)image {
    CustomAttachMentCell *attCell = [[CustomAttachMentCell alloc] init];
    attCell.attachImage = image;
    attCell.attachSize = CGSizeMake(30, 30);
    return [self attributedStringWithAttachmentCell:attCell];
}

+ (NSMutableAttributedString *)attributedStringWithAttachmentCell:(NSTextAttachmentCell *)attachmentCell {
    NSTextAttachment *att = [[NSTextAttachment alloc] init];
    att.attachmentCell = attachmentCell;
    NSAttributedString *attString = [NSAttributedString attributedStringWithAttachment:att];
    return [[NSMutableAttributedString alloc] initWithAttributedString:attString];
}

- (void)apppendAttachmentCell:(NSTextAttachmentCell *)attachmentCell {
    NSTextAttachment *att = [[NSTextAttachment alloc] init];
    att.attachmentCell = attachmentCell;
    NSAttributedString *attString = [NSAttributedString attributedStringWithAttachment:att];
    [self appendAttributedString:attString];
}

@end
