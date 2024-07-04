//
//  RecipesType.swift
//  best-recipes-ios
//
//  Created by Sergey Zakurakin on 03/07/2024.
//

import UIKit


enum RecipesType {
    case tradingNow(String, String, UIImage)
    case recentRecipe(String, String, UIImage)
    case popularCreators(String, String, UIImage)
}
