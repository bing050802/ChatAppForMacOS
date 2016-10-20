//
//  CWindow.m
//  SWAttributedLabel
//
//  Created by hanxiaoqing on 2016/10/17.
//  Copyright © 2016年 mxc235. All rights reserved.
//

#import "CWindow.h"

@implementation CWindow

- (void)keyDown:(NSEvent *)event {

//    NSLog(@"---%s",__func__);
    [super keyDown:event];
   
}

- (void)mouseDown:(NSEvent *)event {
    NSTextView *textView = (NSTextView *)self.firstResponder;
//    [textView ]
//    [self.firstResponder refusesFirstResponder]
//    NSLog(@"%@",self.firstResponder);
//    [self becomeFirstResponder];
}


@end
