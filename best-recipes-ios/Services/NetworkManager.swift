//
//  NetworkManager.swift
//  best-recipes-ios
//
//  Created by Vladimir Dmitriev on 02.07.24.
//

import Foundation

enum Link {
    case recipesURL(offset: Int, number: Int)
    case recipeDetailsURL(recipeID: Int)
    case ingredientImageURL(imageName: String)
    
    private var apiKey: String {
        "6422cff154a64782a341a0356afd3ec6"
    }
    
    var url: URL {
        switch self {
        case .recipesURL(let offset, let number):
            return URL(string: "https://api.spoonacular.com/recipes/complexSearch?apiKey=\(apiKey)&addRecipeInformation=true&offset=\(offset)&number=\(number)")!
        case .recipeDetailsURL(let id):
            return URL(string: "https://api.spoonacular.com/recipes/\(id)/information?apiKey=\(apiKey)")!
        case .ingredientImageURL(let imageName):
            return URL(string: "https://img.spoonacular.com/ingredients_100x100/\(imageName)")!
        }
    }
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}
