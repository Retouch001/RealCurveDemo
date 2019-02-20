//
//  GlobalConfiguration.swift
//  iBreezeeDemo
//
//  Created by Tang Retouch on 2018/10/24.
//  Copyright © 2018 Tang Retouch. All rights reserved.
//

import Foundation
import UIKit
import SwifterSwift

func printLog<T>(_ message: T,
                    file: String = #file,
                    method: String = #function,
                    line: Int = #line)
{
    #if DEBUG
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm:ss"
    print("Log: \(dateFormatter.string(from: Date())) \((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
    #endif
}


public let kNavBarHeight : CGFloat = 44
public let kScreenWidth = UIScreen.main.bounds.width
public let kScreenHeight = UIScreen.main.bounds.height
public let kStatusBarHeight = UIApplication.shared.statusBarFrame.height
public let kTopBarHeight: CGFloat = 44 + kStatusBarHeight
public let kTabBarHeight: CGFloat =  kStatusBarHeight>20 ? 83 : 49


// MARK: - Typealias
public typealias CommonHandler = (() -> Void)
public typealias CommonCompletion = () -> Void


class Config {
    static let appGroupID   = "group.xyz.atuo.notGIF"
    
    static let defaultTagID = "not.all.gif.tagId"
    
    static let urlScheme    = "notGIF://"
    
    static let appleID      = "1069688631"
    
    static let appStoreCommentURL = "itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=\(Config.appleID)&pageNumber=0&sortOrdering=2&mt=8"
    
    static let reportEmail  = "aaatuooo@gmail.com"
    
    static var isChinese: Bool {
        return Locale.current.languageCode == "zh"
    }
    
    static var version: String {
        let info = Bundle.main.infoDictionary
        return info?["CFBundleShortVersionString"] as? String ?? "Unknown"   // kCFBundleVersionKey
    }
}


extension UIColor{
    //基色F1F0EF
    static let base = UIColor(hex: 0xF1F0EF)
    static let base1 = UIColor(hex: 0xF9F9F9)

    //主题色EF8A3F
    static let theme = UIColor(hex: 0xff8324)
    //cell色FFFEFD
    static let cell = UIColor(hex: 0xFFFEFD)
    //分割线色F5F4F3
    static let separatorLine =  UIColor(hex: 0xF5F4F3)
    //按钮不可点击颜色
    static let unableBtn = UIColor(hex: 0xDDDFE5)
}
