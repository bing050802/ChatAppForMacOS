//
//  HXBageView.m
//  DingDing_Project
//
//  Created by hanxiaoqing on 2016/9/28.
//  Copyright © 2016年 HXQ. All rights reserved.
//

#import "HXBageView.h"
#import "MVGraphicsFunctions.h"

@implementation HXBageView

- (void)drawRect:(NSRect)dirtyRect {
//    [super drawRect:dirtyRect];

    // 高亮状态下进行一些 画操作
    NSBezierPath *path = MVRoundedRectBezierPath(dirtyRect, dirtyRect.size.width * 0.5);
    [[NSColor redColor] setFill];
    [path fill];
    
    NSString *str = self.bageValue > 99 ? @"99+" :[NSString stringWithFormat:@"%zd",self.bageValue];
    MVDrawString(str, dirtyRect, [NSColor whiteColor], 9, 0, nil, NSZeroSize, 0);
    
}

- (void)setBageValue:(NSInteger)bageValue {
    _bageValue = bageValue;
    if (bageValue) {
        self.hidden = NO;
        [self setNeedsDisplay:YES];
    } else {
        self.hidden = YES;
    }
}


@end
