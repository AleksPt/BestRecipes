//
//  UIImageView+Extension.swift
//  best-recipes-ios
//
//  Created by Vladimir Dmitriev on 03.07.24.
//

import UIKit
import Kingfisher

extension UIImageView {
    func getImage(from url: URL) {
        self.kf.indicatorType = .activity
        self.kf.setImage(
            with: url,
            placeholder: UIImage(named: "defaultCover"),
            options: [
                .transition(.fade(1))
            ]
        )
    }
}
