//
//  HUISelectionBar.swift
//  HChatForMac
//
//  Created by hanxiaoqing on 2018/1/25.
//  Copyright © 2018年 cheng. All rights reserved.
//

import Cocoa

open class HUISelectionBar: NSView {

    let stackView = NSStackView()
  
    
    public override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        stackView.wantsLayer = true
        stackView.orientation = .vertical
        stackView.layer?.backgroundColor = NSColor.white.cgColor
        stackView.distribution = .fillEqually
        addSubview(stackView)
        layoutStackView(stackView)
    
    }
    

    private func layoutStackView(_ sview: NSStackView) {
        sview.translatesAutoresizingMaskIntoConstraints = false
        sview.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        sview.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        sview.topAnchor.constraint(equalTo:topAnchor).isActive = true
        sview.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    
    
    required public init?(coder decoder: NSCoder) {
       super.init(coder: decoder)
        
    }
    
    
    
}
