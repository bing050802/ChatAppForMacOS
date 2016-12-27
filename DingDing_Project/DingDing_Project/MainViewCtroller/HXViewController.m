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

#import "HXMessageSplitController.h"
#import "DINGViewController.h"
#import "HXCallPageController.h"
#import "HXContactPeopleController.h"
#import "HXWorkController.h"
#import "HXDingPanController.h"


@interface HXViewController ()

@property (nonatomic,strong) HXMessageSplitController *messageSplitController;
@property (nonatomic,strong) DINGViewController       *dingVc;
@property (nonatomic,strong) HXCallPageController     *callPageVc;
@property (nonatomic,strong) HXContactPeopleController      *contactVc;
@property (nonatomic,strong) HXWorkController         *workVc;
@property (nonatomic,strong) HXDingPanController      *dingpanVc;


@property (nonatomic,strong) NSViewController  *lastSelectedVc;

@end

@implementation HXViewController

- (HXMessageSplitController *)messageSplitController {
    if (!_messageSplitController) {
        _messageSplitController = [[HXMessageSplitController alloc] init];
        [self addChildViewController:_messageSplitController];
        [_messageSplitController setupChildViewController];
    }
    return _messageSplitController;
}
- (DINGViewController *)dingVc {
    if (!_dingVc) {
        _dingVc = [[DINGViewController alloc] init];
        [self addChildViewController:_dingVc];
    }
    return _dingVc;
}
- (HXCallPageController *)callPageVc {
    if (!_callPageVc) {
        _callPageVc = [[HXCallPageController alloc] init];
        [self addChildViewController:_callPageVc];
    }
    return _callPageVc;
}

- (HXContactPeopleController *)contactVc {
    if (!_contactVc) {
        _contactVc = [[HXContactPeopleController alloc] init];
        [self addChildViewController:_contactVc];
    }
    return _contactVc;
}

- (HXWorkController *)workVc {
    if (!_workVc) {
        _workVc = [[HXWorkController alloc] init];
        [self addChildViewController:_workVc];
    }
    return _workVc;
}

- (HXDingPanController *)dingpanVc {
    if (!_dingpanVc) {
        _dingpanVc = [[HXDingPanController alloc] init];
        [self addChildViewController:_dingpanVc];
    }
    return _dingpanVc;
}




/**
 当从xib加载控制器view的时候，系统会调用这个方法
 在这个方法里面可以进行代码初始化操作，可添加子控件
 */
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
//        NSCollectionView
    }
    return self;
}


/** 当使用纯代码进行 控制器管理view的时候，重写loadView方法 赋值self.view属性 并添加子控件 */
- (void)loadView {
    [super loadView];
    
    // 控制器view默认是右边和底部随父控件拉伸的 NSViewMaxXMargin|NSViewMinYMargin
    // [self.view backGroundColor:[NSColor purpleColor]];
    
    [NotificationCenter addObserver:self selector:@selector(itemSelected:)
                               name:ItemSelectedNotification object:nil];
    
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

- (void)itemSelected:(NSNotification *)noti {
    NSView *btn = noti.object;
//    NSLog(@"itemSelected-- %zd", btn.tag);
    [self.lastSelectedVc removeFromParentViewController];
    [self.lastSelectedVc.view removeFromSuperview];
    if (btn.tag == 4) {
        if ([self.view.subviews containsObject:self.messageSplitController.view]) {
            return;
        }
        [self setUpControllerView:self.messageSplitController.view];
        self.lastSelectedVc = self.messageSplitController;
    }
    if (btn.tag == 3) {
        if ([self.view.subviews containsObject:self.dingVc.view]) {
            return;
        }
        [self setUpControllerView:self.dingVc.view];
        self.lastSelectedVc = self.dingVc;
    }
    if (btn.tag == 2) {
        if ([self.view.subviews containsObject:self.contactVc.view]) {
            return;
        }
        [self setUpControllerView:self.contactVc.view];
        self.lastSelectedVc = self.contactVc;
    }
    if (btn.tag == 1) {
        if ([self.view.subviews containsObject:self.workVc.view]) {
            return;
        }
        [self setUpControllerView:self.workVc.view];
        self.lastSelectedVc = self.workVc;
    }
    if (btn.tag == 0) {
        if ([self.view.subviews containsObject:self.dingpanVc.view]) {
            return;
        }
        [self setUpControllerView:self.dingpanVc.view];
        self.lastSelectedVc = self.dingpanVc;
    }

}




- (void)dealloc {
    [NotificationCenter removeObserver:self];
    NSLog(@"HXViewController--------dealloc");
}


- (void)setUpControllerView:(NSView *)view {
    [self.view addSubview:view];
    [view autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:60];
    [view autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:100];
    [view autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [view autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:0];
}


@end
