//
//  HWEmotion.h
//  黑马微博2期
//
//  Created by apple on 14-10-22.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <AppKit/AppKit.h>

@interface HXEmotion : NSObject
/** 表情的文字描述 */
@property (nonatomic, copy) NSString *chs;
/** 表情的png图片名 */
@property (nonatomic, copy) NSString *png;
/** 表情的png*/
@property (nonatomic,strong,readonly) NSImage *emotionimage;
@end
