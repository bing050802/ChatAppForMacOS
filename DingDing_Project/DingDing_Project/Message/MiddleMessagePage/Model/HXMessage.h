//
//  HXMessage.h
//  DingDing_Project
//
//  Created by han on 2016/9/25.
//  Copyright © 2016年 HXQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXMessage : NSObject

// 消息时间
@property (nonatomic, strong) NSString *create_time;

// 用户名字
@property (nonatomic, strong) NSString *name;

// 用户头像
@property (nonatomic, strong) NSString *profile_image;

// 消息内容
@property (nonatomic, strong) NSString *text;

// gif图片第一帧 图片
@property (nonatomic, strong) NSString *gifFistFrame;



@end
