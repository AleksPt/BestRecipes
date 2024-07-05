//
//  TabBar.swift
//  best-recipes-ios
//
//  Created by  Maksim Stogniy on 02.07.2024.
//

import UIKit

@IBDesignable
class TabBar: UITabBar {
    
    private var shapeLayer: CALayer?
    
    override func draw(_ rect: CGRect) {
        self.addShape()
    }
    
    private func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPathCircle()
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 1.0
        
        shapeLayer.shadowOffset = CGSize(width: 0, height: 0)
        shapeLayer.shadowRadius = 10
        shapeLayer.shadowColor = UIColor.gray.cgColor
        shapeLayer.shadowOpacity = 0.3
        
        if let oldShapeLayer = self.shapeLayer {
            self.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            self.layer.insertSublayer(shapeLayer, at: 0)
        }
        self.shapeLayer = shapeLayer
    }
    
    func createPathCircle() -> CGPath {
        let curve: CGFloat = 30.0
        let path = UIBezierPath()
        let center = self.frame.width / 2
        
        path.move(to: CGPoint (x: 0, y: 0))
        path.addLine(to: CGPoint(x: center - (curve * 2), y: 0))
        path.addQuadCurve(
            to: CGPoint(x: center - curve, y: curve / 2),
            controlPoint: CGPoint(x: center - curve - curve / 7.5, y: 0)
        )
        path.addCurve(
            to: CGPoint(x: center + curve, y: curve / 2),
            controlPoint1: CGPoint(x: center - curve + curve / 4, y: curve + curve / 2),
            controlPoint2: CGPoint(x: center + curve - curve / 4, y: curve + curve / 2)
        )
        path.addQuadCurve(
            to: CGPoint(x: center + (curve * 2), y: 0),
            controlPoint: CGPoint(x: center + curve + curve / 7.5, y: 0)
        )
        path.addLine(to: CGPoint(x: self.bounds.width, y: 0))
        path.addLine(to: CGPoint(x: self.bounds.width, y: self.bounds.height))
        path.addLine(to: CGPoint(x: 0, y: self.bounds.height))
        path.close()
        return path.cgPath
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard !clipsToBounds && !isHidden && alpha > 0 else { return nil }
        for member in subviews.reversed() {
            let subPoint = member.convert(point, from: self)
            guard let result = member.hitTest(subPoint, with: event) else { continue }
            return result
        }
        return nil
    }
}
