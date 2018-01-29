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
        
        let screenSize = NSScreen.main?.frame.size
        let windowX = (screenSize?.width)! * 0.5 - 150
        let windowY = (screenSize?.height)! * 0.5 - 200
        loginWindow = NSWindow(contentRect: CGRect(x: windowX, y: windowY, width: 300, height: 400), styleMask: [.titled, .closable], backing: .buffered, defer: false)
        loginWindow?.isReleasedWhenClosed = false
        loginWindow?.contentView = NSView()
        loginWindow?.makeKeyAndOrderFront(NSApp)
        
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

