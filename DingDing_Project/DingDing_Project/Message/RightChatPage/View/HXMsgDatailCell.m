//
//  HXMsgDatailCell.m
//  DingDing_Project
//
//  Created by hanxiaoqing on 2016/10/9.
//  Copyright © 2016年 HXQ. All rights reserved.
//

#import "HXMsgDatailCell.h"
#import "HXPrefixHeader.h"
#import "HXButton.h"

#import "NSMutableAttributedString+AttachMent.h"

@interface HXMsgDatailCell ()

@property (weak) IBOutlet NSImageView *iconImageView;

@property (weak) IBOutlet NSTextField *nameLabel;

@property (weak) IBOutlet NSTextField *timeLable;

@property (unsafe_unretained) IBOutlet HXTextView *attTextView;

@property (weak) IBOutlet NSLayoutConstraint *textHeightCons;
@property (weak) IBOutlet NSLayoutConstraint *textWidthCons;

@property (weak) IBOutlet HXButton *popButton;

@end

@implementation HXMsgDatailCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    _timeLable.hidden = YES;
    self.canTrackAction = YES;
    self.attTextView.textContainerInset = NSMakeSize(5.0, 8.0);
    self.attTextView.drawsBackground = NO;
    self.attTextView.borderColor = HXColor(225, 224, 228);
    self.attTextView.textColor = HXColor(70, 70, 70);
    self.attTextView.selectedRange = NSMakeRange(0, 0);
    
    _popButton.trackingEabled = YES;
    _popButton.hidden = YES;
    NSString *imgName = @"cell_popbtn";
    [_popButton setImage:[NSImage imageNamed:imgName] forState:NSControlStateNormal];
    [_popButton setImage:[NSImage imageNamed:[NSString stringWithFormat:@"%@_entered",imgName]] forState:NSControlStateMouseIn];
    
}



- (void)setMessage:(HXMessage *)message {
    _message = message;
    [self.iconImageView sd_setImageWithURL:message.profile_image placeholderImage:nil options:SDWebImageCircledImage];
    self.nameLabel.stringValue = message.name;
    
    // 2014-10-30 18:07:47
    self.timeLable.stringValue = message.create_time;
    
    NSMutableAttributedString *attString = [NSMutableAttributedString parseFaceWordFromString:message.text];
    [attString setLineSpacing:5];
    
    [self.attTextView insertText:attString replacementRange:NSMakeRange(0, 0)];
    self.attTextView.editable = NO;
    CGSize textRealSize = [attString mlineSize];
    CGSize onelineSize = [attString singelineSize];
    if (onelineSize.width < 300) {
        self.textWidthCons.constant = onelineSize.width + 20;
    }
    self.textHeightCons.constant = textRealSize.height + 16;
    
}


- (void)mouseEntered:(NSEvent *)event {
    _popButton.hidden = NO;
    _timeLable.hidden = NO;
}

- (void)mouseExited:(NSEvent *)event {
    _popButton.hidden = YES;
    _timeLable.hidden = YES;
}

- (void)layout {
    [super layout];
}

@end
