//
//  HXTextField.m
//  DingDing_Project
//
//  Created by hanxiaoqing on 16/8/12.
//  Copyright © 2016年 HXQ. All rights reserved.
//

#import "HXTextField.h"

@implementation HXTextField

- (BOOL)becomeFirstResponder {
    if([self.hx_delagate respondsToSelector:@selector(textFieldBecomeFirstResponder)]) {
        [self.hx_delagate textFieldBecomeFirstResponder];
    }
    return [super becomeFirstResponder];
}

- (void)setHx_delagate:(id<HXTextFieldDelegate>)hx_delagate {
    _hx_delagate = hx_delagate;
    self.delegate = hx_delagate;
}

@end
