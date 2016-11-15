//
//  HXLeftToolBar.m
//  DingDing_Project
//
//  Created by hanxiaoqing on 16/9/6.
//  Copyright © 2016年 HXQ. All rights reserved.
//

#import "HXLeftToolBar.h"
#import "HXButton.h"
//#import "HXSelectBar.h"

@interface HXLeftToolBar ()

@property (weak) IBOutlet NSImageView *userIconView;
@property (weak) IBOutlet NSTextField *nameLable;

@property (weak) IBOutlet HXButton *creatButton;
@property (weak) IBOutlet HXButton *moreButton;

@end

@implementation HXLeftToolBar

+ (HXLeftToolBar *)loadXibLeftToolBar {
    NSArray *viewsArray;
    NSNib *nib = [[NSNib alloc] initWithNibNamed:@"HXLeftToolBar" bundle:nil];
    [nib instantiateWithOwner:self topLevelObjects:&viewsArray];
    for (NSView *view in viewsArray) {
        if ([view isKindOfClass:[self class]]) {
            return (HXLeftToolBar *)view;
        }
    }
    return nil;
}

- (void)awakeFromNib {
    // 设置底部按钮
    [self setBottmButton:self.creatButton image:@"creatIcon" title:@"创建"];
    [self setBottmButton:self.moreButton image:@"moreIcon" title:@"更多"];
}

- (void)setBottmButton:(HXButton *)btn image:(NSString *)image title:(NSString *)title {
    CGFloat btnImgL = 0;
    CGFloat btnImgW = 40;
    CGFloat btnW = NSWidth(self.creatButton.frame);
    btn.titleEdgeInsets = NSEdgeInsetsMake(0, 40, 0, 0);
    btn.imageEdgeInsets = NSEdgeInsetsMake(0, btnImgL, 0, btnW - btnImgL - btnImgW);
    [btn setImage:[NSImage imageNamed:image] forState:NSControlStateNormal];
    
    [btn setTitle:title forState:NSControlStateNormal];
}

- (void)setUserName:(NSString *)userName {
    _userName = userName;
    self.nameLable.stringValue = userName;
}

// 创建
- (IBAction)creat:(id)sender {
    
}

// 更多
- (IBAction)more:(id)sender {
    
}

@end
