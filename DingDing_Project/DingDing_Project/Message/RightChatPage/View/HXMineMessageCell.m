//
//  HXMineMessageCell.m
//  DingDing_Project
//
//  Created by hanxiaoqing on 2016/10/12.
//  Copyright © 2016年 HXQ. All rights reserved.
//

#import "HXMineMessageCell.h"
#import "NSMutableAttributedString+AttachMent.h"

@interface HXMineMessageCell ()

@property (weak) IBOutlet NSTextField *timeLabel;
@property (weak) IBOutlet NSImageView *iconImage;


@property (unsafe_unretained) IBOutlet HXTextView *msgTextView;

@property (weak) IBOutlet NSLayoutConstraint *textHeightCons;
@property (weak) IBOutlet NSLayoutConstraint *textWidthCons;

@end

@implementation HXMineMessageCell


- (void)awakeFromNib {
    self.msgTextView.textContainerInset = NSMakeSize(5, 8.0);
    self.msgTextView.drawsBackground = NO;
    self.msgTextView.borderColor = [NSColor clearColor];
    self.msgTextView.textViewBgColor = HXSColor(64, 175, 252);
    self.msgTextView.textColor = HXSColor(228, 244, 255);
    self.msgTextView.canEdit  = NO;
}

- (void)setMessage:(HXMessage *)message {
    _message = message;
    
    [self.iconImage sd_setImageWithURL:message.profile_image placeholderImage:nil options:SDWebImageCircledImage];
    if (!message.profile_image.length) {
        self.iconImage.image = [NSImage circleImageWithColor:HXRandomColor size:self.iconImage.frame.size text:message.name];
    }
    // 2014-10-30 18:07:47
    self.timeLabel.stringValue = message.create_time ;
    
    NSMutableAttributedString *attString = [NSMutableAttributedString parseFaceWordFromString:message.text];
    [attString setLineSpacing:5];
    
    [self.msgTextView insertText:attString replacementRange:NSMakeRange(0, 0)];
    self.msgTextView.editable = NO;

    CGSize textRealSize = [attString mlineSize];
    CGSize onelineSize = [attString singelineSize];
    if (onelineSize.width < 300) {
        self.textWidthCons.constant = onelineSize.width + 20;
    }
    self.textHeightCons.constant = textRealSize.height + 16;
    
}







@end
