//
//  Fonts.swift
//  best-recipes-ios
//
//  Created by Алексей on 01.07.2024.
//

import UIKit

enum FontsWeight: String {
    case poppinsBold = "Poppins-Bold"
    case poppinsRegular = "Poppins-Regular"
}

extension UIFont {
    static func poppins(size: CGFloat, weight: FontsWeight) -> UIFont {
        guard let font = UIFont(name: weight.rawValue, size: size) else {
            print("шрифт не найден")
            return .systemFont(ofSize: size)
        }
        return font
    }
}
