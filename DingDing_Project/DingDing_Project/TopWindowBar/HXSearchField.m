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
#import "MLPopupWindowManager.h"

#define selfWidth   self.frame.size.width
#define selfHeight  self.frame.size.height
#define selfX       self.frame.origin.x
#define selfY       self.frame.origin.y


@interface HXSearchField () <HXTextFieldDelegate,NSAnimationDelegate>

@property (nonatomic, strong) NSText *placeHolderLabel;

@property (nonatomic, strong) HXTextField *textfield;

@property (nonatomic, strong) HXSearchButton *searchButton;

@property (nonatomic, assign) BOOL searchingState;

@property (nonatomic, assign) BOOL first;

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

- (HXSearchButton *)searchButton {
    if (!_searchButton) {
        __weak typeof(self) weakSelf = self;
        _searchButton = [[HXSearchButton alloc] init];
        _searchButton.clearInputBlock = ^() {
           weakSelf.textfield.stringValue = @"";
        };
        _searchButton.frame = NSMakeRect(NSWidth(self.originFrame) , 0, 80, 32);
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


- (void)mouseDown:(NSEvent *)theEvent {
    
}


- (void)commonInit {
    
    self.wantsLayer  = YES;
    self.layer.cornerRadius = 14;
    self.layer.masksToBounds = YES;
    self.layer.backgroundColor = HXColor(0, 103, 210).CGColor;

    [self addSubview:self.textfield];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(windowDidResize:)
                                                 name:NSWindowDidResizeNotification
                                               object:nil];

    [self.textfield autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:7.0];
    [self.textfield autoSetDimension:ALDimensionHeight toSize:18];
    [self.textfield autoSetDimension:ALDimensionWidth toSize:200];
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


- (void)viewDidMoveToWindow {
    [super viewDidMoveToWindow];
//    [self resignFocus];
}

- (void)controlTextDidChange:(NSNotification *)obj {
    
    if (self.textfield.stringValue.length) {
        self.placeHolderLabel.alphaValue = 0;
        self.searchButton.clearBtn.hidden = NO;
    } else {
        self.placeHolderLabel.alphaValue = 1.0;
        self.searchButton.clearBtn.hidden = YES;
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
    self.placeHolderLabel.string =  self.placeHolderString;
    self.textfield.stringValue = @"";
    

}


- (void)animationWithState:(BOOL)isSearching {
    
    
    NSAnimationContext *animationContext = [NSAnimationContext currentContext];
    animationContext.allowsImplicitAnimation = YES;
    animationContext.duration = 0.4;
    animationContext.completionHandler = ^{
        
        [self addSubview:self.searchButton];
        
        //                NSView *view = [[NSView alloc] init];
        //                [view backGroundColor:[NSColor yellowColor]];
        //                [self.window.contentView addSubview:view];
        //
        //                [view autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:55];
        //                [view autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:50];
        //                [view autoSetDimension:ALDimensionHeight toSize:300];
        //                [view autoSetDimension:ALDimensionWidth toSize:250]
    };
    
    [NSAnimationContext beginGrouping];
    if (isSearching) {
        
        //        self.animator.frame = NSMakeRect(NSMinX(self.originFrame) - 50, selfY, NSWidth(self.originFrame) + 50, selfHeight);
                self.animator.widthConstrinat.constant = 270;
    } else {
        //       self.animator.frame = self.originFrame;
        self.animator.widthConstrinat.constant = 210;
    }
    [NSAnimationContext endGrouping];
    
}


- (void)animationDidEnd:(NSAnimation *)animation {
    NSAnimationContext *animationContext = [NSAnimationContext currentContext];
    animationContext.allowsImplicitAnimation = NO;
}

- (void)windowDidResize:(NSNotification *)note {
    
}


-(void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];

    
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end






@implementation NOHighlightBtn


// 为了去除 系统按钮自带的点击高亮效果，拦截mouseDown事件，把事件传给外部
- (void)mouseDown:(NSEvent *)theEvent {
    [self sendAction:self.action to:self.target];
    
}
- (void)setNormalImage:(NSImage *)normalImage {
    _normalImage = normalImage;
    self.image = normalImage;
}


- (void)setMouseinState:(BOOL)mouseinState {
    if (mouseinState) {
        self.image = self.mouseinImage;
    } else {
        self.image = self.normalImage;
    }
    
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


// 为搜索按钮区域 增加鼠标进入，离开时候的事件响应
- (void)creatTrackingAreaWithRect:(NSRect)rect areaId:(NSString *)areaId {
    
    NSTrackingArea *trackingArea = [[NSTrackingArea alloc] initWithRect:rect
                                                 options:(NSTrackingMouseEnteredAndExited | NSTrackingActiveInActiveApp)
                                                                  owner:self userInfo:@{@"areaId":areaId}];
    [self addTrackingArea:trackingArea];
}

- (void)commonInit {

//    [self backGroundColor:[NSColor orangeColor]];
    
    
    // 搜索按钮
    NOHighlightBtn *clearBtn = [[NOHighlightBtn alloc] initWithFrame: NSMakeRect(0,0, 18, 30)];
    clearBtn.hidden = YES;
    clearBtn.target = self;
    clearBtn.action = @selector(clearBtnClick:);
    clearBtn.bordered = NO;
    clearBtn.normalImage = [NSImage imageNamed:@"clear_btn.png"];
    clearBtn.mouseinImage = [NSImage imageNamed:@"clear_btn_mousein.png"];
    [self addSubview:clearBtn];
    self.clearBtn = clearBtn;
    [self creatTrackingAreaWithRect:clearBtn.frame areaId:@"clearBtn"];
    
    // 左边的 分割竖线
    NSView *v_line = [[NSView alloc] initWithFrame: NSMakeRect(23,7,1, 18)];
    [v_line backGroundColor:[NSColor lightGrayColor]];
    [self addSubview:v_line];
    
    // 搜索按钮
    NOHighlightBtn *seekBtn = [[NOHighlightBtn alloc] initWithFrame: NSMakeRect(28,0, 20, 30)];
    seekBtn.target = self;
    seekBtn.action = @selector(searchBtnClick:);
    seekBtn.bordered = NO;
    seekBtn.normalImage = [NSImage imageNamed:@"search_btn.png"];
    seekBtn.mouseinImage = [NSImage imageNamed:@"search_btn_mousein.png"];
    [self addSubview:seekBtn];
    self.seekBtn = seekBtn;
    [self creatTrackingAreaWithRect:seekBtn.frame areaId:@"seekBtn"];

}


- (void)clearBtnClick:(NOHighlightBtn *)btn {
    if (self.clearInputBlock) {
        self.clearInputBlock();
    }
}




- (void)searchBtnClick:(NOHighlightBtn *)btn {
    
    
    
}


- (void)mouseEntered:(NSEvent *)theEvent {
    NSString *areaId = theEvent.trackingArea.userInfo[@"areaId"];
    if ([areaId isEqualToString:@"seekBtn"]) {
        self.seekBtn.mouseinState = YES;
    } else {
        self.clearBtn.mouseinState = YES;

    }
}

- (void)mouseExited:(NSEvent *)theEvent {
    
    NSString *areaId = theEvent.trackingArea.userInfo[@"areaId"];
    if ([areaId isEqualToString:@"seekBtn"]) {
         self.seekBtn.mouseinState = NO;
    }else {
         self.clearBtn.mouseinState = NO;
    }
}



@end




