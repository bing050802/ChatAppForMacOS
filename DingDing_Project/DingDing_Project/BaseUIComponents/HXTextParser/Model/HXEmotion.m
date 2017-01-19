//
//  HWEmotion.m
//  黑马微博2期
//
//  Created by apple on 14-10-22.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HXEmotion.h"

@interface HXEmotion()

@end

@implementation HXEmotion

- (NSImage *)emotionimage {
    _png = [_png stringByDeletingPathExtension];
    NSImage *img = [NSImage imageNamed:_png];
    return img;
}

@end
