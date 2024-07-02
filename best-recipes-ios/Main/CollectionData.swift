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
        case breakfasts = "Затраки"
        case broths = "Бульоны"
        case appetisers = "Закуски"
        case drinks = "Напитки"
        case pasta = "Паста"
        case pizza = "Пицца"
        case risotto = "Ризотто"
        case salads = "Салаты"
        case soups = "Супы"
        case sandwiches = "Сэндвичи"
        case desserts = "Десерты"
    }
    
    enum Author: String {
        case scarlett = "Скарлетт Йоханссон"
        case portman = "Натали Портман"
        case alba = "Джессика Альба"
        case fox = "Меган Фокс"
        case salma = "Сальма Хайек"
        case teron = "Шарлиз Терон"
    }
    
    enum WorldCuisine: String {
        case usa = "США"
        case canada = "Канада"
        case brazil = "Бразилия"
        case germany = "Германия"
        case japan = "Япония"
        case australia = "Австралия"
        case india = "Индия"
        case france = "Франция"
        case italy = "Италия"
        case portugal = "Португалия"
        case mexico = "Мексика"
        case russia = "Россия"
        case argentina = "Аргентина"
        case egypt = "Египет"
        case china = "Китай"
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
    static private func allRecipes() -> [Item] {
        let recipes = [
        Item(
            rating: 3.5,
            coverImage: Images.Trending.tranding1,
            title: "Сырники из творога",
            avatar: Images.Avatars.avatar1,
            nameAuthor: Item.Author.scarlett.rawValue,
            time: 7,
            category: .breakfasts,
            worldCuisine: .usa
        ),
        Item(
            rating: 4.9,
            coverImage: Images.Trending.tranding2,
            title: "Классическая шарлотка",
            avatar: Images.Avatars.avatar2,
            nameAuthor: Item.Author.portman.rawValue,
            time: 15,
            category: .broths,
            worldCuisine: .egypt
        ),
        Item(
            rating: 4.1,
            coverImage: Images.Trending.tranding3,
            title: "Азу по-татарски",
            avatar: Images.Avatars.avatar3,
            nameAuthor: Item.Author.alba.rawValue,
            time: 25,
            category: .appetisers,
            worldCuisine: .canada
        ),
        Item(
            rating: 2.7,
            coverImage: Images.Trending.tranding4,
            title: "Крем-суп из тыквы",
            avatar: Images.Avatars.avatar4,
            nameAuthor: Item.Author.fox.rawValue,
            time: 18,
            category: .drinks,
            worldCuisine: .brazil
        ),
        Item(
            rating: 5.0,
            coverImage: Images.Popular.popular1,
            title: "Домашний рататуй",
            avatar: Images.Avatars.avatar5,
            nameAuthor: Item.Author.salma.rawValue,
            time: 7,
            category: .pasta,
            worldCuisine: .germany
        ),
        Item(
            rating: 4.1,
            coverImage: Images.Popular.popular2,
            title: "Суп харчо",
            avatar: Images.Avatars.avatar6,
            nameAuthor: Item.Author.teron.rawValue,
            time: 34,
            category: .pizza,
            worldCuisine: .japan
        ),
        Item(
            rating: 3.5,
            coverImage: Images.Popular.popular3,
            title: "Оладьи на кефире",
            avatar: Images.Avatars.avatar1,
            nameAuthor: Item.Author.scarlett.rawValue,
            time: 11,
            category: .risotto,
            worldCuisine: .australia
        ),
        Item(
            rating: 4.7,
            coverImage: Images.Popular.popular4,
            title: "Банановые панкейки",
            avatar: Images.Avatars.avatar2,
            nameAuthor: Item.Author.salma.rawValue,
            time: 15,
            category: .salads,
            worldCuisine: .india
        ),
        Item(
            rating: 3.0,
            coverImage: Images.Popular.popular5,
            title: "Чечевичный суп с томатами",
            avatar: Images.Avatars.avatar3,
            nameAuthor: Item.Author.fox.rawValue,
            time: 25,
            category: .soups,
            worldCuisine: .france
        ),
        Item(
            rating: 2.4,
            coverImage: Images.Popular.popular6,
            title: "Паста со свежими помидорами",
            avatar: Images.Avatars.avatar4,
            nameAuthor: Item.Author.portman.rawValue,
            time: 22,
            category: .sandwiches,
            worldCuisine: .italy
        ),
        Item(
            rating: 4.6,
            coverImage: Images.Recent.recent1,
            title: "Французские тосты с яблоками",
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
