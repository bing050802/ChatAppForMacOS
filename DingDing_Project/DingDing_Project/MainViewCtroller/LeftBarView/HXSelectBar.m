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

@property (nonatomic, strong) HXBarButton *lastSelectBtn;


@end

@implementation HXSelectBar



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
    self.normalImages = @[@"dingpan.png",@"work.png",@"connect.png",@"dingIcon.png",@"message.png"];
    self.titles = @[@"钉盘",@"工作",@"联系人",@"DING",@"消息"];
    self.selectedImages = @[@"dingpan_seclected.png",@"work_seclected.png",@"connect_seclected.png",@"dingIcon_seclected.png",@"message_seclected.png"];
}
- (void)viewWillMoveToWindow:(nullable NSWindow *)newWindow {
    [super viewWillMoveToWindow:newWindow];
    
    [self addBarButtons];
}

- (void)addBarButtons {
    
    for (int i = 0; i < self.normalImages.count; i++) {
        HXBarButton *barButton = [[HXBarButton alloc] init];
        CGFloat btnY = i * 50;
        barButton.frame = NSMakeRect(0, btnY, 100, 50);
        CGFloat btnImgL = 10;
        CGFloat btnImgW = 40;
        CGFloat btnW = NSWidth(barButton.frame);
        barButton.imageEdgeInsets = NSEdgeInsetsMake(0, btnImgL, 0, btnW - btnImgL - btnImgW);
        barButton.titleEdgeInsets = NSEdgeInsetsMake(0, btnImgL + btnImgW, 0, 0);
        [barButton setBackgroundColor:HXColor(221, 228, 242) forState:ButtonStateNormal];
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
    self.lastSelectBtn.selected = NO;
     btn.selected = YES;
    self.lastSelectBtn = btn;
}




@end
