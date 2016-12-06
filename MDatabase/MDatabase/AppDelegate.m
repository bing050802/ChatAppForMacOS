//
//  AppDelegate.m
//  MDatabase
//
//  Created by MacDev on 16/6/8.
//  Copyright © 2016年 http://www.macdev.io All rights reserved.
//

#import "AppDelegate.h"
#import "MDatabase.h"
#import "PersonDAO.h"
#import "Person.h"
#import "CodeGenerate.h"

#import "HXContactListView.h"
#import "HXSaveContact.h"

#define  kDatabaseName   @"DatabaseDemo.sqlite"

@interface AppDelegate () <NSTextFieldDelegate>

@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *searchField;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    self.window.contentView.wantsLayer = YES;
    
    [HXSaveContact clearAll];
    [HXSaveContact saveContact:@"韩晓清"];
    [HXSaveContact saveContact:@"hanqing"];
    
    
    HXContactListView *listView = [HXContactListView loadXibContactListView];
    listView.wantsLayer = YES;
    listView.layer.backgroundColor = [NSColor purpleColor].CGColor;
    [listView setFrameOrigin:NSMakePoint(30, 50)];
    [self.window.contentView addSubview:listView];
    
    
    
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (void)controlTextDidChange:(NSNotification *)obj {
    NSTextField *textField = obj.object;
    NSLog(@"检索字符----%@",textField.stringValue);
    NSLog(@"----检索结果%@",[HXSaveContact selectNameWithFilteString:textField.stringValue]);
    
}


@end
