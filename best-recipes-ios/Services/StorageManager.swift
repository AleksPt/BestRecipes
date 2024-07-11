//
//  StorageManager.swift
//  best-recipes-ios
//
//  Created by Алексей on 11.07.2024.
//

import Foundation

final class StorageManager {
    
    static let shared = StorageManager()

    private let dataStore = DataStore.shared

    var imageData: Data?
    var title: String = ""
    var servings: Int = 0
    var readyInMinutes: Int = 0
    var instructions: [String] = []
    var ingredientsTuple: [(String, Double, String)] = []
    
    private init() {}
    
    // MARK: - CRUD
    func creatRecipe() {
        var steps: [Step] = []
        for (index, item) in instructions.enumerated() {
            let step = Step(number: index + 1, step: item)
            steps.append(step)
        }
        let instuction = AnalyzedInstruction(steps: steps)
        var analyzedInstruction: [AnalyzedInstruction] = []
        analyzedInstruction.append(instuction)
        
        var ingredients: [Ingredient] = []
        for item in ingredientsTuple {
            let metric = Metric(amount: item.1, unitShort: item.2)
            let measure = Measure(metric: metric)
            let ingredient = Ingredient(
                name: item.0,
                image: Icons.Ingredients.getIngredient().randomElement()?.rawValue ?? "Cucumber",
                measures: measure
            )
            ingredients.append(ingredient)
        }
        
        let recipe = UserRecipe(
            extendedIngredients: ingredients,
            title: title,
            readyInMinutes: readyInMinutes,
            servings: servings,
            analyzedInstructions: analyzedInstruction,
            image: imageData
        )
        dataStore.userRecipes.insert(recipe, at: 0)
    }
    
    func fetchRecipe(_ index: Int) -> UserRecipe {
        return dataStore.userRecipes[index]
    }
    
    func deleteRecipe(_ index: Int) {
        dataStore.userRecipes.remove(at: index)
    }
}
