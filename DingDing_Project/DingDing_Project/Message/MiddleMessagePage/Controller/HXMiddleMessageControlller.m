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

@interface HXMiddleMessageControlller () <NSTabViewDelegate,NSTableViewDataSource>

@end

@implementation HXMiddleMessageControlller

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view backGroundColor:[NSColor whiteColor]];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return 2;
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
