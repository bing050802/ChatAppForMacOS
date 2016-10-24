//
//  HXMineMessageCell.h
//  DingDing_Project
//
//  Created by hanxiaoqing on 2016/10/12.
//  Copyright © 2016年 HXQ. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "HXBaseTabelCell.h"
#import "HXMessage.h"

#import "HXPrefixHeader.h"

#import "SWAttributedLabel.h"
#import "HXTextView.h"

#import "NSImage+StackBlur.h"

@interface HXMineMessageCell : HXBaseTabelCell

@property (nonatomic,strong) HXMessage *message;

@end
