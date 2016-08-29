//
//  HXViewController.m
//  DingDing_Project
//
//  Created by han on 16/8/28.
//  Copyright © 2016年 HXQ. All rights reserved.
//


#import "HXViewController.h"
#import "HXPrefixHeader.h"
@interface HXViewController ()

@property (weak) IBOutlet NSButton *btn;

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
        
        
//        [self.view backGroundColor:[NSColor purpleColor]];
        
        NSView *view = [[NSView alloc] initWithFrame:NSMakeRect(10, 200, 200, 200)];
        [view backGroundColor:[NSColor redColor]];
//        [self.view addSubview:view];
        
//        NSLog(@"%zd--%zd",self.view.autoresizingMask,);
    }
    return self;
}



/** 当使用纯代码进行 控制器管理view的时候，重写loadView方法 赋值self.view属性 并添加子控件
- (void)loadView
{
 
}
 
*/

@end
