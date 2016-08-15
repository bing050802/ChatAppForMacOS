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
#import "HXTextField.h"

#define selfWidth   self.bounds.size.width
#define selfHeight  self.bounds.size.height
#define selfX       self.frame.origin.x
#define selfY       self.frame.origin.y


@interface HXSearchField () <HXTextFieldDelegate>


@property (nonatomic, strong) NSText *placeHolderLabel;

@property (nonatomic, strong) HXTextField *textfield;

@property (nonatomic, assign) BOOL searchingState;

@property (nonatomic, assign) CGRect originFrame;


@end

@implementation HXSearchField


- (HXTextField *)textfield {
    if (!_textfield) {
        _textfield = [[HXTextField alloc] init];
        _textfield.refusesFirstResponder = YES;
        // 去除系统默认的边框
        _textfield.bordered = NO;
        // 去除光标汇聚的时候的聚焦边框
        _textfield.focusRingType = NSFocusRingTypeNone;
        
        _textfield.autoresizingMask = kCALayerWidthSizable;
        _textfield.backgroundColor = [NSColor clearColor];
        _textfield.font = [NSFont titleBarFontOfSize:14];
        
        //_textfield.bezeled = NO;
        //_textfield.bezelStyle = NSTextFieldSquareBezel;
        _textfield.hx_delagate = self;
        
    }
    return _textfield;
}


- (NSText *)placeHolderLabel {
    if (!_placeHolderLabel) {
        _placeHolderLabel = [[NSText alloc] init];
        _placeHolderLabel.alphaValue = 0.6;
        _placeHolderLabel.editable = NO;
        _placeHolderLabel.selectable = NO;
        _placeHolderLabel.backgroundColor = [NSColor clearColor];
        _placeHolderLabel.textColor = [NSColor whiteColor];
        _placeHolderLabel.font = [NSFont labelFontOfSize:14];
        [self addSubview:_placeHolderLabel positioned:NSWindowBelow relativeTo:self.textfield];
    }
    return _placeHolderLabel;
}

- (instancetype) initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    if(self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    
    self.wantsLayer  = YES;
    self.layer.cornerRadius = 14;
    self.layer.masksToBounds = YES;
    self.layer.backgroundColor = HXColor(0, 103, 210).CGColor;

    [self addSubview:self.textfield];
    
    [self.placeHolderLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:7.0];
    [self.placeHolderLabel autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:20];
    [self.placeHolderLabel autoSetDimension:ALDimensionHeight toSize:20];
    [self.placeHolderLabel autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:8];
    
    [self.textfield autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:7.0];
    [self.textfield autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:20];
    [self.textfield autoSetDimension:ALDimensionHeight toSize:20];
    [self.textfield autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:8];

}

- (void)setPlaceHolderString:(NSString *)placeHolderString {
    _placeHolderString = placeHolderString;
    self.placeHolderLabel.string = placeHolderString;
}


- (void)controlTextDidChange:(NSNotification *)obj {
    
    if (self.textfield.stringValue.length) {
        self.placeHolderLabel.alphaValue = 0;
    } else {
        self.placeHolderLabel.alphaValue = 1.0;
    }
}


- (void)textFieldBecomeFirstResponder {
    
    self.originFrame = self.frame;
    _searchingState = YES;
    
    [self focusedStyleSetting];
    [self animationWithState:YES];
}


- (void)resignFocus {
    
    [self.textfield abortEditing];
    
    [self resignedStyleSetting];
    
    if (_searchingState) {
        [self animationWithState:NO];
    }
    _searchingState = NO;
}


- (void)focusedStyleSetting {
    [self backGroundColor:[NSColor whiteColor]];
    self.placeHolderLabel.textColor = [NSColor lightGrayColor];
    self.placeHolderLabel.alphaValue = 1.0;
    self.placeHolderLabel.string = @"搜索...";
}

- (void)resignedStyleSetting {
    [self backGroundColor:HXColor(0, 103, 210)];
    self.placeHolderLabel.textColor = [NSColor whiteColor];
    self.placeHolderLabel.alphaValue = 0.6;
    self.placeHolderLabel.string = self.placeHolderString;
}


- (void)animationWithState:(BOOL)isSearching {
    
    [self.layer removeAllAnimations];
    
    [[NSAnimationContext currentContext] setDuration:0.4];
    [NSAnimationContext beginGrouping];
    if (isSearching) {
        [self.animator setFrameSize:NSMakeSize(NSWidth(self.originFrame) + 50, selfHeight)];
        [self.animator setFrameOrigin:NSMakePoint(NSMinX(self.originFrame) - 50, selfY)];
    } else {
        [self.animator setFrameSize:NSMakeSize(NSWidth(self.originFrame), selfHeight)];
        [self.animator setFrameOrigin:NSMakePoint(NSMinX(self.originFrame), selfY)];
    }
    [NSAnimationContext endGrouping];
    
}


-(void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
