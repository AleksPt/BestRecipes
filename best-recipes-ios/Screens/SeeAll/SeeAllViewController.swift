//
//  SeeAllViewController.swift
//  best-recipes-ios
//
//  Created by  Maksim Stogniy on 29.06.2024.
//

import UIKit

final class SeeAllViewController: UIViewController {
    weak var delegate: HomeScreenDelegate?
    var recipes: [Recipe]? = []
    var nameCuisine = ""
    private var type: RecipesType
    private var dataStore = DataStore.shared
    private let networkManager = NetworkManager.shared
    private let customView = SeeAllView()
    
    // MARK: - Init
    init(type: RecipesType) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life Cycle
    override func loadView() {
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar(type)
        customView.setTitle(type)
        customView.setDelegates(value: self)
        
        if type == .worldCuisine {
            fetchRecipes()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let tabBarController = self.tabBarController as? TabBarController {
            tabBarController.tabBar.isHidden = true
            tabBarController.toggleMiddleButtonVisability(true)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let tabBarController = self.tabBarController as? TabBarController {
            tabBarController.tabBar.isHidden = false
            tabBarController.toggleMiddleButtonVisability(false)
        }
    }
    
    private func setupNavBar(_ type: RecipesType) {
        switch type {
        case .trendingNow:
            setupNavBarWithButtons(on: self, text: "Trending now")
        case .recentRecipe:
            setupNavBarWithButtons(on: self, text: "Recent recipe")
        case .worldCuisine:
            setupNavBarWithButtons(on: self, text: "World cuisine")
        }
    }
    
    private func fetchRecipes() {
        customView.activityIndicator.startAnimation(delay: 0.0075, replicates: 120)
        let url = APIEndpoint.cuisineSortedRecipesURL(offset: dataStore.offsetWorldCuisineRecipes, cuisine: nameCuisine).url
        networkManager.fetch(ComplexSearch.self, from: url) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let fetchRecipes):
                
                recipes = fetchRecipes.results
                
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    customView.collectionView.reloadData()
                    customView.activityIndicator.stopAnimation()
                }
            case .failure(let error):
                print(error.localizedDescription)
                customView.activityIndicator.stopAnimation()
            }
        }
    }
    
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension SeeAllViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        recipes?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "CustomCell",
            for: indexPath
        ) as? CustomCell else {
            return UICollectionViewCell()
        }
        
        if let recipe = recipes?[indexPath.item] {
            cell.configure(with: recipe)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let recipe = recipes?[indexPath.item] {
            let detailVC = RecipeDetailViewController(recipe: recipe)
            delegate?.addRecentRecipe(recipe: recipe)
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}


