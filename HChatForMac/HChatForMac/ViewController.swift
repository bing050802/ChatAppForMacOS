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
    
    @IBOutlet weak var topView: NSView!
    @IBOutlet weak var leftSideView: NSView!
    @IBOutlet weak var fillBtnsView: NSStackView!
    
    fileprivate let leftGradientLayer = CAGradientLayer()
    fileprivate let topGradientLayer = CAGradientLayer()
    fileprivate let tabbarController = HUITabBarController()
    fileprivate var lastSelectBtn: HUIButton? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        topGradientLayer.colors = [NSColor(r: 255, g: 99, b: 151).cgColor, NSColor(r: 255, g: 166, b: 108).cgColor]
        topGradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        topGradientLayer.endPoint = CGPoint(x:0.5, y:1);
        topGradientLayer.locations = [0.35, 1]
        view.layer?.insertSublayer(topGradientLayer, at: 0)
        
        
        let images = ["message", "contact", "group"]
        let selectImages = ["message_select", "contact_select", "group_select"]
        for index in 0..<3 {
            let btn = HUIButton()
            btn.viewTag = index
            btn.isHighlightedEnabled = false
            let normalImg = NSImage(named: NSImage.Name(images[index]))
            let selectImg = NSImage(named: NSImage.Name(selectImages[index]))
            btn.setImage(normalImg, for: .normal)
            btn.setImage(selectImg, for: .selected)
            btn.addTarget(self, action: #selector(btnTapped(_:)), for: .leftMouseUp)
            fillBtnsView.addArrangedSubview(btn)
            if index == 0 { btnTapped(btn) }
        }
        
    }
    
    
    override func viewDidLayout() {
        super.viewDidLayout()
        topGradientLayer.frame = view.bounds
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = MessageViewController()
        let vc2 = MessageViewController()
        let vc3 = MessageViewController()
        tabbarController.addChildViewController(vc1)
        tabbarController.addChildViewController(vc2)
        tabbarController.addChildViewController(vc3)
        view.addSubview(tabbarController.view)
        addChildViewController(tabbarController)
        tabbarController.view.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(68)
            make.right.equalToSuperview()
            make.top.equalToSuperview().offset(50)
            make.bottom.equalToSuperview()
        }
    }
    
    @objc func btnTapped(_ btn: HUIButton) {
        lastSelectBtn?.isSelected = false
        btn.isSelected = true
        // undo: select controller
        tabbarController.selectViewController(at: btn.viewTag)
        lastSelectBtn = btn
    }
    
    func testNetWorking()  {
        let imageView: NSImageView =  NSImageView()
        KingfisherManager.shared.cache.clearMemoryCache()
        KingfisherManager.shared.cache.clearDiskCache()
        let url = URL(string: "https://raw.githubusercontent.com/onevcat/Kingfisher/master/images/kingfisher-2.jpg")!
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil) { (image, err, caceType, imageUrl) in
        }
        Alamofire.request(url).response { response in // method defaults to `.get`
            //debugPrint(response)
        }
    }
}

