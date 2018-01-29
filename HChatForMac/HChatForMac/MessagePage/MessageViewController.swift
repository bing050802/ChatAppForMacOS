//
//  MessageViewController.swift
//  HChatForMac
//
//  Created by hanxiaoqing on 2018/1/25.
//  Copyright © 2018年 cheng. All rights reserved.
//

import Cocoa

class MessageViewController: NSSplitViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let recentChatVcItem = NSSplitViewItem(viewController: RecentlyChatViewController())
        recentChatVcItem.minimumThickness = 215
        recentChatVcItem.maximumThickness = 300
        addSplitViewItem(recentChatVcItem)
        
        let conversationVcItem = NSSplitViewItem(viewController: ConversationViewController())
        addSplitViewItem(conversationVcItem)
    }
    
}
