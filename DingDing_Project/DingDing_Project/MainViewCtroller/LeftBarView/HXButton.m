//
//  HXButton.m
//  DingDing_Project
//
//  Created by hanxiaoqing on 16/8/29.
//  Copyright © 2016年 HXQ. All rights reserved.
//

#import "HXButton.h"

@interface HXButton ()

@property (nonatomic,strong) NSMutableDictionary *stateImageDic;

@property (nonatomic,strong) NSMutableDictionary *stateTitleColorDic;

@property (nonatomic,strong) NSTrackingArea *trackingArea;


//@property (nonatomic,copy) NSString *displayTitle;


@property (nonatomic,copy) NSMutableAttributedString *currtentDisplayString;
@property (nonatomic,strong) NSImage *currtentDisplayImage;

@end



@implementation HXButton

- (NSMutableDictionary *)stateImageDic {
    if (!_stateImageDic) {
        _stateImageDic = [NSMutableDictionary dictionary];
    }
    return _stateImageDic;
}


- (NSMutableDictionary *)stateTitleColorDic {
    if (!_stateTitleColorDic) {
        _stateTitleColorDic = [NSMutableDictionary dictionary];
    }
    return _stateTitleColorDic;
}

- (instancetype)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
     [self setUp];

}

- (void)setUp
{
    self.wantsLayer = YES;
 
    _titleFont = [NSFont systemFontOfSize:16];
    
    [self setTitleColor:[NSColor blackColor] forState:NSControlStateNormal];
}


- (void)drawRect:(NSRect)dirtyRect
{
    if (self.highlighted) { } // do highlighted things
    
    NSImage *drawImage = self.currtentDisplayImage;
    [drawImage drawInRect:[self imageRectForBounds:dirtyRect]];
    
    
    NSAttributedString *disPlayString = self.currtentDisplayString;
    CGFloat stringH =  NSHeight(dirtyRect);
    CGFloat stringY = (stringH - disPlayString.size.height) * 0.5;
    CGFloat stringW =  NSWidth(dirtyRect);
    CGRect  titleRect = CGRectMake(0, -stringY, stringW, stringH);
    
    [disPlayString drawWithRect:[self titleRectForBounds:titleRect] options:NSStringDrawingUsesLineFragmentOrigin];
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



- (void)bulidDisplayStringWith:(NSString *)title
{
    NSMutableParagraphStyle *pStyle = [[NSMutableParagraphStyle alloc] init];
    pStyle.alignment = NSTextAlignmentCenter;
    pStyle.lineBreakMode = NSLineBreakByWordWrapping;

    
    NSDictionary *atts = @{NSForegroundColorAttributeName:[NSColor blackColor],
                           NSFontAttributeName:_titleFont,
                           NSParagraphStyleAttributeName:pStyle
                           };
    
    NSMutableAttributedString *displayString = [[NSMutableAttributedString alloc]
                                                 initWithString:title
                                                 attributes:atts];
    self.currtentDisplayString = displayString;
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

- (void)setBackGroundColor:(NSColor *)backGroundColor {
    _backGroundColor = backGroundColor;
    self.layer.backgroundColor = backGroundColor.CGColor;
}

- (void)setTrackingEabled:(BOOL)trackingEabled {
    _trackingEabled = trackingEabled;
    if (trackingEabled) {
        [self addTrackingArea:self.trackingArea];
    } else {
        [self removeTrackingArea:self.trackingArea];
    }
}



- (void)setTitle:(nullable NSString *)title forState:(NSControlState)state
{
    [self bulidDisplayStringWith:title];
     self.selected = NO;
}

- (void)setTitleColor:(nullable NSColor *)color forState:(NSControlState)state
{
    [self.stateTitleColorDic setObject:color forKey:@(state)];
    self.selected = NO;
}

- (void)setImage:(nullable NSImage *)image forState:(NSControlState)state
{
    [self.stateImageDic setObject:image forKey:@(state)];
    self.selected = NO;
}



- (void)setSelected:(BOOL)selected
{
    _selected = selected;
    
    NSImage *normalStateImage      = self.stateImageDic[@(NSControlStateNormal)];
    NSColor *normalStateTitleColor = self.stateTitleColorDic[@(NSControlStateNormal)];
    
    NSImage *image;
    NSColor *titleColor;
    
    if (selected) {
        image      = self.stateImageDic[@(NSControlStateSelected)];
        titleColor = self.stateTitleColorDic[@(NSControlStateSelected)];
        
        if (!image) {
            image = normalStateImage;
        }
        if (!titleColor) {
            titleColor = normalStateTitleColor;
        }
        
    } else {
        image      = normalStateImage;
        titleColor = normalStateTitleColor;
    }
    
    NSMutableAttributedString *mattStr = [self.currtentDisplayString mutableCopy];
    [mattStr addAttribute:NSForegroundColorAttributeName
                    value:titleColor
                    range:NSMakeRange(0, mattStr.length)];
    self.currtentDisplayString = mattStr;
    
    self.currtentDisplayImage = image;
    
    [self setNeedsDisplay];
}


- (void)mouseEntered:(NSEvent *)event
{
    self.currtentDisplayImage = self.stateImageDic[@(NSControlStateMouseIn)];
    [self setNeedsDisplay];
}

- (void)mouseExited:(NSEvent *)event
{
    self.currtentDisplayImage = self.stateImageDic[@(NSControlStateNormal)];
    [self setNeedsDisplay];
}



@end
