//
//  NSMutableAttributedString+AttachMent.h
//  SWAttributedLabel
//
//  Created by han on 2016/10/23.
//  Copyright © 2016年 mxc235. All rights reserved.
//

#import <AppKit/AppKit.h>
#import "CustomAttachMentCell.h"

@interface NSMutableAttributedString (AttachMent)

+ (NSMutableAttributedString *)attributedStringWithAttachmentCell:(NSTextAttachmentCell *)attachmentCell;

+ (NSMutableAttributedString *)attributedStringWithImage:(NSImage *)image;

- (void)apppendAttachmentCell:(NSTextAttachmentCell *)attachmentCell;


+ (NSMutableAttributedString *)parseFaceWordFromString:(NSString *)string;

@end
