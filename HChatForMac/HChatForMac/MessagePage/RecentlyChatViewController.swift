//
//  RecentlyChatViewController.swift
//  HChatForMac
//
//  Created by hanxiaoqing on 2018/1/25.
//  Copyright © 2018年 cheng. All rights reserved.
//

import Cocoa

class TableViewLayout: NSCollectionViewFlowLayout {
    override init() {
        super.init()
        scrollDirection = .vertical
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func prepare() {
        super.prepare()
        
    }
    
    override func layoutAttributesForElements(in rect: NSRect) -> [NSCollectionViewLayoutAttributes] {
         let layoutAttributes = super.layoutAttributesForElements(in: rect)
         return layoutAttributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: NSRect) -> Bool {
        return false
    }
}


class RecentlyChatViewController: NSViewController {

    @IBOutlet weak var recentChatList: NSCollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        recentChatList.register(ChatSummaryCell.self, forItemWithIdentifier: NSUserInterfaceItemIdentifier(rawValue: "ChatSummaryCell"))
        recentChatList.collectionViewLayout = TableViewLayout()

    }
    
    
    override func viewDidLayout() {
        super.viewDidLayout()
        recentChatList.performBatchUpdates({}, completionHandler: nil)
    }
}


extension RecentlyChatViewController: NSCollectionViewDataSource {
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let itemCell = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "ChatSummaryCell"), for: indexPath)
        return itemCell
    }
}

extension RecentlyChatViewController: NSCollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> NSSize {
        return CGSize(width: collectionView.frame.size.width, height: 55)
    }
}


extension RecentlyChatViewController: NSCollectionViewDelegate {
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        
    }
}
