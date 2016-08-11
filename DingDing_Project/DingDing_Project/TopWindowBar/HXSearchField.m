//
//  HXSearchField.m
//  DingDing_Project
//
//  Created by hanxiaoqing on 16/8/11.
//  Copyright © 2016年 HXQ. All rights reserved.
//

#import "HXSearchField.h"
#import "HXPrefixHeader.h"
#import "MVGraphicsFunctions.h"
#import <Quartz/Quartz.h>


@interface HXSearchField () <NSTextFieldDelegate>

@property (nonatomic, assign) BOOL isStop;

@property (nonatomic, strong) id obj;

@end

@implementation HXSearchField


- (instancetype) initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    if(self) {
        [self commonInit];
    }
    return self;
}


- (NSTextField *)textfield {
    if (!_textfield) {
        _textfield = [[NSTextField alloc] initWithFrame:CGRectMake(5, 5, self.bounds.size.width - 20, 20)];
        _textfield.refusesFirstResponder = YES;
        // 去除系统默认的边框
        _textfield.bordered = NO;
        // 去除光标汇聚的时候的聚焦边框
        _textfield.focusRingType = NSFocusRingTypeNone;
        
        _textfield.autoresizingMask = kCALayerWidthSizable;
        _textfield.backgroundColor = [NSColor clearColor];
        
        //_textfield.bezeled = NO;
        //_textfield.bezelStyle = NSTextFieldSquareBezel;
        
        _textfield.delegate  = self;
        
    }
    return _textfield;
}


- (BOOL)isFocused {
    
    return self.textfield.refusesFirstResponder;
}

- (void)resignFocus {
    [self.textfield abortEditing];
}


- (void)commonInit {

    self.textfield.font = [NSFont titleBarFontOfSize:14];
//    self.textfield.backgroundColor = [NSColor purpleColor];
    [self addSubview:self.textfield];
    
}

- (void)setPlaceHolderString:(NSString *)placeHolderString {
    self.textfield.placeholderString = placeHolderString;
}




- (BOOL)becomeFirstResponder {
    
        CABasicAnimation *animate  = [CABasicAnimation animation];
        animate.duration = 0.3;
        animate.repeatCount = 1;
        animate.keyPath = @"bounds.size.width";
        animate.fromValue = @(200);
        animate.toValue = @(230);
        [self.layer addAnimation:animate forKey:nil];
    
    
        CABasicAnimation *animate1 = [CABasicAnimation animation];
        animate1.delegate =self;
        animate1.duration = 0.3;
        animate1.repeatCount = 1;
        animate1.keyPath = @"position.x";
        animate1.fromValue = @(200);
        animate1.toValue = @(170);
        [self.layer addAnimation:animate1 forKey:nil];
    
    return [super becomeFirstResponder];
}



- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    self.frame = CGRectMake(170, 15, 230, 34);
    // self.backgroundColor = [NSColor whiteColor];
    _isStop = YES;
    [self setNeedsDisplay:YES];
}





- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    [NSGraphicsContext saveGraphicsState];
    
    if (_isStop) {
        [[NSColor whiteColor] set];
    } else {
        [HXColor(0, 103, 210) set];
    }
    
    NSBezierPath * bgPath = MVRoundedRectBezierPath(self.bounds,12.0);
    [bgPath fill];
    [NSGraphicsContext restoreGraphicsState];
    
}


@end
