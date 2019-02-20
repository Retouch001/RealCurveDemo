//
//  UIBezierPathExtension.swift
//  iBreezeeDemo
//
//  Created by Tang Retouch on 2018/10/25.
//  Copyright © 2018 Tang Retouch. All rights reserved.
//

import Foundation

extension UIBezierPath {
    func addBezierThroughPoints(points: [CGPoint]) {
        guard points.count > 0 else { return }
        if points.count < 3 {
            switch points.count {
            case 1:
                addLine(to: points[0])
            case 2:
                addQuadCurve(to: points[1], controlPoint: controlPointForTheBezierCanThrough3Point(point1: currentPoint, point2: points[0], point3: points[1]))
            default:
                break
            }
        }
        
        var previousPoint = CGPoint.zero
        var previousCenterPoint = CGPoint.zero
        var centerPoint = CGPoint.zero
        var centerPointDistance: CGFloat = 0
        var obliqueAngle: CGFloat = 0
        
        var previousControlPoint1 = CGPoint.zero
        var previousControlPoint2 = CGPoint.zero
        var controlPoint1 = CGPoint.zero
        
        previousPoint = currentPoint
        
        for (index, _) in points.enumerated() {
            let point = points[index]
            
            if index > 0 {
                previousCenterPoint = self.centerPoint(of: self.currentPoint, point2: previousPoint);
                centerPoint = self.centerPoint(of: previousPoint, point2: point)
                centerPointDistance = distanceBetweenPoint(point1: previousCenterPoint, point2: centerPoint)
                obliqueAngle = obliqueAngleOfStraightThrough(point1: centerPoint, point2: previousCenterPoint)
                previousControlPoint2 = CGPoint(x: previousPoint.x - 0.5 * 0.7 * centerPointDistance * cos(obliqueAngle),  y: previousPoint.y - 0.5 * 0.7 * centerPointDistance * sin(obliqueAngle))
                controlPoint1 = CGPoint(x: previousPoint.x + 0.5 * 0.7 * centerPointDistance * cos(obliqueAngle), y: previousPoint.y + 0.5 * 0.7 * centerPointDistance * sin(obliqueAngle))
            }
            if index == 1 {
                addQuadCurve(to: previousPoint, controlPoint: previousControlPoint2)
            }
            else if (index > 1 && index < points.count - 1) {
                addCurve(to: previousPoint, controlPoint1: previousControlPoint1, controlPoint2: previousControlPoint2)
            }
            else if (index == points.count - 1) {
                addCurve(to: previousPoint, controlPoint1: previousControlPoint1, controlPoint2: previousControlPoint2)
                addQuadCurve(to: point, controlPoint: controlPoint1)
            }
            else {
                
            }
            previousControlPoint1 = controlPoint1
            previousPoint = point
        }
    }
    
    
    private func controlPointForTheBezierCanThrough3Point(point1 : CGPoint, point2: CGPoint, point3: CGPoint) -> CGPoint {
        return CGPoint(x: 2 * point2.x - (point1.x + point3.x) / 2, y: 2 * point2.y - (point1.y + point3.y) / 2)
    }
    
    private func centerPoint(of point1: CGPoint, point2: CGPoint) -> CGPoint {
        return CGPoint(x: (point1.x + point2.x) / 2, y: (point1.y + point2.y) / 2)
    }
    
    private func distanceBetweenPoint(point1: CGPoint, point2: CGPoint) -> CGFloat {
        return sqrt((point1.x - point2.x) * (point1.x - point2.x) + (point1.y - point2.y) * (point1.y - point2.y))
    }
    
    private func obliqueAngleOfStraightThrough(point1: CGPoint, point2: CGPoint) -> CGFloat {
        var obliqueRatio: CGFloat = 0
        var obliqueAngle: CGFloat = 0
        if point1.x > point2.x {
            obliqueRatio = (point2.y - point1.y) / (point2.x - point1.x)
            obliqueAngle = atan(obliqueRatio)
        }
        else if point1.x < point2.x {
            obliqueRatio = (point2.y - point1.y) / (point2.x - point1.x)
            obliqueAngle = CGFloat(Double.pi) + atan(obliqueRatio)
        }
        else if point2.y - point1.y >= 0 {
            obliqueAngle = CGFloat(Double.pi/2)
        }
        else {
            obliqueAngle = CGFloat(-Double.pi/2)
        }
        return obliqueAngle
    }
}
