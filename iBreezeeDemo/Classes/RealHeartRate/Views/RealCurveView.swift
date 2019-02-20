//
//  RealCurveView.swift
//  iBreezeeDemo
//
//  Created by Tang Retouch on 2018/10/25.
//  Copyright © 2018 Tang Retouch. All rights reserved.
//

import UIKit

class RealCurveView: UIView {
    
    var maxCount = 500
    var averWidth: Double = 0
    var separateCount = 3
    var averHeight: Double = 0
    var leftPoints: [CGPoint] = [CGPoint]()
    var rightPoints: [CGPoint] = [CGPoint]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        averWidth = Double(width/CGFloat(maxCount))
        averHeight = Double(height/3300)
    }
    
    override func draw(_ rect: CGRect) {
        drawCurve(points: leftPoints)
        drawCurve(points: rightPoints)
    }
    
    private func commonInit() {
        backgroundColor = UIColor(hexString: "0d0d0d")
    }
    
    func updateDataSource(with value: Double) {
        if leftPoints.count == maxCount {
            rightPoints = leftPoints
            leftPoints.removeAll()
            rightPoints.removeSubrange(Range(0...separateCount))
        }
        let point = CGPoint(x: CGFloat(leftPoints.count + 1)*CGFloat(averWidth), y: CGFloat(averHeight)*CGFloat(value))
        leftPoints.append(point)
        if rightPoints.count > 0 {
            rightPoints.remove(at: 0)
        }
        setNeedsDisplay()
    }

    private func drawCurve( points: [CGPoint], strokeColor: UIColor = .green) {
        guard points.count > 0 else { return }
        let bezierPath = UIBezierPath()
        bezierPath.lineWidth = 0.6
        bezierPath.lineCapStyle = .round
        bezierPath.lineJoinStyle = .round
        strokeColor.setStroke()
        for (index, value) in points.enumerated() {
            if index == 0 {
                bezierPath.move(to: value)
            }else {
                bezierPath.addLine(to: value)
            }
        }
        bezierPath.stroke()
    }
}
