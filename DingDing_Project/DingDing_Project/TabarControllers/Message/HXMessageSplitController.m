//
//  HXMessageSplitController.m
//  DingDing_Project
//
//  Created by han on 16/9/11.
//  Copyright © 2016年 HXQ. All rights reserved.
//

#import "HXMessageSplitController.h"

@interface HXMessageSplitController ()

@end

@implementation HXMessageSplitController


- (void)setupChildViewController {
    HXMiddleMessageControlller *middleMsgVc = [[HXMiddleMessageControlller alloc] init];
    HXRightChatViewController  *rightChatVc = [[HXRightChatViewController alloc] init];
    [self addChildViewController:middleMsgVc];
    [self addChildViewController:rightChatVc];
}



@end
