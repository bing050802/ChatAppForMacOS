//
//  HXRightChatViewController.m
//  DingDing_Project
//
//  Created by han on 16/9/11.
//  Copyright © 2016年 HXQ. All rights reserved.
//

#import "HXRightChatViewController.h"
#import "NFSplitViewController.h"
#import "HXPrefixHeader.h"


@interface HXRightChatViewController ()

@end

@implementation HXRightChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    [self.view backGroundColor:[NSColor whiteColor]];

}


- (CGFloat)minimumLengthInSplitViewController:(NFSplitViewController*)splitViewController
{
    return 625;
}

@end
