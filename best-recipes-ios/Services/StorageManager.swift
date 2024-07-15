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

    var image: String?
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
        
        let recipe = Recipe(
            sourceName: "",
            extendedIngredients: ingredients,
            id: 0,
            title: title,
            readyInMinutes: readyInMinutes,
            servings: servings,
            image: image ?? "defaultCover",
            cuisines: [""],
            dishTypes: [""],
            analyzedInstructions: analyzedInstruction,
            aggregateLikes: 0,
            spoonacularScore: 0
        )
        dataStore.userRecipes.insert(recipe, at: 0)
    }
    
    func clearAfterCreateRecipe() {
        image = nil
        title = ""
        servings = 0
        readyInMinutes = 0
        instructions = []
        ingredientsTuple = []
    }
    
    func fetchRecipe(_ index: Int) -> Recipe {
        return dataStore.userRecipes[index]
    }
    
    func deleteRecipe(_ index: Int) {
        dataStore.userRecipes.remove(at: index)
    }
    
    // MARK: - File Manager
    private func getPath() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    func saveImage(data: Data, name: String?) {
        var path = getPath()
        
        guard name != nil else { return }
        if #available(iOS 16.0, *) {
            path.append(path: name!)
        } else {
            print("file couldn’t be saved")
        }
        do {
            try data.write(to: path)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getImage(imgName: String) -> Data? {
        var path = getPath()
        if #available(iOS 16.0, *) {
            path.append(path: imgName)
        } else {
            print("file couldn’t be saved")
        }
        return try? Data(contentsOf: path)
    }
}
