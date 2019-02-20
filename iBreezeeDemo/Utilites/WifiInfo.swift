//
//  WiFiInfo.swift
//  iBreezeeDemo
//
//  Created by Tang Retouch on 2018/10/24.
//  Copyright © 2018 Tang Retouch. All rights reserved.
//

import Foundation
import NetworkExtension
import SystemConfiguration.CaptiveNetwork

class WifiInfo {
    /// Get connected wifi info 仅可获取设备当前所连接的 WiFi 信息
    ///
    /// - Returns: ssid and mac info
    static func getConnectedWifiInfo() -> (ssid: String, mac: String) {
        if let cfas: NSArray = CNCopySupportedInterfaces() {
            for cfa in cfas {
                if let dict = CFBridgingRetain(CNCopyCurrentNetworkInfo(cfa as! CFString)) {
                    if let ssid = dict["SSID"] as? String, let bssid = dict["BSSID"] as? String {
                        return (ssid, bssid)
                    }
                }
            }
        }
        return ("Unknown", "Unknown")
    }
    
    
    /// Connect the open wifi
    ///
    /// - Parameters:
    ///   - username: username
    ///   - password: password
    static func connectWifi(username: String, completHandle: @escaping (Error?) -> Void) {
        guard #available(iOS 11.0, *) else { return }
        NEHotspotConfigurationManager.shared.apply(NEHotspotConfiguration(ssid: username)) { (error) in
            completHandle(error)
        }
    }
    
    
    /// 扫描附近的所有WiFi并读取其中的详细信息(此法需要申请的权限较多，配置过程也相当复杂，详情请看文档)
    static func scanWifiInfos() {
        let _ = NEHotspotHelper.register(options: nil, queue: DispatchQueue(label: "com.ibreezeeDemo.test")) { (cmd) in
            if cmd.commandType == .evaluate || cmd.commandType == .filterScanList {
                cmd.networkList?.forEach({ (network) in
                    printLog("SSID:\(network.ssid)\nMac:\(network.bssid)\n信号强度:\(network.signalStrength)\nCommandType:\(cmd.commandType)")
                })
            }
        }
    }
    
    
}



