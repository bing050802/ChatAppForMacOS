//
//  HXScrollView.m
//  HXRefreshForMac
//
//  Created by hanxiaoqing on 2016/12/20.
//  Copyright © 2016年 Babeltime. All rights reserved.
//

#import "HXScrollView.h"

@implementation HXScrollView


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ScrollViewWillStartLiveScroll:) name:NSScrollViewWillStartLiveScrollNotification object:nil];
//         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ScrollViewDidLiveScroll:) name:NSScrollViewDidLiveScrollNotification object:nil];
//         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ScrollViewDidEndLiveScroll:) name:NSScrollViewDidEndLiveScrollNotification object:nil];
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}
static BOOL Rstate = NO;


-(void)scrollWheel:(NSEvent *)event {
    
    
    
    if (Rstate ==YES) {
        return;
    } else {
        
        [super scrollWheel:event];
        
        
        NSLog(@"--%@",NSStringFromPoint(self.bounds.origin));
        
        CGSize contentSize = self.documentView.bounds.size;
        CGPoint contentOffset = self.contentView.bounds.origin;
        

        if (contentSize.height - contentOffset.y - self.contentView.bounds.size.height < 1.0) {
            [NSAnimationContext runAnimationGroup:^(NSAnimationContext * _Nonnull context) {
                context.duration = 0.5;
                
                self.contentView.animator.contentInsets = NSEdgeInsetsMake(40, 0, 0, 0);
                
                CGRect bs = self.contentView.bounds;
                bs.origin.y = bs.origin.y + 40;
                self.contentView.animator.bounds = bs;
                
                
            } completionHandler:^{
                
                Rstate = YES;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [NSAnimationContext runAnimationGroup:^(NSAnimationContext * _Nonnull context) {
                        context.duration = 0.5;
                        self.contentView.animator.contentInsets = NSEdgeInsetsMake(0, 0, 0, 0);
//                        CGRect bs = self.contentView.bounds;
//                        bs.origin.y = bs.origin.y - 40;
//                        self.contentView.animator.bounds = bs;
                        
                    } completionHandler:^{
                        Rstate = NO;
                    }];
                    
                });
                
            }];
            
        }
        
    }
}


//
//- (void)ScrollViewWillStartLiveScroll:(NSNotification *)noti {
//    NSLog(@"---ScrollViewWillStartLiveScroll--");
//}
//
//
//- (void)ScrollViewDidLiveScroll:(NSNotification *)noti {
//     NSLog(@"---ScrollViewDidLiveScroll--");
//}
//
//- (void)ScrollViewDidEndLiveScroll:(NSNotification *)noti {
//     NSLog(@"---ScrollViewDidEndLiveScroll--");
//}


@end
