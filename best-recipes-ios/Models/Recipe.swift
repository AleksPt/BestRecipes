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

struct UserRecipe {
    let extendedIngredients: [Ingredient]
    let title: String
    let readyInMinutes: Int
    let servings: Int
    let analyzedInstructions: [AnalyzedInstruction]
    let image: Data?
}

struct Recipe: Decodable {
    let sourceName: String
    let extendedIngredients: [Ingredient]
    let id: Int
    let title: String
    let readyInMinutes: Int
    let servings: Int
    let image: String
    let cuisines: [String]
    let dishTypes: [String]
    let analyzedInstructions: [AnalyzedInstruction]
    let aggregateLikes: Int
    let spoonacularScore: Double
    
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
        spoonacularScore: Double
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
    
    var fullImageURL: URL {
        APIEndpoint.ingredientImageURL(imageName: image).url
    }
}

struct Measure: Decodable {
    let metric: Metric
}

struct Metric: Decodable {
    let amount: Double
    let unitShort: String
}

enum Cuisine: String, CaseIterable {
    case african = "African"
    case asian = "Asian"
    case american = "American"
    case british = "British"
    case cajun = "Cajun"
    case caribbean = "Caribbean"
    case chinese = "Chinese"
    case easternEuropean = "Eastern European"
    case european = "European"
    case french = "French"
    case german = "German"
    case greek = "Greek"
    case indian = "Indian"
    case irish = "Irish"
    case italian = "Italian"
    case japanese = "Japanese"
    case jewish = "Jewish"
    case korean = "Korean"
    case latinAmerican = "Latin American"
    case mediterranean = "Mediterranean"
    case mexican = "Mexican"
    case middleEastern = "Middle Eastern"
    case nordic = "Nordic"
    case southern = "Southern"
    case spanish = "Spanish"
    case thai = "Thai"
    case vietnamese = "Vietnamese"
    
    static func getCuisines() -> [Cuisine] {
        return Cuisine.allCases
    }
}

enum DishTypes: String, CaseIterable {
    case mainCourse = "Main course"
    case sideDish = "Side dish"
    case dessert = "Dessert"
    case appetizer = "Appetizer"
    case salad = "Salad"
    case bread = "Bread"
    case breakfast = "Breakfast"
    case soup = "Soup"
    case beverage = "Beverage"
    case sauce = "Sauce"
    case marinade = "Marinade"
    case fingerfood = "Fingerfood"
    case snack = "Snack"
    case drink = "Drink"

    static func getDishTypes() -> [String] {
        return DishTypes.allCases.map { $0.rawValue }
    }
}
