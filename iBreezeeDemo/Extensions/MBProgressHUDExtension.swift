//
//  MBProgressHUDExtension.swift
//  iBreezeeDemo
//
//  Created by Tang Retouch on 2018/10/29.
//  Copyright © 2018 Tang Retouch. All rights reserved.
//

import Foundation


public extension MBProgressHUD {
    public static func showMessage(message: String) {
        let hud = MBProgressHUD.showAdded(to: ((UIApplication.shared.delegate?.window)!)!, animated: true)
        //hud.label.textColor = UIColor.white
        hud.label.font = UIFont.systemFont(ofSize: 15)
        //hud.bezelView.color = UIColor.black
        //hud.contentColor = UIColor.white
        hud.bezelView.style = .blur
        hud.margin = 15
        hud.mode = .text
        hud.label.text = message
        hud.hide(animated: true, afterDelay: 1.5)
    }
    
    public static func showLoding(message: String? = nil) {
        let hud = MBProgressHUD.showAdded(to: ((UIApplication.shared.delegate?.window)!)!, animated: true)
        //hud.label.textColor = UIColor.white
        hud.label.font = UIFont.systemFont(ofSize: 15)
        //hud.bezelView.color = UIColor.black
        //hud.contentColor = UIColor.white
        hud.bezelView.style = .blur
        hud.margin = 15
        hud.label.text = message
    }
    
    public class func dissmiss() {
        hide(for: ((UIApplication.shared.delegate?.window)!)!, animated: true)
    }
    
}
