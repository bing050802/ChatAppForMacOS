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
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:message.text];
    [attString setFont:[NSFont systemFontOfSize:14.0]];
    [attString setLineSpacing:5];
    [self.msgTextView insertText:attString replacementRange:NSMakeRange(0, 0)];
    self.msgTextView.editable = NO;
    
//      NSLog(@"-----textContantSize-- %@",NSStringFromSize() );
//    [attString realitySizeForWidth:310 numberOfLines:0]
    
    CGSize textRealSize = self.msgTextView.enclosingScrollView.contentSize;
    CGFloat onelineWidth = [attString oneLineRealityWidth];
    if (onelineWidth <= 310.0) {
        self.textWidthCons.constant = textRealSize.width + 20;
    }
    self.textHeightCons.constant = textRealSize.height + 20;
    
    
}







@end
