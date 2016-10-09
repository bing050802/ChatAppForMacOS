//
//  HXBaseTabelCell.m
//  DingDing_Project
//
//  Created by hanxiaoqing on 2016/10/9.
//  Copyright © 2016年 HXQ. All rights reserved.
//

#import "HXBaseTabelCell.h"

@implementation HXBaseTabelCell

- (NSTableRowView *)rowView {
    return (NSTableRowView *)self.superview;
}

- (void)viewDidMoveToWindow {
    if (self.selectionHighlighted) return;
    self.rowView.selectionHighlightStyle = NSTableViewSelectionHighlightStyleNone;
}

@end
