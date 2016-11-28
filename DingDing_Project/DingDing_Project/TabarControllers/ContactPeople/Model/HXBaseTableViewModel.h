//
//  HXBaseTableViewModel.h
//  SWAttributedLabel
//
//  Created by hanxiaoqing on 2016/11/28.
//  Copyright © 2016年 mxc235. All rights reserved.
//

#import <AppKit/AppKit.h>

@interface HXBaseTableViewModel : NSObject <NSTableViewDataSource,NSTableViewDelegate>

+ (instancetype)viewModelWithTableView:(NSTableView *)tableView;

//  刷新数据
- (void)relaodDataWithModel:(id)model;


@end
