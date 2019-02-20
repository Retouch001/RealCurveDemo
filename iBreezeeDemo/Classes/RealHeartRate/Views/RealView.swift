//
//  RealView.swift
//  iBreezeeDemo
//
//  Created by Tang Retouch on 2018/11/5.
//  Copyright © 2018 Tang Retouch. All rights reserved.
//

import UIKit
import SnapKit

class RealView: UIView {
    
    var shouldSetupConstraints = true
    var titleLabel: UILabel!
    var fullScreenBtn: UIButton!
    var filterBtn: UIButton!
    var topView: UIView!
    var realCurveView: RealCurveView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        addConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        addConstraints()
    }
    
    private func addConstraints() {
        topView.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.left.right.top.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.top.bottom.equalToSuperview()
        }
        
        fullScreenBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-10)
            make.top.bottom.equalToSuperview().inset(12)
            make.width.equalTo(fullScreenBtn.snp.height)
        }
        
        filterBtn.snp.makeConstraints { (make) in
            make.right.equalTo(fullScreenBtn.snp.left).offset(-30)
            make.top.bottom.equalToSuperview().inset(12)
            make.width.equalTo(filterBtn.snp.height)
        }
        
        realCurveView.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    private func commonInit() {
        topView = UIView()
        topView.backgroundColor = UIColor(hexString: "0d0d0d")
        addSubview(topView)
        
        titleLabel = UILabel()
        titleLabel.text = "通道一波形"
        titleLabel.font = UIFont.systemFont(ofSize: 17)
        titleLabel.textColor = .red
        topView.addSubview(titleLabel)
        
        fullScreenBtn = UIButton(type: .custom)
        fullScreenBtn.setImage(UIImage(named: "全屏"), for: .normal)
        fullScreenBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        topView.addSubview(fullScreenBtn)
        
        filterBtn = UIButton(type: .custom)
        filterBtn.setImage(UIImage(named: "滤波"), for: .normal)
        filterBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        topView.addSubview(filterBtn)
        
        realCurveView = RealCurveView()
        addSubview(realCurveView)
    }
}
