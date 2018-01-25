//
//  RecentlyChatViewController.swift
//  HChatForMac
//
//  Created by hanxiaoqing on 2018/1/25.
//  Copyright © 2018年 cheng. All rights reserved.
//

import Cocoa


class ChatInfoCell: NSCollectionViewItem {
    
    override func loadView() {
        view = NSView()
    }
}



class RecentlyChatViewController: NSViewController {

    @IBOutlet weak var recentChatList: NSCollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        recentChatList.register(ChatInfoCell.self, forItemWithIdentifier: NSUserInterfaceItemIdentifier(rawValue: "das"))
        
    }
    override func viewDidLayout() {
        super.viewDidLayout()
        
        
    }
}


extension RecentlyChatViewController: NSCollectionViewDataSource {
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let itemCell = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "das"), for: indexPath)
        itemCell.textField?.stringValue = "da"
        return itemCell
    }
    
    
    
}

extension RecentlyChatViewController: NSCollectionViewDelegate {
    
}
