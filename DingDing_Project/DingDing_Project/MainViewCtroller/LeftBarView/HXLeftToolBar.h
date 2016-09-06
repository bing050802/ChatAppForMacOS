//
//  HXLeftToolBar.h
//  DingDing_Project
//
//  Created by hanxiaoqing on 16/9/6.
//  Copyright © 2016年 HXQ. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface HXLeftToolBar : NSView

+ (HXLeftToolBar *)loadXibLeftToolBar;

@property (copy, nonatomic) NSString *userName;


@end
