//
//  HXEmotionView.m
//  DingDing_Project
//
//  Created by hanxiaoqing on 2016/11/1.
//  Copyright © 2016年 HXQ. All rights reserved.
//

#import "HXEmotionView.h"

@interface HXEmotionView ()

@property (nonatomic,strong) NSScrollView *scrollView;

@end

@implementation HXEmotionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (NSScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[NSScrollView alloc] init];
        _scrollView.hasHorizontalScroller = YES;
        _scrollView.hasVerticalScroller = YES;
        
        NSView *contentView = [[NSView alloc] init];
        contentView.wantsLayer = YES;
        contentView.layer.backgroundColor = [NSColor redColor].CGColor;
        _scrollView.documentView = contentView;
    }
    return _scrollView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUp];
    self.wantsLayer = YES;
//    self.layer.backgroundColor = [NSColor redColor].CGColor;

}

- (void)setUp {
    [self addSubview:self.scrollView];
    
    self.scrollView.documentView.frame = CGRectMake(0, 0, 330, 600);
    
    
//    
//    // 设置图片的尺寸和位置
//    NSUInteger count = self.subviews.count;
//    int maxCol = 4;
//    CGFloat imageWH = 70;
//    CGFloat imageMargin = 10;
//    
//    for (int i = 0; i<count; i++) {
//        UIImageView *photoView = self.subviews[i];
//        
//        int col = i % maxCol;
//        photoView.x = col * (imageWH + imageMargin);
//        
//        int row = i / maxCol;
//        photoView.y = row * (imageWH + imageMargin);
//        photoView.width = imageWH;
//        photoView.height = imageWH;
//    }

    
    
    CGFloat imageWH = 30;
    
    CGFloat imageMargin = 10;
    // 表情总数
    NSInteger emotions = 16;
    
    // 算出多少列 目前是8
    NSInteger totalloc = 8;
    
    
    for (NSInteger index = 0; index < emotions; index ++) {
        
        NSInteger row = index / totalloc; //行号
        NSInteger col = index % totalloc; //列号
        
        NSImageView *imageView = [[NSImageView alloc] init];
        imageView.image = [NSImage imageNamed:@"xiao.png"];
        
        CGFloat imageViewX = imageMargin +  col * (imageWH + imageMargin);
        CGFloat imageViewY = imageMargin + row * (imageWH + imageMargin);
        
        
        imageView.frame = CGRectMake(imageViewX, imageViewY, imageWH, imageWH);
        
        [self.scrollView.documentView addSubview:imageView];
        
    }
}





- (void)layout {
    [super layout];
    CGFloat scrollViewW = NSWidth(self.frame) - 2 * 15;
    CGFloat scrollViewH = NSHeight(self.frame) - 2 * 15;
    _scrollView.frame = CGRectMake(15, 15, scrollViewW, scrollViewH);
}

@end
