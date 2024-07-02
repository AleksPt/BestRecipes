//
//  Recipe.swift
//  best-recipes-ios
//
//  Created by Vladimir Dmitriev on 02.07.24.
//

import Foundation

struct ComplexSearch: Decodable {
    let results: [Recipe]
    let offset: Int
    let number: Int
    let totalResults: Int
}

struct Recipe: Decodable {
    let sourceName: String
    let extendedIngredients: [Ingredient]?
    let id: Int
    let title: String
    let readyInMinutes: Int
    let servings: Int
    let image: String
    let cuisines: [String]
    let dishTypes: [String]
    let analyzedInstructions: [AnalyzedInstruction]?
    let aggregateLikes: Int
    let spoonacularScore: Double
    var isFavorite: Bool?
    
    var imageURL: URL {
        URL(string: image)!
    }

    init(
        sourceName: String,
        extendedIngredients: [Ingredient],
        id: Int,
        title: String,
        readyInMinutes: Int,
        servings: Int,
        image: String,
        cuisines: [String],
        dishTypes: [String],
        analyzedInstructions: [AnalyzedInstruction],
        aggregateLikes: Int,
        spoonacularScore: Double,
        isFavorite: Bool? = false
    ) {
        self.sourceName = sourceName
        self.extendedIngredients = extendedIngredients
        self.id = id
        self.title = title
        self.readyInMinutes = readyInMinutes
        self.servings = servings
        self.image = image
        self.cuisines = cuisines
        self.dishTypes = dishTypes
        self.analyzedInstructions = analyzedInstructions
        self.aggregateLikes = aggregateLikes
        self.spoonacularScore = spoonacularScore
        self.isFavorite = isFavorite
    }
}

struct AnalyzedInstruction: Decodable {
    let steps: [Step]
}

struct Step: Decodable {
    let number: Int
    let step: String
}

struct Ingredient: Decodable {
    let name: String
    let image: String
    let measures: Measure

    var capitalizedName: String {
        name.capitalized
    }
    
//    var fullImageURL: URL {
//        Link.ingredientImageURL(imageName: image).url
//    }
}

struct Measure: Decodable {
    let metric: Metric
}

struct Metric: Decodable {
    let amount: Double
    let unitShort: String
}
