//
//  Recipe.swift
//  best-recipes-ios
//
//  Created by Vladimir Dmitriev on 01.07.24.
//

struct complexSearch {
    let results: [Recipe]
}

struct Recipe {
    let sourceName: String
    let extendedIngredients: [Ingredient]
    let id: Int // ?
    let title: String
    let readyInMinutes: Int
    let servings: Int
    let image: String
    let cuisines: [String]
    let dishTypes: [String]
    let analyzedInstructions: [AnalyzedInstruction]
    let spoonacularScore: Double
    
    let isFavorite: Bool
    
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
        spoonacularScore: Double,
        isFavorite: Bool = false
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
        self.spoonacularScore = spoonacularScore
        self.isFavorite = isFavorite
    }
}

struct AnalyzedInstruction {
    let steps: [Step]
}

struct Step {
    let number: Int
    let step: String
}

struct Ingredient {
    let name: String
    let image: String
    let measures: Measure
    
    var capitalizedName: String {
        name.capitalized
    }
}

struct Measure {
    let metric: Metric
}

struct Metric {
    let amount: Double
    let unitShort: String
}
