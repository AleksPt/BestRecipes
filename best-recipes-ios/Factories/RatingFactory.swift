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
        
        var localImage = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: 12, height: 12)))
        localImage = image
        localImage.contentMode = .scaleAspectFit
        
        let label = UILabel(frame: CGRect(x: 28, y: 3, width: 24, height: 20))
        label.textColor = .white
        label.font = UIFont.PoppinsFont.semibold(size: 14)
        label.text = ratingLabel
        
        ratingView.addSubview(blurEffectView)
        blurEffectView.contentView.addSubview(localImage)
        blurEffectView.contentView.addSubview(label)
        if !blur {
            label.textColor = UIColor.Colors.Neutral.neutral100
            ratingView.addSubview(localImage)
            ratingView.addSubview(label)
        }
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        return ratingView
    }
}
