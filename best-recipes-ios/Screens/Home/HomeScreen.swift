//
//  MainScreen.swift
//  best-recipes-ios
//
//  Created by Алексей on 01.07.2024.
//

import UIKit

final class HomeScreen: UIViewController {
    
    private let mainView = HomeView()
    private let networkManager = NetworkManager.shared
    private var dataStore = DataStore.shared
    private var dataSource: [Section] = []
    
    // MARK: - Life Cycle
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.setDelegates(viewController: self)
        
        // FIXME: выбери источник данных (mock или network)
//        dataSource = dataStore.getMockData()
        fetchRecipes(typeUrl: .recipesURL(offset: 0, query: ""))
        fetchRecipes(typeUrl: .popularRecipesURL(offset: 0))
    }
    
    // MARK: - Private methods
    /// Сетевой запрос рецептов
    private func fetchRecipes(typeUrl: APIEndpoint) {
        let url = typeUrl.url
        networkManager.fetch(ComplexSearch.self, from: url) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let recipes):
                
                switch typeUrl {
                case .recipesURL(_, _):
                    dataStore.recipes = recipes.results
                case .popularRecipesURL(_):
                    dataStore.popularRecipes = recipes.results
                case .cuisineSortedRecipesURL(_, _):
                    dataStore.worlCuisineRecipes = recipes.results
                case .ingredientImageURL(_):
                    break
                }
                
                dataSource = dataStore.getData()
                
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    mainView.collectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    /// Выделяет популярную категорию перед показом экрана
    private func selectCategory() {
        if !dataSource.isEmpty {
            let indexPath = IndexPath(item: 0, section: 1)
            mainView.collectionView.selectItem(
                at: indexPath,
                animated: false,
                scrollPosition: .top
            )
        }
    }
    
    /// Фильтр рецептов по категории
    private func filterRecipes(_ indexPath: IndexPath) {
        let category = dataSource[indexPath.section].categories[indexPath.item]
        // FIXME: выбери источник данных (mock или network)
//        let recipes = DataStore.shared.getMockData()[indexPath.section + 1].recipes
        let recipes = DataStore.shared.getData()[indexPath.section + 1].recipes
        
        let filteredRecipes = recipes.filter {
            $0.dishTypes.contains(category.lowercased())
        }
        
        dataSource[indexPath.section + 1].recipes = filteredRecipes
        
        let indexSet = IndexSet(integer: indexPath.section + 1)
        mainView.collectionView.reloadSections(indexSet)
    }
}

// MARK: - UICollectionViewDelegate
extension HomeScreen: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section != 1 {
            print("go to Recipe Detail Screen")
        } else {
            filterRecipes(indexPath)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        false
    }
}

// MARK: - UICollectionViewDataSource
extension HomeScreen: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0, 2, 3:
            dataSource[section].recipes.count
        case 1:
            dataSource[section].categories.count
        case 4:
            dataSource[section].cuisines.count
        default:
            0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let recipe = dataSource[indexPath.section].recipes[indexPath.item]
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TrendingCell.description(),
                for: indexPath
            ) as? TrendingCell else {
                return UICollectionViewCell()
            }
            
            cell.configureCell(item: recipe)
            return cell
            
        case 1:
            let category = dataSource[indexPath.section].categories[indexPath.item]
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CategoryCell.description(),
                for: indexPath
            ) as? CategoryCell else {
                return UICollectionViewCell()
            }
            cell.configureCell(item: category)
            return cell
            
        case 2:
            let recipe = dataSource[indexPath.section].recipes[indexPath.item]
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CategoryRecipeCell.description(),
                for: indexPath
            ) as? CategoryRecipeCell else {
                return UICollectionViewCell()
            }
            
            cell.configureCell(item: recipe)
            return cell
            
        case 3:
            let recipe = dataSource[indexPath.section].recipes[indexPath.item]
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RecentCell.description(),
                for: indexPath
            ) as? RecentCell else {
                return UICollectionViewCell()
            }
            
            cell.configureCell(item: recipe)
            return cell
            
        case 4:
            let cuisine = dataSource[indexPath.section].cuisines[indexPath.item]
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: WorldCuisineCell.description(),
                for: indexPath
            ) as? WorldCuisineCell else {
                return UICollectionViewCell()
            }
            
            cell.configureCell(item: cuisine)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HeaderSupplementaryView.description(),
                for: indexPath
            ) as? HeaderSupplementaryView else {
                return UICollectionReusableView()
            }
            
            header.configureHeader(section: indexPath.section)
            return header
        default:
            return UICollectionReusableView()
        }
    }
}

