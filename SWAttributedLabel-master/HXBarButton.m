//
//  HXBarButton.m
//  DingDing_Project
//
//  Created by hanxiaoqing on 16/8/29.
//  Copyright © 2016年 HXQ. All rights reserved.
//

#import "HXBarButton.h"

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


@property (nonatomic,strong) NSMutableDictionary *stateImageDic;
@property (nonatomic,strong) NSMutableDictionary *stateBackGroundDic;
@property (nonatomic,strong) NSMutableDictionary *stateTitleColorDic;

@property (nonatomic,strong) NSView *leftLine;

@property (nonatomic,strong) NSTrackingArea *trackingArea;

@end


@implementation HXBarButton

#pragma mark Cell passthroughs------------------------------------------------------------------begin

- (CGFloat)cornerRadius {
    return self.btnCell.cornerRadius;
}
- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
}

- (NSColor *)highlightColor {
    return self.btnCell.highlightColor;
}
- (void)setHighlightColor:(NSColor *)highlightColor {
    self.btnCell.highlightColor = highlightColor;
}

- (NSColor *)highlightTextColor {
    return self.btnCell.highlightTextColor;
}
- (void)setHighlightTextColor:(NSColor *)textColor {
    self.btnCell.highlightTextColor = textColor;
}

- (NSEdgeInsets)titleEdgeInsets {
    return self.btnCell.titleEdgeInsets;
}
- (void)setTitleEdgeInsets:(NSEdgeInsets)titleEdgeInsets {
    self.btnCell.titleEdgeInsets = titleEdgeInsets;
}

- (NSEdgeInsets)imageEdgeInsets {
    return self.btnCell.imageEdgeInsets;
}
- (void)setImageEdgeInsets:(NSEdgeInsets)imageEdgeInsets {
    self.btnCell.imageEdgeInsets = imageEdgeInsets;
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

- (NSView *)leftLine {
    if (!_leftLine) {
        _leftLine = [[NSView alloc] initWithFrame:NSMakeRect(0, 0, 2, self.frame.size.height)];
//        [_leftLine backGroundColor:HXColor(0, 151, 219)];
        _leftLine.hidden = YES;
        [self addSubview:_leftLine];
    }
    return _leftLine;
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

- (void)awakeFromNib {
    [self setUp];
}

- (instancetype)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    self.font = [NSFont systemFontOfSize:13];
    self.subpixelAntialiasing = YES;
    self.wantsLayer = YES;
    [self setCell:[HXBarButtonCell new]];
}

- (HXBarButtonCell *)btnCell {
    return (HXBarButtonCell *)[super cell];
}


- (NSTrackingArea *)trackingArea {
    if (!_trackingArea) {
        _trackingArea = [[NSTrackingArea alloc] initWithRect:NSZeroRect
                                                     options:NSTrackingInVisibleRect | NSTrackingActiveAlways | NSTrackingMouseEnteredAndExited
                                                       owner:self
                                                    userInfo:nil];
    }
    return _trackingArea;
}


- (void)setTrackingEabled:(BOOL)trackingEabled {
    _trackingEabled = trackingEabled;
    if (trackingEabled) {
        [self addTrackingArea:self.trackingArea];
    } else {
        [self removeTrackingArea:self.trackingArea];
    }
}

- (void)mouseEntered:(NSEvent *)event {
    self.image = self.stateImageDic[@(ButtonStateMouseIn)];
}

- (void)mouseExited:(NSEvent *)event {
    self.image = self.stateImageDic[@(ButtonStateNormal)];
}

- (void)setImage:(NSImage *)image forState:(ButtonState)state {
    if (state == ButtonStateNormal) {
        self.image = image;
    }
    [self.stateImageDic setObject:image forKey:@(state)];
}

- (void)setBackgroundColor:(NSColor *)backgroundColor forState:(ButtonState)state {
    if (state == ButtonStateNormal) {
        self.btnCell.backgroundColor = backgroundColor;
    }
    [self.stateBackGroundDic setObject:backgroundColor forKey:@(state)];
}
- (void)setTitleColor:(NSColor *)titleColor forState:(ButtonState)state {
    if (state == ButtonStateNormal) {
        self.btnCell.textColor = titleColor;
    }
     [self.stateTitleColorDic setObject:titleColor forKey:@(state)];
}

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    if (selected) {
        if (self.stateImageDic[@(ButtonStateSelected)]) {
             self.image = self.stateImageDic[@(ButtonStateSelected)];
        } else {
             self.image = self.stateImageDic[@(ButtonStateNormal)];
        }
        self.btnCell.backgroundColor = self.stateBackGroundDic[@(ButtonStateSelected)];
        self.btnCell.textColor = self.stateTitleColorDic[@(ButtonStateSelected)];
        self.leftLine.hidden = NO;
    } else {
        self.image = self.stateImageDic[@(ButtonStateNormal)];
        self.btnCell.backgroundColor = self.stateBackGroundDic[@(ButtonStateNormal)];
        self.btnCell.textColor = self.stateTitleColorDic[@(ButtonStateNormal)];
        self.leftLine.hidden = YES;
    }
}

@end



@implementation HXBarButtonCell


/**  鼠标高亮点击时候会调用 */
- (void)highlight:(BOOL)flag withFrame:(NSRect)cellFrame inView:(NSView *)controlView {
    if (flag) {
        // 高亮状态下进行一些 画操作
//        MVRoundedRectBezierPath(cellFrame, 5);
    }
//    [super highlight:flag withFrame:cellFrame inView:controlView];
}


- (void)drawInteriorWithFrame:(NSRect)cellFrame inView:(NSView *)controlView {
    [super drawInteriorWithFrame:cellFrame inView:controlView];
    
    
    
}

// 画边框
- (void)drawBezelWithFrame:(NSRect)frame inView:(NSView *)controlView
{
    
}


- (NSRect)drawTitle:(NSAttributedString *)title withFrame:(NSRect)frame inView:(NSView *)controlView
{
    if (self.textColor) {
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.alignment = NSTextAlignmentCenter;//设置左对齐
        NSMutableAttributedString *attrString = [title mutableCopy];
        [attrString addAttribute:NSForegroundColorAttributeName value:self.textColor range:NSMakeRange(0, attrString.length)];
        [attrString addAttribute:NSParagraphStyleAttributeName value:paragraph range:NSMakeRange(0, attrString.length)];
        title = attrString;
    }
    return [super drawTitle:title withFrame:frame inView:controlView];
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

