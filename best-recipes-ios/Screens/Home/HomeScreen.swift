//
//  MainScreen.swift
//  best-recipes-ios
//
//  Created by Алексей on 01.07.2024.
//

import UIKit

final class HomeScreen: UIViewController {
    
    private let mainView = HomeView()
    private var collectionData = CollectionData.getData()
    
    // MARK: - Life Cycle
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.setDelegates(viewController: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectCategory()
    }
    
    // MARK: - Private methods
    /// Выделяет популярную категорию перед показом экрана
    private func selectCategory() {
        let indexPath = IndexPath(item: 0, section: 1)
        mainView.collectionView.selectItem(
            at: indexPath,
            animated: false,
            scrollPosition: .top
        )
    }
    
    /// Фильтр рецептов по категории
    private func filterRecipes(_ indexPath: IndexPath) {
        let category = collectionData[indexPath.section].categories[indexPath.item]
        let recipes = CollectionData.getData()[indexPath.section + 1].recipes
        
        let filteredRecipes = recipes.filter {
            $0.dishTypes.contains(category.lowercased())
        }
        
        collectionData[indexPath.section + 1].recipes = filteredRecipes
        
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
        collectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0, 2, 3:
            collectionData[section].recipes.count
        case 1:
            collectionData[section].categories.count
        case 4:
            collectionData[section].cuisines.count
        default:
            0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let recipe = collectionData[indexPath.section].recipes[indexPath.item]
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TrendingCell.description(),
                for: indexPath
            ) as? TrendingCell else {
                return UICollectionViewCell()
            }
            
            cell.configureCell(item: recipe)
            return cell
            
        case 1:
            let category = collectionData[indexPath.section].categories[indexPath.item]
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CategoryCell.description(),
                for: indexPath
            ) as? CategoryCell else {
                return UICollectionViewCell()
            }
            cell.configureCell(item: category)
            return cell
            
        case 2:
            let recipe = collectionData[indexPath.section].recipes[indexPath.item]
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CategoryRecipeCell.description(),
                for: indexPath
            ) as? CategoryRecipeCell else {
                return UICollectionViewCell()
            }
            
            cell.configureCell(item: recipe)
            return cell
            
        case 3:
            let recipe = collectionData[indexPath.section].recipes[indexPath.item]
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RecentCell.description(),
                for: indexPath
            ) as? RecentCell else {
                return UICollectionViewCell()
            }
            
            cell.configureCell(item: recipe)
            return cell
            
        case 4:
            let cuisine = collectionData[indexPath.section].cuisines[indexPath.item]
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

