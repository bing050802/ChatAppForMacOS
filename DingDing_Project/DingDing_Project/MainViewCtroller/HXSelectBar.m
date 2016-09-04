//
//  HXSelectBar.m
//  DingDing_Project
//
//  Created by han on 16/9/3.
//  Copyright © 2016年 HXQ. All rights reserved.
//

#import "HXSelectBar.h"
#import "HXBarButton.h"
#import "HXPrefixHeader.h"

@interface HXSelectBar ()

@property (nonatomic, strong) NSArray *normalImages;

@property (nonatomic, strong) NSArray *selectedImages;

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, strong) HXBarButton *currentBtn;


@end

@implementation HXSelectBar

- (instancetype)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.normalImages = @[@"message.png",@"message.png",@"message.png",@"message.png"];
        self.titles = @[@"消息",@"DING",@"联系人",@"公司"];
        self.selectedImages = @[@"message_seclected.png",@"message_seclected.png",@"message_seclected.png",@"message_seclected.png"];
        
    }
    return self;
}

- (void)viewWillMoveToWindow:(nullable NSWindow *)newWindow {
    [super viewWillMoveToWindow:newWindow];
    
    [self addBarButtons];
}

- (void)addBarButtons {
    
    for (int i = 0; i < 4; i++) {
        HXBarButton *barButton = [[HXBarButton alloc] init];
        CGFloat btnY = i * 50;
        barButton.frame = NSMakeRect(0, btnY, 100, 50);
        CGFloat btnImgL = 10;
        CGFloat btnImgW = 40;
        CGFloat btnW = NSWidth(barButton.frame);
        barButton.imageEdgeInsets = NSEdgeInsetsMake(0, btnImgL, 0, btnW - btnImgL - btnImgW);
        barButton.titleEdgeInsets = NSEdgeInsetsMake(0, btnImgL + btnImgW , 0, 0);
        [barButton setBackgroundColor:HXColor(192, 221, 246) forState:ButtonStateSelected];
        [barButton setTitleColor:[NSColor grayColor] forState:ButtonStateNormal];
        [barButton setTitleColor:HXColor(25, 132, 230) forState:ButtonStateSelected];
        [barButton setImage:[NSImage imageNamed:self.normalImages[i]] forState:ButtonStateNormal];
        [barButton setImage:[NSImage imageNamed:self.selectedImages[i]] forState:ButtonStateSelected];
        barButton.target = self;
        barButton.action = @selector(clickBtn:);
        barButton.title = self.titles[i];
        [self addSubview:barButton];
    }
}

- (void)clickBtn:(HXBarButton *)btn {
    btn.selected = !btn.selected;
    self.currentBtn.selected = NO;
    self.currentBtn = btn;
}




@end
