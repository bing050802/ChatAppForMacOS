//
//  ChatSummaryCell.swift
//  HChatForMac
//
//  Created by hanxiaoqing on 2018/1/29.
//  Copyright © 2018年 cheng. All rights reserved.
//

import Cocoa

class ChatSummaryCell: NSCollectionViewItem {
    
    @IBOutlet weak var iconView: NSImageView!
    @IBOutlet weak var nameLabel: NSTextField!
    @IBOutlet weak var messageLabel: NSTextField!
    @IBOutlet weak var timeLabel: NSTextField!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        nameLabel.font = NSFont.compactRoundFont(15)
        messageLabel.textColor = .gray
        messageLabel.font = NSFont.compactRoundFont(12)
        timeLabel.textColor = .gray
        timeLabel.font = NSFont.compactRoundFont(11)
        
        messageLabel.stringValue = "好的哈烦得很发到空间阿富汗大家哈哈"
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        
    }
    
    override var isSelected: Bool {
        willSet {
            if newValue == true {
                view.backgroundColor = NSColor(r: 255, g: 240, b: 240)
            } else {
                view.backgroundColor = .white
            }
        }
    }
    
}
