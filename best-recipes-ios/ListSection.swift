//
//  ListSection.swift
//  best-recipes-ios
//
//  Created by Алексей on 01.07.2024.
//

import Foundation

enum ListSection {
    case trending([ListItem])
    case category([ListItem])
    case categoryRecipe([ListItem])
    case recent([ListItem])
    case cuisine([ListItem])
    
    var items: [ListItem] {
        switch self {
        case .trending(let items),
                .category(let items),
                .categoryRecipe(let items),
                .recent(let items),
                .cuisine(let items):
            return items
        }
    }
    
    var count: Int {
        items.count
    }
    
    var title: String {
        switch self {
        case .trending(_):
            "Trending now"
        case .category(_):
            "Popular category"
        case .categoryRecipe(_):
            ""
        case .recent(_):
            "Recent recipe"
        case .cuisine(_):
            "World cuisine"
        }
    }
}
