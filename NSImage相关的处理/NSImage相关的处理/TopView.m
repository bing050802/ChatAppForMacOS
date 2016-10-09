//
//  TopView.m
//  NSImage相关的处理
//
//  Created by hanxiaoqing on 2016/10/9.
//  Copyright © 2016年 Babeltime. All rights reserved.
//

#import "TopView.h"

@implementation TopView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

- (void)mouseDown:(NSEvent *)event {
    NSLog(@"%@---%s",self.class,__func__);
//    [self.nextResponder mouseDown:event];
    
    
    if ([[self window] firstResponder] == self) {
        // do something based upon first-responder status
    }
    
}

@end
