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
#import "HXBarButton.h"

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
        
        
        
        MXButton *eg1 = [[MXButton alloc] init];
        eg1.image = [NSImage imageNamed:@"message.png"];
        eg1.alternateImage = [NSImage imageNamed:@"message_highlighted.png"];
        eg1.target = self;
        eg1.action = @selector(clickBtn);
        eg1.title = @"消息";
        eg1.frame = NSMakeRect(10, 200, 100, 50);
        eg1.textColor = [NSColor redColor];
//        [self.view addSubview:eg1];

        
        
        
        HXBarButton *eg2 = [[HXBarButton alloc] init];
        eg2.image = [NSImage imageNamed:@"message.png"];
        eg2.target = self;
        eg2.action = @selector(clickBtn:);
        eg2.title = @"DING";
        eg2.frame = NSMakeRect(200, 200, 100, 50);
        eg2.imageEdgeInsets = NSEdgeInsetsMake(0, 10, 0, 100 - 40 - 10);
        eg2.titleEdgeInsets = NSEdgeInsetsMake(0, 50, 0, 0);
        
//        [eg2 setBackgroundColor:[NSColor purpleColor] forState:ButtonStateNormal];
        [eg2 setBackgroundColor:HXColor(192, 221, 246) forState:ButtonStateSelected];
        
        [eg2 setTitleColor:[NSColor grayColor] forState:ButtonStateNormal];
        [eg2 setTitleColor:HXColor(25, 132, 230) forState:ButtonStateSelected];
        
        [eg2 setImage:[NSImage imageNamed:@"message.png"] forState:ButtonStateNormal];
        [eg2 setImage:[NSImage imageNamed:@"message_highlighted.png"] forState:ButtonStateSelected];
        
        
//        eg2.highlightColor = [NSColor yellowColor];
//        eg2.highlightTextColor = [NSColor blackColor];
        [self.view addSubview:eg2];
        
        
        
    }
    return self;
}

- (void)clickBtn:(HXBarButton *)btn {
    NSLog(@"MXButton----click");
    btn.selected = !btn.selected;
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
