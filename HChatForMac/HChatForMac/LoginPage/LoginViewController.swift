//
//  LoginViewController.swift
//  HChatForMac
//
//  Created by hanxiaoqing on 2018/1/30.
//  Copyright © 2018年 cheng. All rights reserved.
//

import Cocoa
import Alamofire
import SocketIO

class UserModel: HandyJSON {
    let name: String? = nil
    let userID: String? = nil
    let roomID: String? = nil
    let avatarURL: String? = nil
    required init() {}
}


let baseHost: String = "http://192.168.88.57:3000/spika/v1"

class LoginViewController: NSViewController {
    
    @IBOutlet weak var nameField: NSTextField!
    @IBOutlet weak var passwordField: NSSecureTextField!
    @IBOutlet weak var loginBtn: HUIButton!
    @IBOutlet weak var stackView: NSStackView!
    
    var currentUser: UserModel!
    var currentUserToken: String?
    
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
    
    let manager = SocketManager(socketURL: URL(string: "http://192.168.88.57:3000/spika")!, config: [.log(false), .compress])

    @objc func loginAction(_ btn: HUIButton) {
        let loginParams: Parameters = ["userID": "3333", "roomID": "daye3", "name": "handaye"]
        currentUser = UserModel.deserialize(from: loginParams)!
        
        Alamofire.request(baseHost + "/user/login", method: .post, parameters: loginParams, encoding:JSONEncoding.default).responseJSON { response in
            let resDic = response.result.value as! [String : Any]
            print(resDic)
            let data = resDic["data"] as! [String : Any]
            //let user = data["user"] as! [String : Any]
            self.currentUserToken = data["token"] as? String
           
            let socket = self.manager.defaultSocket
            
            socket.on(clientEvent: .connect, callback: { (data, ack) in
                print("socket connect")
            })
            socket.connect()

            socket.emit("login", with: [loginParams])
            
            socket.on("newMessage", callback: { (data, ack) in
                let resDict = data as [ Any]
                 print(resDict)
            })
          
            
            let headers: HTTPHeaders = ["access-token": self.currentUserToken!]
            Alamofire.request(baseHost + "/message/list/\(self.currentUser.roomID!)/0" , method: .get, encoding:JSONEncoding.default,headers: headers).responseJSON { response in
                let resDic = response.result.value
                print(resDic)
            }
            
        
        }
    }
}
