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
@property (nonatomic,strong) NSMutableDictionary *stateBackGroundDic;
@property (nonatomic,strong) NSMutableDictionary *stateTitleColorDic;

@property (nonatomic,strong) NSTrackingArea *trackingArea;


@property (nonatomic,strong) NSImage *displayImage;

@property (nonatomic,copy) NSString *displayTitle;


@property (nonatomic,copy) NSMutableAttributedString *currtentDisplayString;


@end



@implementation HXButton

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

- (void)setUp {
    _titleFont = [NSFont systemFontOfSize:16];
}


- (void)drawRect:(NSRect)dirtyRect {
    
    if (self.highlighted) { } // do highlighted things
    
    
    NSImage *image = [NSImage imageNamed:@"bg@2x"];
    [image drawInRect:dirtyRect];
    
    
    NSAttributedString *disPlayString = self.currtentDisplayString;
    
    CGFloat stringH =  NSHeight(dirtyRect);
    CGFloat stringY = (stringH - disPlayString.size.height) * 0.5;
    CGFloat stringW =  NSWidth(dirtyRect);
    
    [disPlayString drawWithRect:CGRectMake(0,-stringY, stringW, stringH) options:NSStringDrawingUsesLineFragmentOrigin];
    
}







- (NSMutableAttributedString *)bulidDisplayStringWith:(NSString *)title
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
    self.currtentDisplayString = [displayString mutableCopy];

    return displayString;
}

- (void)setTitleFont:(NSFont *)titleFont
{
    _titleFont = titleFont;
}


- (void)setTitle:(nullable NSString *)title forState:(NSControlState)state
{
    [self bulidDisplayStringWith:title];
    [self setNeedsDisplay];
}

- (void)setTitleColor:(nullable NSColor *)color forState:(NSControlState)state
{
    [self.stateTitleColorDic setObject:color forKey:@(state)];
    
    [self.currtentDisplayString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, self.currtentDisplayString.length)];
    [self setNeedsDisplay];
    
}




- (void)setImage:(nullable NSImage *)image forState:(NSControlState)state {
    
    
}





@end
