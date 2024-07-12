//
//  UIView + Extension.swift
//  best-recipes-ios
//
//  Created by Алексей on 02.07.2024.
//

import UIKit

extension UIView {
    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        
        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor =  backgroundCGColor
    }
    
    func addGradient() {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        
        gradient.colors = [
            UIColor.black.withAlphaComponent(0.4).cgColor,
            UIColor.clear.cgColor
        ]
        
        gradient.locations = [0.0, 0.7]
        gradient.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 0.0)
        
        if let sublayers = layer.sublayers {
            for layer in sublayers where layer is CAGradientLayer {
                layer.removeFromSuperlayer()
            }
        }
        
        layer.insertSublayer(gradient, at: 0)
    }
}
