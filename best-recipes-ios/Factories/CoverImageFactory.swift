//
//  CoverImageFactory.swift
//  best-recipes-ios
//
//  Created by Алексей on 03.07.2024.
//

import UIKit

final class CoverImageFactory {
    static func makeCoverImageView(image: UIImage) -> UIImageView {
        let element = UIImageView()
        element.image = image
        element.contentMode = .scaleAspectFill
        element.clipsToBounds = true
        element.translatesAutoresizingMaskIntoConstraints = false
        element.layer.cornerRadius = 10
        return element
    }
}
