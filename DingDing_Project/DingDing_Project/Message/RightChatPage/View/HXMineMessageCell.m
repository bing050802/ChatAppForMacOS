//
//  HXMineMessageCell.m
//  DingDing_Project
//
//  Created by hanxiaoqing on 2016/10/12.
//  Copyright © 2016年 HXQ. All rights reserved.
//

#import "HXMineMessageCell.h"


@interface HXMineMessageCell ()

@property (weak) IBOutlet NSTextField *timeLabel;
@property (weak) IBOutlet NSImageView *iconImage;


@property (unsafe_unretained) IBOutlet HXTextView *msgTextView;

@property (weak) IBOutlet NSLayoutConstraint *textHeightCons;
@property (weak) IBOutlet NSLayoutConstraint *textWidthCons;

@end

@implementation HXMineMessageCell


- (void)awakeFromNib {
    
    self.msgTextView.textContainerInset = NSMakeSize(5, 10.0);
    self.msgTextView.drawsBackground = NO;
    self.msgTextView.borderColor = HXColor(225, 224, 228);
    self.msgTextView.font = [NSFont systemFontOfSize:14.0];
    self.msgTextView.textColor = HXColor(70, 70, 70);
    
}

- (void)setMessage:(HXMessage *)message {
    _message = message;
    
    
    [self.iconImage sd_setImageWithURL:message.profile_image placeholderImage:nil options:SDWebImageCircledImage];
    if (!message.profile_image.length) {
        self.iconImage.image = [NSImage circleImageWithColor:HXRandomColor size:self.iconImage.frame.size text:message.name];
    }
    // 2014-10-30 18:07:47
    self.timeLabel.stringValue = [message.create_time substringWithRange:NSMakeRange(message.create_time.length - 5, 5)];
    
    
    
}







@end
