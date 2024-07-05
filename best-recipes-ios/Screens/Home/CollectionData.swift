//
//  CollectionData.swift
//  best-recipes-ios
//
//  Created by Алексей on 02.07.2024.
//

import UIKit

struct Section {
    var items: [Item]
}

struct Item {
    enum Category: String {
        case breakfasts
        case broths
        case appetisers
        case drinks
        case pasta
        case pizza
        case risotto
        case salads
        case soups
        case sandwiches
        case desserts
    }
    
    enum Author: String {
        case scarlett = "Scarlett Johansson"
        case portman = "Natalie Portman"
        case alba = "Jessica Alba"
        case fox = "Megan Fox"
        case salma = "Salma Hayek"
        case teron = "Charlize Theron"
    }
    
    enum WorldCuisine: String {
        case usa = "USA"
        case canada
        case brazil
        case germany
        case japan
        case australia
        case india
        case france
        case italy
        case portugal
        case mexico
        case russia
        case argentina
        case egypt
        case china
    }
    
    let rating: Double
    let coverImage: UIImage
    let title: String
    let avatar: UIImage
    let nameAuthor: String
    let time: Int
    let category: Category
    let worldCuisine: WorldCuisine
}

final class CollectionData {
    static func allRecipes() -> [Item] {
        let recipes = [
        Item(
            rating: 3.5,
            coverImage: Images.Trending.tranding1,
            title: "Chicken Soup",
            avatar: Images.Avatars.avatar1,
            nameAuthor: Item.Author.scarlett.rawValue,
            time: 7,
            category: .breakfasts,
            worldCuisine: .usa
        ),
        Item(
            rating: 4.5,
            coverImage: Images.Trending.tranding2,
            title: "Lemon Cheesecake",
            avatar: Images.Avatars.avatar2,
            nameAuthor: Item.Author.fox.rawValue,
            time: 42,
            category: .breakfasts,
            worldCuisine: .argentina
        ),
        Item(
            rating: 2.2,
            coverImage: Images.Trending.tranding3,
            title: "Summer Meat Slaw",
            avatar: Images.Avatars.avatar3,
            nameAuthor: Item.Author.salma.rawValue,
            time: 11,
            category: .breakfasts,
            worldCuisine: .canada
        ),
        Item(
            rating: 4.9,
            coverImage: Images.Trending.tranding2,
            title: "Olive Boursin Spread",
            avatar: Images.Avatars.avatar2,
            nameAuthor: Item.Author.portman.rawValue,
            time: 15,
            category: .broths,
            worldCuisine: .egypt
        ),
        Item(
            rating: 4.1,
            coverImage: Images.Trending.tranding3,
            title: "Beef Enchilada Bake",
            avatar: Images.Avatars.avatar3,
            nameAuthor: Item.Author.alba.rawValue,
            time: 25,
            category: .appetisers,
            worldCuisine: .canada
        ),
        Item(
            rating: 2.7,
            coverImage: Images.Trending.tranding4,
            title: "Carrot Cake Pancakes",
            avatar: Images.Avatars.avatar4,
            nameAuthor: Item.Author.fox.rawValue,
            time: 18,
            category: .drinks,
            worldCuisine: .brazil
        ),
        Item(
            rating: 5.0,
            coverImage: Images.Popular.popular1,
            title: "Air Fryer Po' Boy",
            avatar: Images.Avatars.avatar5,
            nameAuthor: Item.Author.salma.rawValue,
            time: 7,
            category: .pasta,
            worldCuisine: .germany
        ),
        Item(
            rating: 4.1,
            coverImage: Images.Popular.popular2,
            title: "Harissa Baked Salmon",
            avatar: Images.Avatars.avatar6,
            nameAuthor: Item.Author.teron.rawValue,
            time: 34,
            category: .pizza,
            worldCuisine: .japan
        ),
        Item(
            rating: 3.5,
            coverImage: Images.Popular.popular3,
            title: "Shirazi Salad",
            avatar: Images.Avatars.avatar1,
            nameAuthor: Item.Author.scarlett.rawValue,
            time: 11,
            category: .risotto,
            worldCuisine: .australia
        ),
        Item(
            rating: 4.7,
            coverImage: Images.Popular.popular4,
            title: "Bloody Mary Pork Tacos",
            avatar: Images.Avatars.avatar2,
            nameAuthor: Item.Author.salma.rawValue,
            time: 15,
            category: .salads,
            worldCuisine: .india
        ),
        Item(
            rating: 3.0,
            coverImage: Images.Popular.popular5,
            title: "BBQ'D Beans",
            avatar: Images.Avatars.avatar3,
            nameAuthor: Item.Author.fox.rawValue,
            time: 25,
            category: .soups,
            worldCuisine: .france
        ),
        Item(
            rating: 2.4,
            coverImage: Images.Popular.popular6,
            title: "The Viral Crookie",
            avatar: Images.Avatars.avatar4,
            nameAuthor: Item.Author.portman.rawValue,
            time: 22,
            category: .sandwiches,
            worldCuisine: .italy
        ),
        Item(
            rating: 4.6,
            coverImage: Images.Recent.recent1,
            title: "Thai Spice Sweet Tea",
            avatar: Images.Avatars.avatar5,
            nameAuthor: Item.Author.teron.rawValue,
            time: 5,
            category: .desserts,
            worldCuisine: .portugal
        )
        ]
        
        return recipes
    }
    
    static func getData() -> [Section] {
        let sectionTrendingItems = Section(items: allRecipes().shuffled())
        
        let sectionPopularCategory = Section(items: allRecipes().shuffled())
        
        let sectionPopularRecipe = Section(items: allRecipes().shuffled())
        
        let sectionRecent = Section(items: allRecipes().shuffled())
        
        let sectionWorldCuisine = Section(items: allRecipes().shuffled())

        return [
            sectionTrendingItems,
            sectionPopularCategory,
            sectionPopularRecipe,
            sectionRecent,
            sectionWorldCuisine
        ]
    }
}
