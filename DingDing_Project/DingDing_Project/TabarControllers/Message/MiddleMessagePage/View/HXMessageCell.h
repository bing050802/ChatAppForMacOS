//
//  HXMessageCell.h
//  DingDing_Project
//
//  Created by han on 2016/9/25.
//  Copyright © 2016年 HXQ. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "HXMessage.h"
#import "HXBaseTabelCell.h"
static NSString *const cellDeleteNotification = @"cellDeleteNotification";

@interface HXMessageCell : HXBaseTabelCell

@property (nonatomic,strong) HXMessage *message;

@end
