//
//  BottomView.m
//  NSImage相关的处理
//
//  Created by hanxiaoqing on 2016/10/9.
//  Copyright © 2016年 Babeltime. All rights reserved.
//

#import "BottomView.h"

@implementation BottomView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

//
//- (BOOL)performKeyEquivalent:(NSEvent *)event {
//    return NO;
//}

- (void)mouseDown:(NSEvent *)event {
    
    if ([[self window] firstResponder] == self) {
        
    }
    
    
    NSLog(@"%@---%s",self.class,__func__);
    
}



@end
