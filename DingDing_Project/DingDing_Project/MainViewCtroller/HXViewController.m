//
//  HXViewController.m
//  DingDing_Project
//
//  Created by hanxiaoqing on 16/8/29.
//  Copyright © 2016年 HXQ. All rights reserved.
//

#import "HXViewController.h"
#import "HXPrefixHeader.h"
#import "MXButton.h"

@interface HXViewController ()

@end

@implementation HXViewController

/**
 当从xib加载控制器view的时候，系统会调用这个方法
 在这个方法里面可以进行代码初始化操作，可添加子控件
 */
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // 控制器view默认是右边和底部随父控件拉伸的 NSViewMaxXMargin|NSViewMinYMargin
        
        // [self.view backGroundColor:[NSColor purpleColor]];
        
        // 测试添加自子控件
        NSView *view = [[NSView alloc] initWithFrame:NSMakeRect(10, 200, 200, 200)];
        [view backGroundColor:[NSColor redColor]];
        // [self.view addSubview:view];
        
        
        
        MXButton *eg1 = [[MXButton alloc] initWithHighlightColor:[NSColor colorWithCalibratedRed:0.0 green:0.9 blue:0.9 alpha:0.7]];
        eg1.image = [NSImage imageNamed:@"message.png"];
        eg1.alternateImage = [NSImage imageNamed:@"message_highlighted.png"];
        //        eg1.backgroundColor = [NSColor colorWithCalibratedRed:0.0 green:0.5 blue:1.0 alpha:0.7];
        eg1.textColor = [NSColor colorWithWhite:1.0 alpha:0.7];
        eg1.title = @"";
        eg1.frame = view.frame;
        
        [self.view addSubview:eg1];
        
    }
    return self;
}

- (void)clickBtn {
    //    NSLog(@"%@",_cView.subviews);
}


- (IBAction)clickBtn:(NSButton *)sender {
    
}



/** 当使用纯代码进行 控制器管理view的时候，重写loadView方法 赋值self.view属性 并添加子控件
 - (void)loadView
 {
 
 }
 */

- (void)dealloc {
    NSLog(@"HXViewController--------dealloc");
}

@end
