//
//  SearchViewController.swift
//  best-recipes-ios
//
//  Created by Елена Логинова on 11.07.2024.
//

import UIKit

final class SearchController: UISearchController {
    
    private var recipeSearchBar = SearchBar()

    override var searchBar: UISearchBar {
        get {
            return recipeSearchBar
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hidesNavigationBarDuringPresentation = false
    }
}
