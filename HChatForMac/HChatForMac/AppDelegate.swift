//
//  AppDelegate.swift
//  HChatForMac
//
//  Created by hanxiaoqing on 2018/1/23.
//  Copyright © 2018年 cheng. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var loginWindow: NSWindow?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
       
        loginWindow = NSWindow(contentRect:  CGRect(x: 0, y: 0, width: 200, height: 300), styleMask: [.titled, .closable], backing: .buffered, defer: false)
        loginWindow?.contentView = NSView()
        loginWindow?.minSize = CGSize(width: 200, height: 300)
        loginWindow?.maxSize = CGSize(width: 200, height: 300)
        loginWindow?.makeKeyAndOrderFront(NSApp)
        
        
        
//        let appWindow = NSApp.windows.first as! NSWindow
//        appWindow.titleVisibility = .hidden
//        appWindow.titlebarAppearsTransparent = true
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        sender.windows.first?.makeKeyAndOrderFront(sender)
        return true
    }
    
}

