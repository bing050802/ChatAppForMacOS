//
//  HXSearchField.h
//  DingDing_Project
//
//  Created by hanxiaoqing on 16/8/11.
//  Copyright © 2016年 HXQ. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface HXSearchField : NSView

// 占位文字
@property (nonatomic, copy) NSString *placeHolderString;

// 搜索框 退出编辑状态 （外部调用）
- (void)resignFocus;

// 外部设置的宽度约束
@property (nonatomic, strong) NSLayoutConstraint *widthConstrinat;

// 外部设置的右间距约束
@property (nonatomic, strong) NSLayoutConstraint *rightConstrinat;

@end



typedef void(^clearInput)();

@interface NOHighlightBtn : NSButton

// 正常状态下的image
@property (nonatomic, strong) NSImage *normalImage;
// 鼠标扫中状态下的image
@property (nonatomic, strong) NSImage *mouseinImage;
// 设置是否鼠标扫中状态（yes显示mouseinImage no显示normalImage）
@property (nonatomic, assign) BOOL mouseinState;

@end


@interface HXSearchToolBar : NSView

// 放大镜查找按钮
@property (nonatomic, strong) NOHighlightBtn *seekBtn;
// 清除输入的按钮
@property (nonatomic, strong) NOHighlightBtn *clearBtn;
// 清除输入按钮点击调用的block
@property (nonatomic, copy)   clearInput clearInputBlock;

@end


