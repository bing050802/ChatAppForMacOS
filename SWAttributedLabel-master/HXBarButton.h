//
//  HXBarButton.h
//  DingDing_Project
//
//  Created by hanxiaoqing on 16/8/29.
//  Copyright © 2016年 HXQ. All rights reserved.
//

#import <Cocoa/Cocoa.h>
/**
 * 自定义button 参考资料代码
 http://blog.csdn.net/leonpengweicn/article/details/7750445
 https://github.com/Concpt13/MXButton
 */

typedef NS_OPTIONS(NSUInteger, ButtonState) {
    ButtonStateNormal    = 0,
    ButtonStateHighlighted  ,                  // used when UIControl isHighlighted is set
    ButtonStateDisabled     ,
    ButtonStateSelected     ,
    ButtonStateMouseIn      ,
    UIControlStateFocused  // Applicable only when the screen supports focus
};

@class HXBarButtonCell;

@interface HXBarButton : NSButton

@property (nonatomic,assign) CGFloat cornerRadius;

@property (nonatomic,strong) NSColor *highlightColor;

@property (nonatomic,assign) BOOL selected;

//@property (nonatomic,strong) HXBarButtonCell *cell;

// 是否允许 鼠标tracking trackingEabled = YES 的时候 设置ButtonStateMouseIn/ButtonStateMouseExit 状态下的样式才生效
@property (nonatomic,assign) BOOL trackingEabled;

- (void)setImage:(NSImage *)image forState:(ButtonState)state;
- (void)setBackgroundColor:(NSColor *)backgroundColor forState:(ButtonState)state;
- (void)setTitleColor:(NSColor *)titleColor forState:(ButtonState)state;




@property (nonatomic,assign) NSEdgeInsets titleEdgeInsets; // default is UIEdgeInsetsZero
@property (nonatomic,assign) NSEdgeInsets imageEdgeInsets; // default is UIEdgeInsetsZero


@property (nonatomic,assign) BOOL reversesTitleShadowWhenHighlighted; // default is NO. if YES, shadow reverses to shift between engrave and emboss appearance
@property (nonatomic,assign) BOOL adjustsImageWhenHighlighted;  // default is YES. if YES, image is drawn darker when highlighted(pressed)
@property (nonatomic,assign) BOOL adjustsImageWhenDisabled;
@property (nonatomic,assign) BOOL subpixelAntialiasing;


@end



