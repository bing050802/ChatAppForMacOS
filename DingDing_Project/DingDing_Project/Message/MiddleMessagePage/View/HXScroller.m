//
//  HXScroller.m
//  DingDing_Project
//
//  Created by hanxiaoqing on 2016/9/28.
//  Copyright © 2016年 HXQ. All rights reserved.
//

#import "HXScroller.h"
#import "HXPrefixHeader.h"

@implementation HXScroller

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
}

+ (CGFloat)scrollerWidthForControlSize:(NSControlSize)controlSize scrollerStyle:(NSScrollerStyle)scrollerStyle {
    return 8;
}

- (void)awakeFromNib
{
    self.knobStyle = NSScrollerKnobStyleDark;
}

@end
