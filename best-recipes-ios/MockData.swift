//
//  MockData.swift
//  best-recipes-ios
//
//  Created by Алексей on 01.07.2024.
//

import Foundation

struct MockData {
    static let shared = MockData()
    
    private let trending: ListSection = {
        .trending([
            .init(title: nil, image: Images.Trending.tranding1),
            .init(title: nil, image: Images.Trending.tranding2),
            .init(title: nil, image: Images.Trending.tranding3),
            .init(title: nil, image: Images.Trending.tranding4),
        ])
    }()
    
    private let category: ListSection = {
        .category([
            .init(title: "Salad", image: Images.Popular.popular1),
            .init(title: "Breakfast", image: Images.Popular.popular2),
            .init(title: "Appetizer", image: Images.Popular.popular3),
            .init(title: "Noodle", image: Images.Popular.popular4),
            .init(title: "Lunch", image: Images.Popular.popular5),
            .init(title: "Soup", image: Images.Popular.popular6),
        ])
    }()
    
    private let categoryRecipe: ListSection = {
        .categoryRecipe([
            .init(title: nil, image: Images.Popular.popular1),
            .init(title: nil, image: Images.Popular.popular2),
            .init(title: nil, image: Images.Popular.popular3),
            .init(title: nil, image: Images.Popular.popular4),
            .init(title: nil, image: Images.Popular.popular5),
            .init(title: nil, image: Images.Popular.popular6),
        ])
    }()
    
    private let recent: ListSection = {
        .recent([
            .init(title: nil, image: Images.Recent.recent1),
            .init(title: nil, image: Images.Recent.recent2),
            .init(title: nil, image: Images.Recent.recent3),
            .init(title: nil, image: Images.Recent.recent4),
            .init(title: nil, image: Images.Recent.recent5),
            .init(title: nil, image: Images.Recent.recent6),
        ])
    }()
    
    private let cuisine: ListSection = {
        .cuisine([
            .init(title: nil, image: Images.Kitchens.kitchen1),
            .init(title: nil, image: Images.Kitchens.kitchen2),
            .init(title: nil, image: Images.Kitchens.kitchen3),
            .init(title: nil, image: Images.Kitchens.kitchen4),
            .init(title: nil, image: Images.Kitchens.kitchen5),
            .init(title: nil, image: Images.Kitchens.kitchen6),
        ])
    }()
    
    var pageData: [ListSection] {
        [trending, category, categoryRecipe, recent, cuisine]
    }
}
