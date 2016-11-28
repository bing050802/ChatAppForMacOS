//
//  HXDepartmentCell.m
//  SWAttributedLabel
//
//  Created by hanxiaoqing on 2016/11/28.
//  Copyright © 2016年 mxc235. All rights reserved.
//

#import "HXDepartmentCell.h"
#import "HXPrefixHeader.h"

@interface HXDepartmentCell ()

@property (weak) IBOutlet NSTextField *nameLabel;
@property (weak) IBOutlet NSTextField *numberLabel;


@end

@implementation HXDepartmentCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.canTrackAction = YES;
}


- (void)setDepartName:(NSString *)departName
{
    _departName = [departName copy];
    _nameLabel.stringValue = departName;
}

- (void)setDepartCount:(NSString *)departCount
{
    _departCount = [departCount copy];
    _numberLabel.stringValue = departCount;
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
