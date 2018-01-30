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
    var mainAppWindow: NSWindow?
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        let loginBoard =  NSStoryboard(name: NSStoryboard.Name("LoginView"), bundle: nil)
        let loginWindowContoller = loginBoard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier("loginWindowContoller")) as! NSWindowController
        loginWindow = loginWindowContoller.window
        loginWindow?.titleVisibility = .hidden
        loginWindow?.titlebarAppearsTransparent = true
        loginWindowContoller.showWindow(nil)
        
        //        let storyBoard =  NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        //        let windowContoller = storyBoard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier("appWindowController")) as! NSWindowController
        //        mainAppWindow = windowContoller.window
        //        mainAppWindow?.titleVisibility = .hidden
        //        mainAppWindow?.titlebarAppearsTransparent = true
        //        windowContoller.showWindow(nil)
        
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        sender.windows.first?.makeKeyAndOrderFront(sender)
        return true
    }
    
}

