//
//  HXMiddleMessageControlller.m
//  DingDing_Project
//
//  Created by han on 16/9/11.
//  Copyright © 2016年 HXQ. All rights reserved.
//

#import "HXMiddleMessageControlller.h"
#import "NFSplitViewController.h"
#import "HXPrefixHeader.h"

@interface HXMiddleMessageControlller ()

@end

@implementation HXMiddleMessageControlller

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view backGroundColor:[NSColor whiteColor]];
}



- (CGFloat)minimumLengthInSplitViewController:(NFSplitViewController*)splitViewController
{
    return 210;
}

- (CGFloat)maximumLengthInSplitViewController:(NFSplitViewController *)splitViewController
{
    return 275;
}

@end
