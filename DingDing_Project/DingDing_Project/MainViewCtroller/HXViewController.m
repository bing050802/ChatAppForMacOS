//
//  HXViewController.m
//  DingDing_Project
//
//  Created by hanxiaoqing on 16/8/29.
//  Copyright © 2016年 HXQ. All rights reserved.
//

#import "HXViewController.h"
#import "HXPrefixHeader.h"
#import "HXLeftToolBar.h"

@interface HXViewController ()

@end

@implementation HXViewController

/**
 NFSplitViewController :
 
 NSView* contentView = self.window.contentView;
 
 self.splitViewController = [[NFSplitViewController alloc] init];
 self.splitViewController.view.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
 self.splitViewController.view.frame = contentView.bounds;
 //    self.splitViewController.vertical = NO;
 [contentView addSubview:self.splitViewController.view];
 
 TestViewController *leftVc = [[TestViewController alloc] init];
 leftVc.backgroundColor = [NSColor whiteColor];
 leftVc.name = @"Master";
 
 TestViewController* rightVc = [[TestViewController alloc] init];
 rightVc.backgroundColor = [NSColor whiteColor];
 rightVc.name = @"Detail right";
 
 [self.splitViewController addChildViewController:leftVc];
 [self.splitViewController addChildViewController:rightVc];
 
 
 TestViewController :
 
 - (CGFloat)minimumLengthInSplitViewController:(NFSplitViewController*)splitViewController
 {
 return 214;
 }
 
 - (CGFloat)maximumLengthInSplitViewController:(NFSplitViewController *)splitViewController
 {
 return 393;
 }
 
 

 */

/**
 当从xib加载控制器view的时候，系统会调用这个方法
 在这个方法里面可以进行代码初始化操作，可添加子控件
 */
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // 控制器view默认是右边和底部随父控件拉伸的 NSViewMaxXMargin|NSViewMinYMargin
        // [self.view backGroundColor:[NSColor purpleColor]];

        // 添加左边工具栏 view
        HXLeftToolBar *leftBar = [HXLeftToolBar loadXibLeftToolBar];
        leftBar.userName = @"韩小青";
        [leftBar backGroundColor:HXColor(221, 228, 242)];
        [self.view addSubview:leftBar];
        [leftBar autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:60];
        [leftBar autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:0];
        [leftBar autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
        [leftBar autoSetDimension:ALDimensionWidth toSize:100];
        
        
        
    }
    return self;
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
