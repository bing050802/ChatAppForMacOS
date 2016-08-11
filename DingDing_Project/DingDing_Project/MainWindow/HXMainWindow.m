//
//  HXMainWindow.m
//  DingDing_Project
//
//  Created by hanxiaoqing on 16/8/9.
//  Copyright © 2016年 HXQ. All rights reserved.
//

#import "HXMainWindow.h"
#import "HXTopBarView.h"
#import "HXPrefixHeader.h"
@interface HXMainWindow ()

@property (nonatomic, strong) HXTopBarView *topBar;


@end



@implementation HXMainWindow

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // 支持自定义 窗口顶部控件  隐藏窗口标题
    self.styleMask |= NSFullSizeContentViewWindowMask;
    self.titlebarAppearsTransparent = YES;
    self.titleVisibility = NSWindowTitleHidden;
    
    [self setupTitlebar];
    
}

- (HXTopBarView *)topBar {
    if(!_topBar) {
        _topBar = [[HXTopBarView alloc] init];
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



@end
