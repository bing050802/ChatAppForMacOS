//
//  NSTableView+Selection.m
//  SWAttributedLabel
//
//  Created by hanxiaoqing on 2016/11/24.
//  Copyright © 2016年 mxc235. All rights reserved.
//

#import "NSTableView+Selection.h"

@implementation NSTableView (Selection)

- (NSArray *)selectedCellViews {
    NSTableRowView *rowView = [self selectedRowView];
    return rowView.subviews;
}
- (NSTableRowView *)selectedRowView {
    NSInteger selectIndex = self.selectedRow;
    NSTableRowView *rowView = [self rowViewAtRow:selectIndex makeIfNecessary:YES];
    return rowView;
}


@end

