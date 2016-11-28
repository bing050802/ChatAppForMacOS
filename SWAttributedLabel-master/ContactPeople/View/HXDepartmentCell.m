//
//  HXDepartmentCell.m
//  SWAttributedLabel
//
//  Created by hanxiaoqing on 2016/11/28.
//  Copyright © 2016年 mxc235. All rights reserved.
//

#import "HXDepartmentCell.h"

@interface HXDepartmentCell ()

@property (weak) IBOutlet NSTextField *nameLabel;
@property (weak) IBOutlet NSTextField *numberLabel;


@end

@implementation HXDepartmentCell


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


@end
