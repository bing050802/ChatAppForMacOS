//
//  HWEmotionTool.h
//
//  Created by han on 14-10-23.
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
