//
//  HUITabBarController.swift
//  HChatForMac
//
//  Created by hanxiaoqing on 2018/1/24.
//  Copyright © 2018年 cheng. All rights reserved.
//

import Cocoa

open class HUITabBarController: NSViewController {

    open var viewControllers: [NSViewController] {
        return self.childViewControllers
    }
    
    open override func loadView() {
        view = NSView()
    }
    
    open func selectViewController(at index: Int) {
        if index > viewControllers.count - 1 { return }
        if selectedViewController == viewControllers[index] { return }
        
        selectedViewController?.view.removeFromSuperview()
        
        let currSelectController = viewControllers[index]
        view.addSubview(currSelectController.view)
        layoutController(currSelectController)
        
        selectedViewController = currSelectController
    }
    
    open var selectedViewController: NSViewController?
    
    private func layoutController(_ controller: NSViewController) {
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        controller.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        controller.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        controller.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        controller.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
}
