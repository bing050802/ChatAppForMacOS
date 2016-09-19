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
#import "NSObject+Property.h"

@interface HXMiddleMessageControlller () <NSTabViewDelegate,NSTableViewDataSource>

@end

@implementation HXMiddleMessageControlller

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view backGroundColor:[NSColor whiteColor]];
    
    
    
    // 解析Plist
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"more_topics.plist" ofType:nil];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    NSArray *dictArr = dict[@"list"];
    
    // 设计模型属性代码
    [NSObject createPropertyCodeWithDict:dictArr[0]];
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
