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
    
    @IBOutlet weak var leftSideView: NSView!
    @IBOutlet weak var fillBtnsView: NSStackView!
    var lastSelectBtn: HUIButton? = nil
    
    let gradientLayer = CAGradientLayer()
    
    let tabbarController = HUITabBarController()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        leftSideView.backgroundColor = NSColor(r: 219, g: 220, b: 227)


    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        

        gradientLayer.colors = [NSColor(r: 255, g: 99, b: 151).cgColor, NSColor(r: 255, g: 166, b: 108).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x:0.5, y:1);
        gradientLayer.locations = [0.65, 1]
        leftSideView.layer?.insertSublayer(gradientLayer, at: 0)
        
        
        let images = ["message", "contact", "group"]
        let selectImages = ["message_select", "contact_select", "group_select"]
        for index in 0..<3 {
            let btn = HUIButton()
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
        gradientLayer.frame = leftSideView.bounds
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let vc1 = testVc1()
        let vc2 = testVc1()
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

    }
    
    @objc func btnTapped(_ btn: HUIButton) {
        lastSelectBtn?.isSelected = false
        btn.isSelected = true
        // undo: select controller
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

