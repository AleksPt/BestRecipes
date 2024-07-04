//
//  CollectionData.swift
//  best-recipes-ios
//
//  Created by Алексей on 02.07.2024.
//

import UIKit

struct Section {
    var recipes: [Recipe]
    let categories: [String] = DishTypes.getDishTypes()
    let cuisines: [String] = Cuisine.getCuisines()
}

final class CollectionData {
    static func getData() -> [Section] {
        let sectionTrendingItems = Section(recipes: DataStore.shared.recipes)
        
        let sectionPopularCategory = Section(recipes: DataStore.shared.recipes)
        
        let sectionPopularRecipe = Section(recipes: DataStore.shared.recipes)
        
        let sectionRecent = Section(recipes: DataStore.shared.recipes)
        
        let sectionWorldCuisine = Section(recipes: DataStore.shared.recipes)
        
        return [
            sectionTrendingItems,
            sectionPopularCategory,
            sectionPopularRecipe,
            sectionRecent,
            sectionWorldCuisine
        ]
    }
}
