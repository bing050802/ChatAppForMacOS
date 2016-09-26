//
//  AppDelegate.m
//  NSImage相关的处理
//
//  Created by hanxiaoqing on 2016/9/26.
//  Copyright © 2016年 Babeltime. All rights reserved.
//

#import "AppDelegate.h"
#import "VMBrushImageView.h"
#import "AsyncImageDownloader.h"

#import <AppKit/AppKit.h>

//https://github.com/orta/GIFs  gif 图片搜索下载 处理展示

//https://github.com/esten/VineGifR  生成 gif 支持 10.10以下

//About High Resolution for OS X  苹果文档

@interface AppDelegate ()

@property (weak) IBOutlet NSImageView *ImageView;

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
//    http://wimg.spriteapp.cn/profile/large/2014/10/30/5451e3a254ff2_mini.jpg
//    http://ww2.sinaimg.cn/bmiddle/005OPWbujw1eltkcrcuoag306w05vkjl.gif
//    http://imgstore.cdn.sogou.com/app/a/100540002/834169.jpg
    
    
    AsyncImageDownloader *downLoader = [[AsyncImageDownloader alloc] initWithMediaURL:@"http://imgstore.cdn.sogou.com/app/a/100540002/834169.jpg" successBlock:^(NSImage *image) {

        self.ImageView.image = image;
//         NSLog(@"%zd",[self giftImage:image].TIFFRepresentation.length);
        
    } failBlock:^(NSError *error) {
        
    }];
    [downLoader startDownload];
    
    NSImage *gif = [NSImage imageNamed:@"demo_brush.gif"];
    self.ImageView.image  = gif;
    self.ImageView.animates = YES;
    self.ImageView.canDrawSubviewsIntoLayer = YES;

}








- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
