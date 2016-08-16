//
//  HXSearchField.m
//  DingDing_Project
//
//  Created by hanxiaoqing on 16/8/11.
//  Copyright © 2016年 HXQ. All rights reserved.
//

#import "HXSearchField.h"
#import "HXPrefixHeader.h"
#import <Quartz/Quartz.h>
#import "HXTextField.h"

#define selfWidth   self.frame.size.width
#define selfHeight  self.frame.size.height
#define selfX       self.frame.origin.x
#define selfY       self.frame.origin.y

@class NOHighlightBtn;

@interface HXSearchButton :NSView

@property (nonatomic, strong) NOHighlightBtn *btn;
@property (nonatomic, strong) NSTrackingArea *trackingArea;

@end




@interface HXSearchField () <HXTextFieldDelegate>

@property (nonatomic, strong) NSText *placeHolderLabel;

@property (nonatomic, strong) HXTextField *textfield;

@property (nonatomic, assign) BOOL searchingState;

@property (nonatomic, assign) CGRect originFrame;

@property (nonatomic, strong) HXSearchButton *searchButton;

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

- (HXSearchButton *)searchButton {
    if (!_searchButton) {
        _searchButton = [[HXSearchButton alloc] init];
        _searchButton.frame = NSMakeRect(NSWidth(self.originFrame) + 5, 0, 32, 32);
    }
    return _searchButton;
}


- (instancetype) initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    if(self) {
        [self commonInit];
    }
    return self;
}


- (void)mouseDown:(NSEvent *)theEvent
{
    
}



- (void)commonInit {
    
    self.wantsLayer  = YES;
    self.layer.cornerRadius = 14;
    self.layer.masksToBounds = YES;
    self.layer.backgroundColor = HXColor(0, 103, 210).CGColor;

    [self addSubview:self.textfield];
    
    [self.textfield autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:7.0];
    [self.textfield autoSetDimension:ALDimensionHeight toSize:18];
    [self.textfield autoSetDimension:ALDimensionWidth toSize:210];
    [self.textfield autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:8];
    
    [self.placeHolderLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:7.0];
    [self.placeHolderLabel autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:20];
    [self.placeHolderLabel autoSetDimension:ALDimensionHeight toSize:20];
    [self.placeHolderLabel autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:8];

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
    [self.searchButton removeFromSuperview];
    [self backGroundColor:HXColor(0, 103, 210)];
    self.placeHolderLabel.textColor = [NSColor whiteColor];
    self.placeHolderLabel.alphaValue = 0.6;
    self.placeHolderLabel.string = self.placeHolderString;
    self.textfield.stringValue = @"";

}


- (void)animationWithState:(BOOL)isSearching {
    
    [self.layer removeAllAnimations];
    
    NSAnimationContext *animationContext = [NSAnimationContext currentContext];
    animationContext.duration = 0.4;
    animationContext.completionHandler = ^{
        [self addSubview:self.searchButton];
    };
    
    [NSAnimationContext beginGrouping];
    if (isSearching) {
        self.animator.frame = NSMakeRect(NSMinX(self.originFrame) - 50, selfY, NSWidth(self.originFrame) + 50, selfHeight);
    } else {
        self.animator.frame = self.originFrame;
    }
    [NSAnimationContext endGrouping];
    
}


-(void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end






@interface NOHighlightBtn : NSButton

@end

@implementation NOHighlightBtn

// 为了去除 系统按钮自带的点击高亮效果，拦截mouseDown事件，把事件传给外部
- (void)mouseDown:(NSEvent *)theEvent {
    [self sendAction:self.action to:self.target];
    
}


@end





@implementation HXSearchButton

- (instancetype) initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    if(self) {
        [self commonInit];
    }
    return self;
}

- (NSTrackingArea *)trackingArea {
    if(!_trackingArea) {
        _trackingArea = [[NSTrackingArea alloc] initWithRect:self.btn.frame
                                                     options: (NSTrackingMouseEnteredAndExited | NSTrackingActiveInActiveApp)
                                                       owner:self userInfo:nil];
    }
    return _trackingArea;
}

- (void)commonInit {

//    [self backGroundColor:[NSColor orangeColor]];
    
    // 左边的 分割竖线
    NSView *v_line = [[NSView alloc] initWithFrame: NSMakeRect(0,7,1, 18)];
    [v_line backGroundColor:[NSColor lightGrayColor]];
    [self addSubview:v_line];
    
    // 搜索按钮
    NOHighlightBtn *btn = [[NOHighlightBtn alloc] initWithFrame: NSMakeRect(10,0, 20, 30)];
    btn.target = self;
    btn.action = @selector(searchBtnClick:);
    btn.bordered = NO;
    btn.image = [NSImage imageNamed:@"search_btn.png"];
    [self addSubview:btn];
    self.btn = btn;
    
    // 为搜索按钮区域 增加鼠标进入，离开时候的事件响应
    [self addTrackingArea:self.trackingArea];

}


- (void)searchBtnClick:(NOHighlightBtn *)btn {
    
}


- (void)mouseEntered:(NSEvent *)theEvent {
    self.btn.image =[NSImage imageNamed:@"search_btn_mousein.png"];
}

- (void)mouseExited:(NSEvent *)theEvent {
    self.btn.image = [NSImage imageNamed:@"search_btn.png"];
}

@end




