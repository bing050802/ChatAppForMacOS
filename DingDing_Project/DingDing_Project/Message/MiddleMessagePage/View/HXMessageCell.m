//
//  HXMessageCell.m
//  DingDing_Project
//
//  Created by han on 2016/9/25.
//  Copyright © 2016年 HXQ. All rights reserved.
//

#import "HXMessageCell.h"
#import "HXPrefixHeader.h"

@interface HXMessageCell ()

@property (weak) IBOutlet NSImageView *iconImageView;

@property (weak) IBOutlet NSTextField *nameLabel;
@property (weak) IBOutlet NSTextField *timeLable;
@property (weak) IBOutlet NSTextField *msgLabel;



@end

@implementation HXMessageCell

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
//    [self backGroundColor:[NSColor clearColor]];
//    self.backgroundStyle = NSBackgroundStyleDark;
    
}

- (void)setMessage:(HXMessage *)message {
    _message = message;
    
    if (message.profile_image.length == 0) {
        NSLog(@"%@", message.name);
    }
    
    [self.iconImageView sd_setImageWithURL:message.profile_image placeholderImage:nil options:SDWebImageCircledImage];
    self.nameLabel.stringValue = message.name;
    
    // 2014-10-30 18:07:47
    self.timeLable.stringValue = [message.create_time substringWithRange:NSMakeRange(message.create_time.length - 5, 5)];
    self.msgLabel.stringValue = message.text;
    
}


@end
