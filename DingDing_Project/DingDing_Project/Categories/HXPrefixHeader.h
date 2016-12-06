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
#import "NSImageView+WebCache.h"
#import "MJExtension.h"
#import <CoreGraphics/CoreGraphics.h>

/**
 1.熟悉Cocoa框架，以及mac应用相关的UI组件的使用以及个性化自定义
 2.自定义类似IOS TabBar选项卡切换不同的控制器，实现页面切换
 3.实现了mac版本的SDWebImage，用于异步下载网络图片
 4.
 
 */


// 可能有用的第三方

// https://github.com/twitter/twui

// https://github.com/Squirrel/Squirrel.Mac 更新app

// https://github.com/shpakovski/MASShortcut 截屏

// https://github.com/mikeahmarani/MAConfirmButton 动画确认按钮

// https://github.com/danielmj/DJProgressHUD_OSX  Progress and Activity HUD for OSX.

// https://github.com/michaelvillar/chat mac 即时通讯app

// https://github.com/raffael/NSAlert-Popover

// https://github.com/github/Rebel 输入框下面出现 popver

// https://github.com/naftaly/NFSplitViewController

// https://github.com/malcommac/DMSplitView

// IKImageBrowserView。developer.apple.com/library/etc/redirect/xcode/mac/1153/samplecode/ImageBrowserViewAppearance/Introduction/Intro.html

// https://github.com/phaibin/DragDropDemo  拖拽文件到mac app
//https://github.com/davepkennedy/DragTable tableView 拖拽

// https://github.com/void-main/VMMagnifyComparer 图片处理 cgimageref nsimage转换 bitmap之间的关系

// NSImage在读取高DPI图像时的bug及解决方案 http://blog.voidmain.guru/blog/2014/07/13/nsimage-for-high-dpi-images/

// https://github.com/enormego/EGOCache 缓存工具类

//https://github.com/aa703463228/SWAttributedLabel  Use In Mac OS，To show Gif or Images with text
// How an Event Enters a Cocoa Application 苹果官方文档 事件处理


//http://www.tuicool.com/articles/z6naMvZ Mac OS 开发 － 聊聊如何打包dmg文件

//https://github.com/phranck/CNGridView  这个作者搞了很多自定的ui 控件 for mac

// ZYPinYinSearch 拼音模糊搜索

//https://github.com/BokkkRottt/BRDrawer  模仿qq登录界面


#define selfWidth   self.frame.size.width
#define selfHeight  self.frame.size.height
#define selfX       self.frame.origin.x
#define selfY       self.frame.origin.y

// RGB颜色
#define HXColor(r, g, b) [NSColor colorWithCalibratedRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define HXSColor(r, g, b) [NSColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
// 随机色
#define HXRandomColor HXColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))


#define NotificationCenter [NSNotificationCenter defaultCenter]

#define EmotionSelectNotification    @"EmotionSelectNotification"
#define NSWindowClickedNotification  @"NSWindowClickedNotification"
#define ItemSelectedNotification     @"ItemSelectedNotification"


#ifndef __OPTIMIZE__
#define NSLog(...) printf("%f %s\n",[[NSDate date]timeIntervalSince1970],[[NSString stringWithFormat:__VA_ARGS__]UTF8String]);
#endif



