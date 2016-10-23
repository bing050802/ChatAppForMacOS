//
//  HXMineMessageCell.m
//  DingDing_Project
//
//  Created by hanxiaoqing on 2016/10/12.
//  Copyright © 2016年 HXQ. All rights reserved.
//

#import "HXMineMessageCell.h"
#import "HXPrefixHeader.h"

#import "SWAttributedLabel.h"
#import "HXTextView.h"

#import "NSImage+StackBlur.h"

@interface HXMineMessageCell ()

@property (weak) IBOutlet NSTextField *timeLabel;
@property (weak) IBOutlet NSImageView *iconImage;

@property (weak) IBOutlet NSView *labelBgView;

@property (unsafe_unretained) IBOutlet HXTextView *msgTextView;

@property (weak) IBOutlet NSLayoutConstraint *textBgHeightCons;
@property (weak) IBOutlet NSLayoutConstraint *textBgWidthCons;

@end

@implementation HXMineMessageCell

- (void)awakeFromNib {
    
//    [self.labelBgView backGroundColor:[NSColor redColor]];
//    self.labelBgView.layer.borderColor = HXColor(225, 224, 228).CGColor;
//    self.labelBgView.layer.borderWidth = 1.1;
//    self.labelBgView.layer.cornerRadius = 7.0;
    
    self.msgTextView.textContainerInset = NSMakeSize(0, 8.0);
    self.msgTextView.drawsBackground = NO;
    self.msgTextView.borderColor = HXColor(225, 224, 228);
    self.msgTextView.font = [NSFont systemFontOfSize:14.0];


}

- (void)setMessage:(HXMessage *)message {
    _message = message;
    
    [self.iconImage sd_setImageWithURL:message.profile_image placeholderImage:nil options:SDWebImageCircledImage];
    if (!message.profile_image.length) {
        self.iconImage.image = [NSImage circleImageWithColor:HXRandomColor size:self.iconImage.frame.size text:message.name];
    }
    
    // 2014-10-30 18:07:47
    self.timeLabel.stringValue = [message.create_time substringWithRange:NSMakeRange(message.create_time.length - 5, 5)];
    
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:message.text];
    [attString setFont:[NSFont systemFontOfSize:14.0]];
    [self.msgTextView insertText:attString replacementRange:NSMakeRange(0, 0)];
    self.msgTextView.editable = NO;
    
    CGSize textRealSize = [attString realitySizeForWidth:320 numberOfLines:0];
    if (textRealSize.height <= 17) {
        self.textBgWidthCons.constant = textRealSize.width + 15;
    }
    self.textBgHeightCons.constant = textRealSize.height + 16;
    
}







@end
