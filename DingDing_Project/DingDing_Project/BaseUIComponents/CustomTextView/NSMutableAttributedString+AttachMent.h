//
//  NSMutableAttributedString+AttachMent.h
//  SWAttributedLabel
//
//  Created by han on 2016/10/23.
//  Copyright © 2016年 mxc235. All rights reserved.
//

#import <AppKit/AppKit.h>
#import "CustomAttachMentCell.h"
#import "NSMutableAttributedString+Config.h"

@interface NSMutableAttributedString (AttachMent)

+ (NSMutableAttributedString *)attributedStringWithImage:(NSImage *)image;
+ (NSMutableAttributedString *)attributedStringWithAttachmentCell:(NSTextAttachmentCell *)attachmentCell;

+ (NSMutableAttributedString *)parseFaceWordFromString:(NSString *)string;

- (CGSize)singelineSize;
- (CGSize)mlineSize;

@end
