//
//  SavedRecipesViewController.swift
//  best-recipes-ios
//
//  Created by Vadim Zhelnov on 4.07.24.
//

import UIKit

final class SavedRecipesViewController: UIViewController {
    
    // MARK: - Variables
    
    private let savedRecipesView = SavedRecipesView()
    private let dataStore = DataStore.shared
    
    //MARK: - Lifecycle
    
    override func loadView() {
        view = savedRecipesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        savedRecipesView.setDelegates(viewController: self)
        setupNavBarWithoutButtons(on: self, with: "Saved recipes")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        savedRecipesView.collectionView.reloadData()
    }
}

    //MARK: - UICollectionViewDelegate
extension SavedRecipesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = RecipeDetailViewController(recipe: dataStore.favoriteRecipes[indexPath.item])
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
}

    // MARK: - UICollectionViewDataSource
extension SavedRecipesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataStore.favoriteRecipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = dataStore.favoriteRecipes[indexPath.item]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SavedRecipesCell.identifier, for: indexPath) as? SavedRecipesCell else {return UICollectionViewCell()}
        cell.configureCell(recipe: item, delegate: self)
        return cell
    }
}

extension SavedRecipesViewController: FavoriteProtocol {
    func switchFavorite(for recipe: Recipe) {
        dataStore.toggleFavorite(for: recipe)
        savedRecipesView.collectionView.reloadData()
    }
}
