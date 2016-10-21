//
//  AppDelegate.m
//  NSImage相关的处理
//
//  Created by hanxiaoqing on 2016/9/26.
//  Copyright © 2016年 Babeltime. All rights reserved.
//

#import "AppDelegate.h"
#import <AppKit/AppKit.h>
#import "NSImageView+WebCache.h"

#import "TopView.h"
#import "BottomView.h"

//About High Resolution for OS X  苹果文档
//http://www.tuicool.com/articles/ARFjei6 详细解读 sdwebimage 源码
//http://blog.csdn.net/sodaslay/article/details/10050039  将一个NSImage实例保存成图片文件 


@interface AppDelegate ()


@property (weak) IBOutlet BottomView *bView;
@property (weak) IBOutlet TopView *tView;

@property (weak) IBOutlet NSImageView *ImageView;
@property (weak) IBOutlet NSWindow *window;

@end

@implementation AppDelegate

//    http://wimg.spriteapp.cn/profile/large/2014/10/30/5451e3a254ff2_mini.jpg
//    http://ww2.sinaimg.cn/bmiddle/005OPWbujw1eltkcrcuoag306w05vkjl.gif
//    http://imgstore.cdn.sogou.com/app/a/100540002/834169.jpg
//    http://pic36.nipic.com/20131217/6704106_233034463381_2.jpg
//    http://d.lanrentuku.com/down/png/1512/2015sdj/2015sdj_004.png


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {

//    NSImage *gif = [NSImage imageNamed:@"test"];
//    self.ImageView.image  = gif;
    self.ImageView.animates = YES;
    self.ImageView.canDrawSubviewsIntoLayer = YES;
    
    
//    [[SDImageCache sharedImageCache] clearDisk];
//    [self.ImageView sd_setImageWithURL:@"http://ww2.sinaimg.cn/bmiddle/005OPWbujw1eltkcrcuoag306w05vkjl.gif"];
    [self.ImageView sd_setImageWithURL:@"http://d.lanrentuku.com/down/png/1512/2015sdj/2015sdj_004.png" placeholderImage:[NSImage imageNamed:@"test"] options:SDWebImageCircledImage];
    
    
    [self.tView setWantsLayer:YES];
    self.tView.layer.backgroundColor = [NSColor purpleColor].CGColor;
    self.tView.acceptsTouchEvents = NO;
    
    [self.window makeFirstResponder:self.tView];
    
    [self.bView setWantsLayer:YES];
    self.bView.layer.backgroundColor = [NSColor yellowColor].CGColor;
    
    
    
    

}



- (void)chatData {
    
    NSDictionary *dic = @{@"name" : @"",
                          @"iconUrl" : @"",
                          @"msgTime" : @"",
                          };
    
    
}




- (void)test {
//    AsyncImageDownloader *downLoader = [[AsyncImageDownloader alloc] initWithMediaURL:@"http://imgstore.cdn.sogou.com/app/a/100540002/834169.jpg" successBlock:^(NSImage *image) {
//        
//        self.ImageView.image = image;
//        //         NSLog(@"%zd",[self giftImage:image].TIFFRepresentation.length);
//        
//    } failBlock:^(NSError *error) {
//        
//    }];
//    [downLoader startDownload];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    
}

@end
