//
//  LoginViewController.swift
//  HChatForMac
//
//  Created by hanxiaoqing on 2018/1/30.
//  Copyright © 2018年 cheng. All rights reserved.
//

import Cocoa

class LoginViewController: NSViewController {
    
    @IBOutlet weak var nameField: NSTextField!
    @IBOutlet weak var passwordField: NSSecureTextField!
    @IBOutlet weak var loginBtn: HUIButton!
    @IBOutlet weak var stackView: NSStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameField.font = .compactRoundFont(15)
        passwordField.font = .compactRoundFont(15)
        
        loginBtn.wantsLayer = true
        loginBtn.set(background: NSColor(r: 248, g: 145, b: 182), for: .normal)
        loginBtn.titleLabel?.font = .compactRoundFont(15)
        loginBtn.setTitleColor(.white, for: .normal)
        loginBtn.setTitle("Login", for: .normal)
        loginBtn.addTarget(self, action: #selector(loginAction(_:)), for: .leftMouseUp)
        
    }
    
    @objc func loginAction(_ btn: HUIButton) {
        
    }
}
