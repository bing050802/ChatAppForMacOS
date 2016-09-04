//
//  HXViewController.m
//  DingDing_Project
//
//  Created by hanxiaoqing on 16/8/29.
//  Copyright © 2016年 HXQ. All rights reserved.
//

#import "HXViewController.h"
#import "HXPrefixHeader.h"
#import "HXBarButton.h"
#import "HXSelectBar.h"

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
        HXSelectBar *sBar = [[HXSelectBar alloc] initWithFrame:NSMakeRect(10, 200, 200, 200)];
        [sBar backGroundColor:[NSColor cyanColor]];
        [self.view addSubview:sBar];
//        [sBar autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
        [sBar autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:0];
        [sBar autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
        [sBar autoSetDimension:ALDimensionWidth toSize:100];
        [sBar autoSetDimension:ALDimensionHeight toSize:200];

        
        
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
