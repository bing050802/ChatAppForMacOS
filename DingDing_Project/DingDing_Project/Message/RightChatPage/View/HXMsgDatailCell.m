//
//  HXMsgDatailCell.m
//  DingDing_Project
//
//  Created by hanxiaoqing on 2016/10/9.
//  Copyright © 2016年 HXQ. All rights reserved.
//

#import "HXMsgDatailCell.h"
#import "HXPrefixHeader.h"
#import "SWAttributedLabel.h"

@interface HXMsgDatailCell ()

@property (weak) IBOutlet NSImageView *iconImageView;

@property (weak) IBOutlet NSTextField *nameLabel;

@property (weak) IBOutlet NSTextField *timeLable;

@property (weak) IBOutlet NSView *labelBgView;

@property (weak) IBOutlet SWAttributedLabel *attLabel;
@property (weak) IBOutlet NSLayoutConstraint *heightConstriants;

@end

@implementation HXMsgDatailCell

- (void)awakeFromNib {
//    self.selectionHighlighted = YES;
    [self.labelBgView backGroundColor:[NSColor whiteColor]];

}



- (void)setMessage:(HXMessage *)message {
    _message = message;
    [self.iconImageView sd_setImageWithURL:message.profile_image placeholderImage:nil options:SDWebImageCircledImage];
    self.nameLabel.stringValue = message.name;
    
    // 2014-10-30 18:07:47
    self.timeLable.stringValue = [message.create_time substringWithRange:NSMakeRange(message.create_time.length - 5, 5)];
    //self.msgLabel.stringValue = message.text;
    
//    NSLog(@"----%@",NSStringFromRect(self.attLabel.frame));
    
    [self.attLabel setText:message.text];
    CGSize textRealSize = [self.attLabel textRealContantSize];
    self.heightConstriants.constant = textRealSize.height + 10;


}


- (void)layout {
    [super layout];
//    NSLog(@"layout");
    
}

@end
