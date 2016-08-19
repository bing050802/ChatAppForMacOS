//
//  HXPrefixHeader.h
//  DingDing_Project
//
//  Created by hanxiaoqing on 16/8/9.
//  Copyright © 2016年 HXQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSView+BackGroundColor.h"
#import "PureLayout.h"

// 可能有用的第三方

// https://github.com/twitter/twui

// https://github.com/Squirrel/Squirrel.Mac 更新app

// https://github.com/shpakovski/MASShortcut 截屏

// https://github.com/mikeahmarani/MAConfirmButton 动画确认按钮

// https://github.com/danielmj/DJProgressHUD_OSX  Progress and Activity HUD for OSX.

// https://github.com/michaelvillar/chat mac 即时通讯app

// https://github.com/raffael/NSAlert-Popover

// https://github.com/github/Rebel 输入框下面出现 popver


#define selfWidth   self.frame.size.width
#define selfHeight  self.frame.size.height
#define selfX       self.frame.origin.x
#define selfY       self.frame.origin.y

// RGB颜色
#define HXColor(r, g, b) [NSColor colorWithCalibratedRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
// 随机色
#define HXRandomColor HXColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

