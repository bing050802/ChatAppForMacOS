//
//  HXMineMessageCell.m
//  DingDing_Project
//
//  Created by hanxiaoqing on 2016/10/12.
//  Copyright © 2016年 HXQ. All rights reserved.
//

#import "HXMineMessageCell.h"
#import "HXButton.h"
#import "NSMutableAttributedString+AttachMent.h"

@interface HXMineMessageCell ()

@property (weak) IBOutlet NSTextField *timeLabel;
@property (weak) IBOutlet NSImageView *iconImage;


@property (unsafe_unretained) IBOutlet HXTextView *msgTextView;

@property (weak) IBOutlet NSLayoutConstraint *textHeightCons;
@property (weak) IBOutlet NSLayoutConstraint *textWidthCons;

@property (weak) IBOutlet HXButton *popButton;

@end

@implementation HXMineMessageCell


- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.canTrackAction = YES;
    self.msgTextView.textContainerInset = NSMakeSize(5, 8.0);
    self.msgTextView.drawsBackground = NO;
    self.msgTextView.borderColor = [NSColor clearColor];
    self.msgTextView.textViewBgColor = HXSColor(64, 175, 252);
    self.msgTextView.textColor = HXSColor(228, 244, 255);
    self.msgTextView.canEdit = NO;
    
    NSMutableDictionary *atts = [self.msgTextView.linkTextAttributes mutableCopy];
    [atts setObject:HXSColor(200, 231, 252) forKey:@"NSColor"];
    self.msgTextView.linkTextAttributes = atts;
    
    _timeLabel.hidden = YES;
    
    _popButton.trackingEabled = YES;
    _popButton.hidden = YES;
    NSString *imgName = @"cell_popbtn";
    [_popButton setImage:[NSImage imageNamed:imgName] forState:NSControlStateNormal];
    [_popButton setImage:[NSImage imageNamed:[NSString stringWithFormat:@"%@_entered",imgName]] forState:NSControlStateMouseIn];
    
}

- (void)setMessage:(HXMessage *)message {
    _message = message;
    
    [self.iconImage sd_setImageWithURL:message.profile_image placeholderImage:nil options:SDWebImageCircledImage];
    if (!message.profile_image.length) {
        self.iconImage.image = [NSImage circleImageWithColor:HXRandomColor size:self.iconImage.frame.size text:message.name];
    }
    // 2014-10-30 18:07:47
    self.timeLabel.stringValue = message.create_time;
    
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


- (void)mouseEntered:(NSEvent *)event {
    _popButton.hidden = NO;
    _timeLabel.hidden = NO;
}

- (void)mouseExited:(NSEvent *)event {
    _popButton.hidden = YES;
    _timeLabel.hidden = YES;
}




@end
