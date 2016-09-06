//
//  HXLeftToolBar.m
//  DingDing_Project
//
//  Created by hanxiaoqing on 16/9/6.
//  Copyright © 2016年 HXQ. All rights reserved.
//

#import "HXLeftToolBar.h"
#import "HXBarButton.h"
//#import "HXSelectBar.h"

@interface HXLeftToolBar ()

@property (weak) IBOutlet NSImageView *userIconView;
@property (weak) IBOutlet NSTextField *nameLable;

@property (weak) IBOutlet HXBarButton *creatButton;
@property (weak) IBOutlet HXBarButton *moreButton;

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

- (void)setBottmButton:(HXBarButton *)btn image:(NSString *)image title:(NSString *)title {
    CGFloat btnImgL = 0;
    CGFloat btnImgW = 40;
    CGFloat btnW = NSWidth(self.creatButton.frame);
    [btn setImage:[NSImage imageNamed:image] forState:ButtonStateNormal];
    btn.imageEdgeInsets = NSEdgeInsetsMake(0, btnImgL, 0, btnW - btnImgL - btnImgW);
    btn.titleEdgeInsets = NSEdgeInsetsMake(0, 15, 0, 0);
    btn.title = title;
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
