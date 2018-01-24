//
//  ViewController.swift
//  HChatForMac
//
//  Created by hanxiaoqing on 2018/1/23.
//  Copyright © 2018年 cheng. All rights reserved.
//

import Cocoa
import Kingfisher
import Alamofire
import SnapKit


class ViewController: NSViewController {
    
    @IBOutlet weak var imageView: NSImageView!
    let tabbarController = HUITabBarController()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginBtn = HUIButton(frame: CGRect(x: 30, y: 100, width: 40, height: 50))
        loginBtn.backgroundColor = .purple
        loginBtn.isTrackingEnabled = true
        loginBtn.setTitle("登录", for: .normal)
        loginBtn.setTitleColor(.white, for: .normal)
        loginBtn.setTitleColor(.yellow, for: .mouseIn)
        loginBtn.addTarget(self, action: #selector(btnTapped(_:)), for: .leftMouseUp)
        
        let chatBtn = HUIButton(frame: CGRect(x: 30, y: 100, width: 40, height: 50))
        chatBtn.backgroundColor = .purple
        chatBtn.isTrackingEnabled = true
        chatBtn.setTitle("聊天", for: .normal)
        chatBtn.setTitleColor(.white, for: .normal)
        chatBtn.setTitleColor(.yellow, for: .mouseIn)
        chatBtn.addTarget(self, action: #selector(btnTapped(_:)), for: .leftMouseUp)

        let stackView = NSStackView()
        stackView.wantsLayer = true
        stackView.orientation = .vertical
        stackView.layer?.backgroundColor = NSColor.white.cgColor
        stackView.distribution = .fillEqually
        
        stackView.addArrangedSubview(loginBtn)
        stackView.addArrangedSubview(chatBtn)
        
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(80)
        }
        
        
        
        let vc1 = testVc1()
        vc1.view.backgroundColor = .red
        
        let vc2 = testVc1()
        vc2.view.backgroundColor = .blue
        
        tabbarController.addChildViewController(vc1)
        tabbarController.addChildViewController(vc2)
        view.addSubview(tabbarController.view)
        addChildViewController(tabbarController)
        
        tabbarController.view.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(80)
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        btnTapped(chatBtn)

    }

    @objc func btnTapped(_ btn: HUIButton) {
        var index = 0
        //print(btn.currentTitle)
        if btn.currentTitle == "登录" {
            index = 0
        } else {
            index = 1
        }
        tabbarController.selectViewController(at: index)
    }
    
    func testNetWorking()  {
        KingfisherManager.shared.cache.clearMemoryCache()
        KingfisherManager.shared.cache.clearDiskCache()
        let url = URL(string: "https://raw.githubusercontent.com/onevcat/Kingfisher/master/images/kingfisher-2.jpg")!
        imageView?.kf.indicatorType = .activity
        imageView.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil) { (image, err, caceType, imageUrl) in
            
            
        }
        Alamofire.request(url).response { response in // method defaults to `.get`
            //debugPrint(response)
        }
    }
}

