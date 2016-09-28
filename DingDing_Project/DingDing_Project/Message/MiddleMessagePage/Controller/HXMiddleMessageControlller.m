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
#import <CoreGraphics/CoreGraphics.h>
#import "HXMessageCell.h"


@interface HXMiddleMessageControlller () <NSTableViewDelegate,NSTableViewDataSource>

@property (weak) IBOutlet NSTableView *msgTableView;
@property (nonatomic,strong) NSMutableArray *msgArray;


@end

@implementation HXMiddleMessageControlller

- (void)loadView {
    [super loadView];
    
    self.msgTableView.headerView = nil;
    [self.msgTableView registerNib:[[NSNib alloc] initWithNibNamed:NSStringFromClass([HXMessageCell class]) bundle:nil]  forIdentifier:@"msgCell"];
    [self.msgTableView reloadData];
    
    
//    NSLog(@"%@",self.msgTableView.superview.superview.subviews);
}


- (NSMutableArray *)msgArray  {
    if (!_msgArray) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"more_topics.plist" ofType:nil];
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
        _msgArray = [HXMessage mj_objectArrayWithKeyValuesArray:dict[@"list"]];
    }
    return _msgArray;
}

- (nullable NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(nullable NSTableColumn *)tableColumn row:(NSInteger)row {
    
    HXMessageCell *cell = [tableView makeViewWithIdentifier:@"msgCell" owner:self];
    cell.message = self.msgArray[row];
    return cell;
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
    return 50;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return self.msgArray.count;
}


- (CGFloat)minimumLengthInSplitViewController:(NFSplitViewController*)splitViewController {
    return 210;
}

- (CGFloat)maximumLengthInSplitViewController:(NFSplitViewController *)splitViewController {
    return 275;
}

- (void)test {
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [manager GET:@"https://github.com/rs" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//
//    }];
}

@end
