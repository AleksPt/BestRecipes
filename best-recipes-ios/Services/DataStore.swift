//
//  DataStore.swift
//  best-recipes-ios
//
//  Created by Vladimir Dmitriev on 02.07.24.
//

import Foundation

struct Section {
    var recipes: [Recipe]
    let categories: [String] = DishTypes.getDishTypes()
    let cuisines: [Cuisine] = Cuisine.getCuisines()
}

final class DataStore {
    
    static let shared = DataStore()
    
    var recipes = [
        Recipe(
            sourceName: "Afrolems",
            extendedIngredients: [
                Ingredient(
                    name: "curry powder",
                    image: "curry-powder.jpg",
                    measures: Measure(
                        metric: Metric(
                            amount: 0.5,
                            unitShort: "tsps"
                        )
                    )
                ),
                Ingredient(
                    name: "garlic",
                    image: "garlic.png",
                    measures: Measure(
                        metric: Metric(
                            amount: 2,
                            unitShort: "cloves"
                        )
                    )
                ),
                Ingredient(
                    name: "ginger",
                    image: "ginger.png",
                    measures: Measure(
                        metric: Metric(
                            amount: 1,
                            unitShort: "handful"
                        )
                    )
                ),
                Ingredient(
                    name: "seasoning cubes",
                    image: "diced-ham.jpg",
                    measures: Measure(
                        metric: Metric(
                            amount: 3,
                            unitShort: ""
                        )
                    )
                ),
                Ingredient(
                    name: "pineapple cubes",
                    image: "diced-ham.jpg",
                    measures: Measure(
                        metric: Metric(
                            amount: 9,
                            unitShort: "small"
                        )
                    )
                ),
                
            ],
            id: 716309,
            title: "Pineapple Glazed Turkey Wings",
            readyInMinutes: 45,
            servings: 2,
            image: "https://img.spoonacular.com/recipes/716309-556x370.jpg",
            cuisines: ["American"],
            dishTypes: [
                "antipasti",
                "lunch",
                "main course",
                "starter",
                "snack",
                "appetizer",
                "main dish",
                "antipasto",
                "hor d'oeuvre",
                "dinner"
            ],
            analyzedInstructions: [
                AnalyzedInstruction(
                    steps: [
                        Step(
                            number: 1,
                            step: "Wash your turkey wing pieces and place in a bowl.In a blender, blend your pineapple pieces, pepper and other ingredients including the seasoning and pour into the bowl with the turkey wings."
                        ),
                        Step(
                            number: 2,
                            step: "Pour in the chopped onions.If you have time, leave it to marinate for one hour.In a pan (preferably non stick) place the turkey pieces in the pan to brown on both sides. Then transfer to a baking tray and coat with oil and place in an oven preheated to 350F."
                        ),
                        Step(
                            number: 3,
                            step: "Bake for 20-25 minutes or until completely cooked.In a separate pan, heat the sugar and oil till it starts to brown (light brown), pour the left over marinade and stir in the turkey wing pieces."
                        )
                    ]
                )
            ],
            aggregateLikes: 1866,
            spoonacularScore: 87.41600036621094,
            isFavorite: true
        ),
        Recipe(
            sourceName: "Bon Appetit",
            extendedIngredients: [
                Ingredient(
                    name: "honeycrisp apple",
                    image: "apple.jpg",
                    measures: Measure(
                        metric: Metric(
                            amount: 1,
                            unitShort: "medium"
                        )
                    )
                ),
                Ingredient(
                    name: "apple cider vinegar",
                    image: "apple-cider-vinegar.jpg",
                    measures: Measure(
                        metric: Metric(
                            amount: 2,
                            unitShort: "Tbsps"
                        )
                    )
                ),
                Ingredient(
                    name: "honey",
                    image: "honey.png",
                    measures: Measure(
                        metric: Metric(
                            amount: 1,
                            unitShort: "Tbsp"
                        )
                    )
                ),
                Ingredient(
                    name: "kosher salt",
                    image: "pepper.jpg",
                    measures: Measure(
                        metric: Metric(
                            amount: 4,
                            unitShort: "servings"
                        )
                    )
                ),
                Ingredient(
                    name: "prosciutto",
                    image: "proscuitto.jpg",
                    measures: Measure(
                        metric: Metric(
                            amount: 56.699,
                            unitShort: "g"
                        )
                    )
                ),
                Ingredient(
                    name: "butter",
                    image: "butter-sliced.jpg",
                    measures: Measure(
                        metric: Metric(
                            amount: 4,
                            unitShort: "Tbsps"
                        )
                    )
                ),
                Ingredient(
                    name: "vegetable oil",
                    image: "vegetable-oil.jpg",
                    measures: Measure(
                        metric: Metric(
                            amount: 109,
                            unitShort: "ml"
                        )
                    )
                ),
                Ingredient(
                    name: "torn chicories",
                    image: "chicory.jpg",
                    measures: Measure(
                        metric: Metric(
                            amount: 720,
                            unitShort: "g"
                        )
                    )
                )
            ],
            id: 715309,
            title: "Chicory-Apple Salad with Brown Butter Dressing",
            readyInMinutes: 45,
            servings: 4,
            image: "https://img.spoonacular.com/recipes/715309-556x370.jpg",
            cuisines: [],
            dishTypes: [
                "side dish",
                "antipasti",
                "salad",
                "starter",
                "snack",
                "appetizer",
                "antipasto",
                "hor d'oeuvre"
            ],
            analyzedInstructions: [
                AnalyzedInstruction(
                    steps: [
                        Step(
                            number: 1,
                            step: "Heat  cup oil in a medium skillet over medium-high. Working in batches, fry prosciutto until lightly browned and crisp, about 2 minutes per side."
                        ),
                        Step(
                            number: 2,
                            step: "Transfer to paper towels to drain. Cook butter in a small skillet over medium heat until butter foams, then browns (be careful not to let it burn), about 5 minutes. Allow browned milk solids to settle, then slowly pour off melted butter, leaving browned bits in the pan. (Reserve butter for another use.)"
                        ),
                        Step(
                            number: 3,
                            step: "Whisk vinegar, honey, and remaining 2 Tbsp. oil into browned milk solids; season dressing with salt and pepper.Toss chicories, apple, and dressing in a large bowl; season with salt and pepper."
                        ),
                        Step(
                            number: 4,
                            step: "Serve salad topped with fried prosciutto."
                        )
                    ]
                )
            ],
            aggregateLikes: 207,
            spoonacularScore: 41.80624771118164
        ),
        Recipe(
            sourceName: "spoonacular",
            extendedIngredients: [
                Ingredient(
                    name: "butternut squash",
                    image: "butternut-squash.jpg",
                    measures: Measure(
                        metric: Metric(
                            amount: 1,
                            unitShort: "small"
                        )
                    )
                ),
                Ingredient(
                    name: "canned tomatoes",
                    image: "tomatoes-canned.png",
                    measures: Measure(
                        metric: Metric(
                            amount: 400,
                            unitShort: "g"
                        )
                    )
                ),
                Ingredient(
                    name: "chicken breasts",
                    image: "chicken-breasts.png",
                    measures: Measure(
                        metric: Metric(
                            amount: 3,
                            unitShort: ""
                        )
                    )
                ),
                Ingredient(
                    name: "chicken stock",
                    image: "chicken-broth.png",
                    measures: Measure(
                        metric: Metric(
                            amount: 1,
                            unitShort: ""
                        )
                    )
                ),
                Ingredient(
                    name: "garlic",
                    image: "garlic.png",
                    measures: Measure(
                        metric: Metric(
                            amount: 1,
                            unitShort: "clove"
                        )
                    )
                ),
                Ingredient(
                    name: "ginger",
                    image: "ginger.png",
                    measures: Measure(
                        metric: Metric(
                            amount: 3,
                            unitShort: ""
                        )
                    )
                ),
                Ingredient(
                    name: "ground coriander",
                    image: "ground-coriander.jpg",
                    measures: Measure(
                        metric: Metric(
                            amount: 0.5,
                            unitShort: "tsps"
                        )
                    )
                ),
                Ingredient(
                    name: "ground cumin",
                    image: "ground-cumin.jpg",
                    measures: Measure(
                        metric: Metric(
                            amount: 1,
                            unitShort: "tsp"
                        )
                    )
                ),
                Ingredient(
                    name: "mascarpone",
                    image: "white-cream-fluffy.jpg",
                    measures: Measure(
                        metric: Metric(
                            amount: 2,
                            unitShort: "Tbsps"
                        )
                    )
                ),
                Ingredient(
                    name: "onion",
                    image: "brown-onion.png",
                    measures: Measure(
                        metric: Metric(
                            amount: 1,
                            unitShort: "large"
                        )
                    )
                ),
                Ingredient(
                    name: "red bell pepper",
                    image: "red-pepper.jpg",
                    measures: Measure(
                        metric: Metric(
                            amount: 1,
                            unitShort: ""
                        )
                    )
                ),
                Ingredient(
                    name: "spinach",
                    image: "spinach.jpg",
                    measures: Measure(
                        metric: Metric(
                            amount: 200,
                            unitShort: "g"
                        )
                    )
                ),
                Ingredient(
                    name: "turmeric",
                    image: "turmeric.jpg",
                    measures: Measure(
                        metric: Metric(
                            amount: 1,
                            unitShort: "tsp"
                        )
                    )
                ),
                Ingredient(
                    name: "water",
                    image: "water.png",
                    measures: Measure(
                        metric: Metric(
                            amount: 300,
                            unitShort: "ml"
                        )
                    )
                )
            ],
            id: 705309,
            title: "Chicken, Vegetable and Spinach Curry",
            readyInMinutes: 45,
            servings: 4,
            image: "https://img.spoonacular.com/recipes/705309-556x370.jpg",
            cuisines: [
                "Indian",
                "Asian"
            ],
            dishTypes: [
                "lunch",
                "main course",
                "main dish",
                "dinner"
            ],
            analyzedInstructions: [
                AnalyzedInstruction(
                    steps: [
                        Step(
                            number: 1,
                            step: "Heat the oil in a large pan, then add the onion. Cook very gently for about 10 mins. Stir in the garlic and ginger and cook for a further 1 min.2"
                        ),
                        Step(
                            number: 2,
                            step: "Add the spices and cook for 1 min, then add the chicken, squash and red pepper. Fry in the spices for about 3 mins.Tip in the tomatoes and satock, then simmer for 25-30 mins until the sauce has thickened and the chicken is cooked through.3Meanwhile, cook the basmati rice according to the pack instructions.4Stir the spinach into the curry to wilt, then add the garam masala, if using (leave out if you want a milder curry).5"
                        ),
                        Step(
                            number: 3,
                            step: "Add the yogurt and cook for 1 min, then serve with the rice."
                        )
                    ]
                )
            ],
            aggregateLikes: 19,
            spoonacularScore: 92.36641693115234
        )
    ]
    
    var offsetRecipes = 0
    var offsetPopularResipes = 0
    var offsetWorldCuisineRecipes = 0
    
    var trendingRecipes: [Recipe]?
    var popularRecipes: [Recipe]?
    var recentRecipes: [Recipe]?
    var worlCuisineRecipes: [Recipe]?
    
    private init() {}
    
    func getMockData() -> [Section] {
        let sectionTrendingItems = Section(recipes: DataStore.shared.recipes)
        
        let sectionPopularCategory = Section(recipes: DataStore.shared.recipes)
        
        let sectionPopularRecipe = Section(recipes: DataStore.shared.recipes)
        
        let sectionRecent = Section(recipes: DataStore.shared.recentRecipes ?? [])
        
        let sectionWorldCuisine = Section(recipes: DataStore.shared.recipes)
        
        return [
            sectionTrendingItems,
            sectionPopularCategory,
            sectionPopularRecipe,
            sectionRecent,
            sectionWorldCuisine
        ]
    }
    
    func getData() -> [Section] {
        let sectionTrendingItems = Section(recipes: trendingRecipes ?? [])
        
        let sectionPopularCategory = Section(recipes: trendingRecipes ?? [])
        
        let sectionPopularRecipe = Section(recipes: popularRecipes ?? [])
        
        let sectionRecent = Section(recipes: recentRecipes ?? [])
        
        let sectionWorldCuisine = Section(recipes: worlCuisineRecipes ?? [])
        
        return [
            sectionTrendingItems,
            sectionPopularCategory,
            sectionPopularRecipe,
            sectionRecent,
            sectionWorldCuisine
        ]
    }
}


final class StorageManager {
    
    static let shared = StorageManager()

    private let dataStore = DataStore.shared

    private init() {}
    
    // MARK: - CRUD
    
    func creatRecipe(from recipe: Recipe) {
        dataStore.recipes.append(recipe)
    }
    
    func fetchRecipe(_ index: Int) -> Recipe {
        return dataStore.recipes[index]
    }
    
    func deleteRecipe(_ index: Int) {
        dataStore.recipes.remove(at: index)
    }
}

