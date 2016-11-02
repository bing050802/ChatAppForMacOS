//
//  HWEmotionTool.h
//  黑马微博2期
//
//  Created by apple on 14-10-23.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <AppKit/AppKit.h>
#import "HXEmotion.h"

@interface HXEmotionTool : NSObject



+ (NSArray *)defaultEmotions;
+ (NSArray *)lxhEmotions;


/**
 *  通过表情描述找到对应的表情
 *
 *  @param chs 表情描述
 */
+ (HXEmotion *)emotionWithChs:(NSString *)chs;

@end
