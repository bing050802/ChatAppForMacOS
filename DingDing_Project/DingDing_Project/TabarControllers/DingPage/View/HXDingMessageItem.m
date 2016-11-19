//
//  HXDingMessageItem.m
//  DingDing_Project
//
//  Created by han on 2016/11/20.
//  Copyright © 2016年 HXQ. All rights reserved.
//

#import "HXPrefixHeader.h"
#import "HXDingMessageItem.h"
#import "HXButton.h"

@interface HXDingMessageItem ()

@property (weak) IBOutlet NSView *contentView;

@property (weak) IBOutlet HXButton *nameBtn;

@property (weak) IBOutlet HXButton *lookDetailBtn;

@property (weak) IBOutlet NSScrollView *textScrollView;




@end

@implementation HXDingMessageItem


-(void)loadView {
    [super loadView];
    
    
    self.contentView.wantsLayer = YES;
    self.contentView.layer.cornerRadius = 5;
    self.contentView.layer.borderWidth = 0.56;
    self.contentView.layer.borderColor = [NSColor grayColor].CGColor;
    self.contentView.layer.backgroundColor = [NSColor whiteColor].CGColor;
    
    
    [_textScrollView setVerticalLineScroll:0.0];
    [_textScrollView setVerticalPageScroll:0.0];
    
    self.nameBtn.trackingEabled = YES;
    [self.nameBtn setTitleColor:HXColor(111, 195, 253) forState:NSControlStateNormal];
    [self.nameBtn setTitleColor:HXColor(85, 183, 252) forState:NSControlStateMouseIn];
    [self.nameBtn setTitle:@"张三" forState:0];
    
    self.lookDetailBtn.trackingEabled = YES;
    self.lookDetailBtn.titleEdgeInsets = NSEdgeInsetsMake(0, 30, 0, 0);
    self.lookDetailBtn.imageEdgeInsets = NSEdgeInsetsMake(0, 0, 0, 190);
    
    [self.lookDetailBtn setTitleColor:[NSColor grayColor] forState:NSControlStateNormal];
    [self.lookDetailBtn setTitleColor:HXColor(85, 183, 252) forState:NSControlStateMouseIn];
    [self.lookDetailBtn setImage:[NSImage imageNamed:@"detail"] forState:NSControlStateNormal];
    [self.lookDetailBtn setImage:[NSImage imageNamed:@"detail_in"] forState:NSControlStateMouseIn];
    [self.lookDetailBtn setTitle:@"点击到详情页回复" forState:NSControlStateNormal];
    
    
}

@end
