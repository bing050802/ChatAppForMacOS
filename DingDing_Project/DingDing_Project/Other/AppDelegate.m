//
//  AppDelegate.m
//  DingDing_Project
//
//  Created by hanxiaoqing on 16/8/9.
//  Copyright © 2016年 Babeltime. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
/**
     自己创建app window的方法
 
     NSRect frame = NSMakeRect([NSScreen mainScreen].frame.size.width/2 -250, [NSScreen mainScreen].frame.size.height/2 -250, 500, 500);
     
     NSWindow *window = [[NSWindow alloc] initWithContentRect:frame
     styleMask:NSTitledWindowMask
     backing:NSBackingStoreBuffered
     defer:NO
     screen:[NSScreen mainScreen]];
     [window setStyleMask:[window styleMask] | NSResizableWindowMask];
     
     CGSize fixedSize = CGSizeMake(500, 500);
     [window setMinSize:fixedSize];
     [window setMaxSize:fixedSize];
     
     [window setBackgroundColor:[NSColor grayColor]];
     [window makeKeyAndOrderFront:NSApp ];
     
     
     ButtonViewController *buttonVC = [[ButtonViewController alloc] init];
     if (buttonVC){
     [window setContentView:buttonVC.view];
     }
     
     
     self.window = window;
     self.initialVC = buttonVC;
 */

- (void)applicationWillFinishLaunching:(NSNotification *)notification {
    
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
   
    
}

- (void)allNotifiction:(NSNotification *)noti {
//    NSLog(@"----%@",noti.name);
}



- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
