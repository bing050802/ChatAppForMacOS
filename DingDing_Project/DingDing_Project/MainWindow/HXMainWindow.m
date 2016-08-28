//
//  HXMainWindow.m
//  DingDing_Project
//
//  Created by hanxiaoqing on 16/8/9.
//  Copyright © 2016年 HXQ. All rights reserved.
//

#import "HXMainWindow.h"
#import "HXWindowTopBarView.h"
#import "HXPrefixHeader.h"
#import "HXViewController.h"

@interface HXMainWindow ()

@property (nonatomic, strong) HXWindowTopBarView *topBar;

@end



@implementation HXMainWindow

- (instancetype)initWithContentRect:(NSRect)contentRect styleMask:(NSUInteger)aStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag {
    self = [super initWithContentRect:contentRect styleMask:aStyle backing:bufferingType defer:flag];
    if (self) {
        self.contentMinSize = NSMakeSize(960, 602);
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // 为了防止 window 从storyboard加载的时候尺寸是最初设定的，需要再设定一次最小的尺寸
    [self setContentSize:NSMakeSize(960, 602)];
    
    // 让window 居中
    [self center];
    
    // 支持自定义 窗口顶部控件  隐藏窗口标题
    self.styleMask |= NSFullSizeContentViewWindowMask;
    self.titlebarAppearsTransparent = YES;
    self.titleVisibility = NSWindowTitleHidden;

    
    // 兼容10.10以下的系统 window默认的controller不从storyboard加载
    // 使用新建控制器的view赋值 contentView属性
    // 注：当window未设定contentView  contentViewController属性时候，为空（系统不会默认创建）
    HXViewController  *vc = [[HXViewController alloc] init];
    self.contentView = vc.view;
    
    [self setupTitlebar];

}

- (HXWindowTopBarView *)topBar {
    if(!_topBar) {
        _topBar = [[HXWindowTopBarView alloc] init];
        [_topBar backGroundColor:HXColor(0, 114, 237)];
    }
    return _topBar;
}

- (void)setupTitlebar {
    [self.contentView addSubview:self.topBar];
    [self.topBar autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [self.topBar autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:0];
    [self.topBar autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:0];
    [self.topBar autoSetDimension:ALDimensionHeight toSize:60];
}



//- (void)mouseMoved:(NSEvent *)theEvent {
//    NSLog(@"%s",__func__);
//}

//- (void) center {
//    NSRect mr = [NSApplication sharedApplication].mainWindow.frame;
//    NSPoint mp = NSMakePoint(NSMidX(mr), NSMidY(mr));
//    
//    NSRect r = self.frame;
//    NSPoint wo = NSMakePoint(mp.x - (r.size.width/2.0f),mp.y - (r.size.height/2.0f));
//    r.origin = wo;
//    [self setFrameOrigin:wo];
//}



@end
