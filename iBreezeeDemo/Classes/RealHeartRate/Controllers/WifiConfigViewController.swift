//
//  WifiConfigViewController.swift
//  iBreezeeDemo
//
//  Created by Tang Retouch on 2018/10/26.
//  Copyright © 2018 Tang Retouch. All rights reserved.
//

import UIKit

class WifiConfigViewController: UIViewController {
    @IBOutlet weak var wifiNameTf: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func startConnecting(_ sender: Any) {
//        guard wifiNameTf.text!.hasPrefix("AP_iBreezee") else {
//            MBProgressHUD.showMessage(message: "请填入正确的WiFi名称")
//            return
//        }
        
        MBProgressHUD.showLoding(message: "正在连接...")
        WifiInfo.connectWifi(username: wifiNameTf.text!) { (error) in
            MBProgressHUD.dissmiss()
            if let error = error {
                MBProgressHUD.showMessage(message: error.localizedDescription)
                printLog("连接失败\(error)")
            }
            else {
                MBProgressHUD.showMessage(message: "连接成功")
                self.dismiss(animated: true, completion: nil)
                printLog("连接成功")
            }
        }
    }
}
