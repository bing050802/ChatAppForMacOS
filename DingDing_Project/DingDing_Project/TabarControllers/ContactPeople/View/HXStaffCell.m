//
//  HXStaffCell.m
//  SWAttributedLabel
//
//  Created by hanxiaoqing on 2016/11/28.
//  Copyright © 2016年 mxc235. All rights reserved.
//

#import "HXStaffCell.h"
#import "NSImage+StackBlur.h"
#import "HXPrefixHeader.h"

@interface HXStaffCell ()

@property (weak) IBOutlet NSImageView *iconImageView;
@property (weak) IBOutlet NSTextField *nameLabel;


@end

@implementation HXStaffCell


- (void)setPeopleName:(NSString *)peopleName
{
    _peopleName = [peopleName copy];
    self.iconImageView.image = [NSImage circleImageWithColor:HXRandomColor size:self.iconImageView.frame.size text:peopleName];
    self.nameLabel.stringValue = peopleName;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    self.canTrackAction = YES;
}

- (void)mouseEntered:(NSEvent *)theEvent
{
    [self backGroundColor:HXColor(215, 232, 249)];
}

- (void)mouseExited:(NSEvent *)theEvent
{
    [self backGroundColor:[NSColor clearColor]];
}


@end
