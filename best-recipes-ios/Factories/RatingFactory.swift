//
//  RatingFactory.swift
//  best-recipes-ios
//
//  Created by Vadim Zhelnov on 2.07.24.
//

import UIKit

final class RatingFactory {
    static func makeSavedTrandingRating(image:UIImageView, ratingLabel:String, blur:Bool = true) -> UIView {
        let ratingView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 58, height: 28)))
        ratingView.layer.cornerRadius = 10
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.layer.cornerRadius = 10
        blurEffectView.clipsToBounds = true
        blurEffectView.frame = ratingView.frame
        
        let localImage = image
        localImage.contentMode = .scaleAspectFit
        localImage.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.textColor = blur ? UIColor.Colors.Rating.ratingWhite : UIColor.Colors.Rating.ratingBlack
        label.font = UIFont.PoppinsFont.semibold(size: 14)
        label.text = ratingLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        
        ratingView.addSubview(blurEffectView)
        blurEffectView.contentView.addSubview(localImage)
        blurEffectView.contentView.addSubview(label)
        if !blur {
            label.textColor = UIColor.Colors.Neutral.neutral100
            ratingView.addSubview(localImage)
            ratingView.addSubview(label)
        }
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            localImage.centerYAnchor.constraint(equalTo: blurEffectView.centerYAnchor),
            localImage.leadingAnchor.constraint(equalTo: blurEffectView.leadingAnchor, constant: 8),
            localImage.widthAnchor.constraint(equalToConstant: 16),
            localImage.heightAnchor.constraint(equalToConstant: 16),
            
            label.centerYAnchor.constraint(equalTo: blurEffectView.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: localImage.trailingAnchor, constant: 3),
            label.trailingAnchor.constraint(equalTo: blurEffectView.trailingAnchor, constant: -8),
        ])
        
        return ratingView
    }
}
