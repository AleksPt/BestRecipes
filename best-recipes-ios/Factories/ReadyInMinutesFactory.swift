//
//  ReadyInMinutesFactory.swift
//  best-recipes-ios
//
//  Created by Алексей on 10.07.2024.
//

import UIKit

final class ReadyInMinutesFactory {
    static func makeView(label: UILabel) -> UIView {
        let ratingView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 41, height: 25)))
        ratingView.layer.cornerRadius = 8
        
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.layer.cornerRadius = 8
        blurEffectView.clipsToBounds = true
        blurEffectView.frame = ratingView.frame
        
        ratingView.addSubview(blurEffectView)
        blurEffectView.contentView.addSubview(label)
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: blurEffectView.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: blurEffectView.centerXAnchor),
        ])
        
        return ratingView
    }
}
