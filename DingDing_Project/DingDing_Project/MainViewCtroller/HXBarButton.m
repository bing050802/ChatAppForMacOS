//
//  HXBarButton.m
//  DingDing_Project
//
//  Created by hanxiaoqing on 16/8/29.
//  Copyright © 2016年 HXQ. All rights reserved.
//

#import "HXBarButton.h"
#import "MVGraphicsFunctions.h"

@interface HXBarButtonCell : NSButtonCell

@property (nonatomic,assign) CGFloat cornerRadius;

@property (nonatomic,strong) NSColor *highlightColor;

@property (nonatomic,strong) NSColor *textColor;
@property (nonatomic,strong) NSColor *highlightTextColor;

@property (nonatomic,assign) NSEdgeInsets titleEdgeInsets; // default is UIEdgeInsetsZero
@property (nonatomic,assign) NSEdgeInsets imageEdgeInsets; // default is UIEdgeInsetsZero

@property (nonatomic,assign) BOOL reversesTitleShadowWhenHighlighted; // default is NO. if YES, shadow reverses to shift between engrave and emboss appearance

@property (nonatomic,assign) BOOL adjustsImageWhenHighlighted;  // default is YES. if YES, image is drawn darker when highlighted(pressed)
@property (nonatomic,assign) BOOL adjustsImageWhenDisabled;

@property (nonatomic,assign) BOOL subpixelAntialiasing;

@end


@interface HXBarButton ()

@property (nonatomic,strong) HXBarButtonCell *cell;

@property (nonatomic,strong) NSMutableDictionary *stateImageDic;
@property (nonatomic,strong) NSMutableDictionary *stateBackGroundDic;
@property (nonatomic,strong) NSMutableDictionary *stateTitleColorDic;

@end


@implementation HXBarButton
@dynamic cell;

#pragma mark Cell passthroughs------------------------------------------------------------------begin

- (CGFloat)cornerRadius {
    return self.cell.cornerRadius;
}
- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
}




- (NSColor *)highlightColor {
    return self.cell.highlightColor;
}
- (void)setHighlightColor:(NSColor *)highlightColor {
    self.cell.highlightColor = highlightColor;
}

- (NSColor *)highlightTextColor {
    return self.cell.highlightTextColor;
}
- (void)setHighlightTextColor:(NSColor *)textColor {
    self.cell.highlightTextColor = textColor;
}

- (NSEdgeInsets)titleEdgeInsets {
    return self.cell.titleEdgeInsets;
}
- (void)setTitleEdgeInsets:(NSEdgeInsets)titleEdgeInsets {
    self.cell.titleEdgeInsets = titleEdgeInsets;
}

- (NSEdgeInsets)imageEdgeInsets {
    return self.cell.imageEdgeInsets;
}
- (void)setImageEdgeInsets:(NSEdgeInsets)imageEdgeInsets {
    self.cell.imageEdgeInsets = imageEdgeInsets;
}
#pragma mark Cell passthroughs-------------------------------------------------------------------end

- (NSMutableDictionary *)stateImageDic {
    if (!_stateImageDic) {
        _stateImageDic = [NSMutableDictionary dictionary];
    }
    return _stateImageDic;
}
- (NSMutableDictionary *)stateBackGroundDic {
    if (!_stateBackGroundDic) {
        _stateBackGroundDic = [NSMutableDictionary dictionary];
    }
    return _stateBackGroundDic;
}

- (NSMutableDictionary *)stateTitleColorDic {
    if (!_stateTitleColorDic) {
        _stateTitleColorDic = [NSMutableDictionary dictionary];
    }
    return _stateTitleColorDic;
}

// 返回自定义的 ButtonCell class
+ (Class)cellClass {
    return [HXBarButtonCell class];
}

- (void)drawRect:(NSRect)dirtyRect {
    // Get the graphics context.
    CGContextRef context = [[NSGraphicsContext currentContext] CGContext];
    
    // Save the graphics context state.
    CGContextSaveGState(context);
    
    // Set up font rasterization so that subpixel antialiasing is used.
    CGContextSetShouldSmoothFonts(context, self.subpixelAntialiasing);
    CGContextSetShouldSubpixelPositionFonts(context, self.subpixelAntialiasing);
    CGContextSetShouldSubpixelQuantizeFonts(context, self.subpixelAntialiasing);
    
    // Draw the button.
    [super drawRect:dirtyRect];
    // Restore the graphics context state.
    CGContextRestoreGState(context);
}

- (instancetype)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.font = [NSFont systemFontOfSize:13];
        self.subpixelAntialiasing = YES;
        self.wantsLayer = YES;
    }
    return self;
}

- (void)setImage:(NSImage *)image forState:(ButtonState)state {
    if (state == ButtonStateNormal) {
        self.image = image;
    }
    [self.stateImageDic setObject:image forKey:@(state)];
}
- (void)setBackgroundColor:(NSColor *)backgroundColor forState:(ButtonState)state {
    if (state == ButtonStateNormal) {
        self.cell.backgroundColor = backgroundColor;
    }
    [self.stateBackGroundDic setObject:backgroundColor forKey:@(state)];
}
- (void)setTitleColor:(NSColor *)titleColor forState:(ButtonState)state {
    if (state == ButtonStateNormal) {
        self.cell.textColor = titleColor;
    }
     [self.stateTitleColorDic setObject:titleColor forKey:@(state)];
}

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    if (selected) {
        self.image = self.stateImageDic[@(ButtonStateSelected)];
        self.cell.backgroundColor = self.stateBackGroundDic[@(ButtonStateSelected)];
        self.cell.textColor = self.stateTitleColorDic[@(ButtonStateSelected)];
    } else {
        self.image = self.stateImageDic[@(ButtonStateNormal)];
        self.cell.backgroundColor = self.stateBackGroundDic[@(ButtonStateNormal)];
        self.cell.textColor = self.stateTitleColorDic[@(ButtonStateNormal)];
    }
}

@end



@implementation HXBarButtonCell


/**  鼠标高亮点击时候会调用 */
- (void)highlight:(BOOL)flag withFrame:(NSRect)cellFrame inView:(NSView *)controlView {
    if (flag) {
        // 高亮状态下进行一些 画操作
        MVRoundedRectBezierPath(cellFrame, 5);
    }
    [super highlight:flag withFrame:cellFrame inView:controlView];
}


- (void)drawInteriorWithFrame:(NSRect)cellFrame inView:(NSView *)controlView {
    [super drawInteriorWithFrame:cellFrame inView:controlView];
}

// 画边框
- (void)drawBezelWithFrame:(NSRect)frame inView:(NSView *)controlView {
    
}


- (NSRect)drawTitle:(NSAttributedString *)title withFrame:(NSRect)frame inView:(NSView *)controlView {
    NSGraphicsContext* ctx = [NSGraphicsContext currentContext];
    NSRect result;
    [ctx saveGraphicsState];
    {   //&& !self.highlighted
        if (self.textColor) {
            NSMutableAttributedString *attrString = [title mutableCopy];
            [attrString addAttribute:NSForegroundColorAttributeName value:self.textColor range:NSMakeRange(0, [attrString length])];
            title = attrString;
            result = [super drawTitle:title withFrame:frame inView:controlView];
        }
    }
    [ctx restoreGraphicsState];
    return result;
}




- (NSRect)titleRectForBounds:(NSRect)theRect
{
    NSEdgeInsets padding = self.titleEdgeInsets;
    theRect.origin.x += padding.left;
    theRect.origin.y += padding.top;
    theRect.size.width -= (padding.left + padding.right);
    theRect.size.height -= (padding.top + padding.bottom);
    return theRect;
}


- (NSRect)imageRectForBounds:(NSRect)theRect
{
    NSEdgeInsets padding = self.imageEdgeInsets;
    theRect.origin.x += padding.left;
    theRect.origin.y += padding.top;
    theRect.size.width -= (padding.left + padding.right);
    theRect.size.height -= (padding.top + padding.bottom);
    return theRect;
}

- (NSRect)drawingRectForBounds:(NSRect)theRect {
    return theRect;
}


/** 待研究方法，暂时系统调用不到这里

- (NSSize)intrinsicContentSize
{
    return NSMakeSize(10, 10);
}


- (NSSize)cellSizeForBounds:(NSRect)aRect
{
    return NSMakeSize(10, 10);
}
 */

@end

