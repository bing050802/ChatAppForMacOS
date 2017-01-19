//
//  HWEmotionTool.m
//
//  Created by han on 16-10-23.
//


#import "HXEmotionTool.h"
#import "MJExtension.h"

@implementation HXEmotionTool

static NSMutableArray *_recentEmotions;


+ (HXEmotion *)emotionWithChs:(NSString *)chs
{
    NSArray *defaults = [self defaultEmotions];
    for (HXEmotion *emotion in defaults) {
        if ([emotion.chs isEqualToString:chs]) return emotion;
    }
    
    NSArray *lxhs = [self lxhEmotions];
    for (HXEmotion *emotion in lxhs) {
        if ([emotion.chs isEqualToString:chs]) return emotion;
    }
    
    return nil;
}


static NSArray  *_defaultEmotions, *_lxhEmotions;

+ (NSArray *)defaultEmotions
{
    if (!_defaultEmotions) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"default" ofType:@"plist"];
        _defaultEmotions = [HXEmotion mj_objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _defaultEmotions;
}

+ (NSArray *)lxhEmotions
{
    if (!_lxhEmotions) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"lxh.plist" ofType:nil];
        _lxhEmotions = [HXEmotion mj_objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _lxhEmotions;
}
@end
