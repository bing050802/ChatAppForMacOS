//
//  NSTableView+Selection.h
//  SWAttributedLabel
//
//  Created by hanxiaoqing on 2016/11/24.
//  Copyright © 2016年 mxc235. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSTableView (Selection)

- (NSArray *)selectedCellViews;

- (NSTableRowView *)selectedRowView;


@end
