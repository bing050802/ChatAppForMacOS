//
//  HXTextField.h
//  DingDing_Project
//
//  Created by hanxiaoqing on 16/8/12.
//  Copyright © 2016年 HXQ. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@protocol HXTextFieldDelegate <NSTextFieldDelegate>

@optional
- (void)textFieldBecomeFirstResponder;

@end


@interface HXTextField : NSTextField

@property (nonatomic,weak) id <HXTextFieldDelegate> hx_delagate;

@end
