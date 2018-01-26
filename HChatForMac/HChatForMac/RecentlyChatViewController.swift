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
        view.autoresizingMask = [.maxXMargin, .minXMargin]
        view.backgroundColor = NSColor.red
    }
    override func apply(_ layoutAttributes: NSCollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
       
    }
}



class RecentlyChatViewController: NSViewController {

    @IBOutlet weak var recentChatList: NSCollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        let flowLayout = NSCollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 5
        recentChatList.collectionViewLayout = flowLayout
        recentChatList.register(ChatInfoCell.self, forItemWithIdentifier: NSUserInterfaceItemIdentifier(rawValue: "das"))

        
    }
    override func viewDidLayout() {
        super.viewDidLayout()
        //recentChatList.collectionViewLayout?.inva
    }
}


extension RecentlyChatViewController: NSCollectionViewDataSource {
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return 40
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let itemCell = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "das"), for: indexPath)
        itemCell.textField?.stringValue = "da"
        return itemCell
    }
    
    
    
}

extension RecentlyChatViewController: NSCollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> NSSize {
       return CGSize(width: 400, height: 40)
    }
}


extension RecentlyChatViewController: NSCollectionViewDelegate {
    
}
