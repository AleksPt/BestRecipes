//
//  SearchViewController.swift
//  best-recipes-ios
//
//  Created by Елена Логинова on 11.07.2024.
//

import UIKit

protocol SearchControllerDelegate: AnyObject {
    func didDismissSearchController()
}

final class SearchController: UISearchController {
    
    private var recipeSearchBar = SearchBar()
    weak var searchControllerDelegate: SearchControllerDelegate?
    
    override var searchBar: UISearchBar {
        get {
            return recipeSearchBar
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hidesNavigationBarDuringPresentation = false
        setupClearButton()
    }
    
    func setupClearButton() {
        if let searchField = self.searchBar.value(forKey: "searchField") as? UITextField,
           let clearButton = searchField.value(forKey: "_clearButton") as? UIButton {
            clearButton.addTarget(self, action: #selector(clearButtonPressed), for: .touchUpInside)
        }
    }
    
    @objc private func clearButtonPressed() {
        searchControllerDelegate?.didDismissSearchController()
        dismiss(animated: true)
        if let resultController = self.searchResultsController as? SearchResultViewController {
            resultController.clearResults()
        }
    }
}
