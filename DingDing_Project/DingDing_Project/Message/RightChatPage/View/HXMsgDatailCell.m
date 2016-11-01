//
//  HXMsgDatailCell.m
//  DingDing_Project
//
//  Created by hanxiaoqing on 2016/10/9.
//  Copyright © 2016年 HXQ. All rights reserved.
//

#import "HXMsgDatailCell.h"
#import "HXPrefixHeader.h"

#import "NSMutableAttributedString+AttachMent.h"

@interface HXMsgDatailCell ()

@property (weak) IBOutlet NSImageView *iconImageView;

@property (weak) IBOutlet NSTextField *nameLabel;

@property (weak) IBOutlet NSTextField *timeLable;

@property (unsafe_unretained) IBOutlet HXTextView *attTextView;

@property (weak) IBOutlet NSLayoutConstraint *textHeightCons;
@property (weak) IBOutlet NSLayoutConstraint *textWidthCons;

@end

@implementation HXMsgDatailCell

- (void)awakeFromNib {
    self.attTextView.textContainerInset = NSMakeSize(5.0, 8.0);
    self.attTextView.drawsBackground = NO;
    self.attTextView.borderColor = HXColor(225, 224, 228);
    self.attTextView.textColor = HXColor(70, 70, 70);
    self.attTextView.canEdit = NO;
}



- (void)setMessage:(HXMessage *)message {
    _message = message;
    [self.iconImageView sd_setImageWithURL:message.profile_image placeholderImage:nil options:SDWebImageCircledImage];
    self.nameLabel.stringValue = message.name;
    
    // 2014-10-30 18:07:47
    self.timeLable.stringValue = [message.create_time substringWithRange:NSMakeRange(message.create_time.length - 5, 5)];
    
    NSMutableAttributedString *attString = [NSMutableAttributedString parseFaceWordFromString:message.text];
    [attString setLineSpacing:5];
    
    [self.attTextView insertText:attString replacementRange:NSMakeRange(0, 0)];
    CGSize textRealSize = [attString mlineSize];
    CGSize onelineSize = [attString singelineSize];
    if (onelineSize.width < 300) {
        self.textWidthCons.constant = onelineSize.width + 20;
    }
    self.textHeightCons.constant = textRealSize.height + 16;
    
}


- (void)layout {
    [super layout];
}

@end
