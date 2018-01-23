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


class ViewController: NSViewController {
    
    @IBOutlet weak var imageView: NSImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        KingfisherManager.shared.cache.clearMemoryCache()
        KingfisherManager.shared.cache.clearDiskCache()
        
        let url = URL(string: "https://raw.githubusercontent.com/onevcat/Kingfisher/master/images/kingfisher-2.jpg")!
        imageView?.kf.indicatorType = .activity
        imageView.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil) { (image, err, caceType, imageUrl) in
            
            
        }
        
        
        Alamofire.request(url).response { response in // method defaults to `.get`
            debugPrint(response)
        }
        
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

