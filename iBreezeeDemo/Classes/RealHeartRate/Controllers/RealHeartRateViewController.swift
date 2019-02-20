//
//  RealHeartRateViewController.swift
//  iBreezeeDemo
//
//  Created by Tang Retouch on 2018/10/24.
//  Copyright © 2018 Tang Retouch. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

let wifiConfiguViewController = "WifiConfigViewController"

class RealHeartRateViewController: UIViewController {
    
    @IBOutlet weak var leftBarItem: UIBarButtonItem!
    @IBOutlet weak var realCurveView1: RealView!
    @IBOutlet weak var realCurveView2: RealView!
    
    let dataAgent = DataAgent()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        dataAgent.connectHandle = {[weak self] in
            self?.leftBarItem.title = "Stop"
        }
        dataAgent.disconnectHandle = {[weak self] in
            self?.dataAgent.stopDriveCurveView()
            self?.leftBarItem.title = "ReConnect"
            MBProgressHUD.showMessage(message: "连接失败或连接断开")
        }
    }
    
    @IBAction func start(_ sender: Any) {
        if leftBarItem.title == "Stop" {
            leftBarItem.title = "Disconnecting"
            Socket.share.send(data: endData)
        }else {
            leftBarItem.title = "Connecting"
            Socket.share.connect(toHost: host, onPort: port) { (error) in
            }
            dataAgent.startDriveCurveView {(value1, value2) in
                self.realCurveView1.realCurveView.updateDataSource(with: value1)
                self.realCurveView2.realCurveView.updateDataSource(with: value2)
            }
        }

    }
    
    @IBAction func unwindToRootViewController(segue: UIStoryboardSegue) {
        
    }
    
    private func setupSubViews() {
        realCurveView1.titleLabel.text = "通道一波形"
        realCurveView2.titleLabel.text = "通道二波形"
    }
    
    private func gotoWifiConfiguration() {
        let wifiConfigVC = UIStoryboard.main?.instantiateViewController(withIdentifier: wifiConfiguViewController)
        present(wifiConfigVC!, animated: true, completion: nil)
    }
    
}

//        showAlert(title: "Tips", message: "The system seems to detect that you are not connected to the sleep zone wifi, please connect to the device's wifi first, and then to the data for viewing.", buttonTitles: ["OK"], highlightedButtonIndex: 0, completion: { (index) in
//            self.gotoWifiConfiguration()
//        })
//        Socket.share.connect(toHost: host, onPort: port) { (error) in
//            if let _ = error {
//
//            }
//        }






