//
//  NSView+BackGroundColor.m
//  DingDing_Project
//
//  Created by hanxiaoqing on 16/8/9.
//  Copyright © 2016年 HXQ. All rights reserved.
//

#import "NSView+BackGroundColor.h"

@implementation NSView (BackGroundColor)

- (void)backGroundColor:(NSColor *)color {
    self.wantsLayer = YES;
    self.layer.backgroundColor = color.CGColor;
}


@end
