//
//  MainScreen.swift
//  best-recipes-ios
//
//  Created by Алексей on 01.07.2024.
//

import UIKit

final class MainScreen: UIViewController {
    
    private let mainView = MainView()
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
}

// MARK: - UICollectionViewDelegate
extension MainScreen: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section != 1 {
            print("go to Recipe Detail Screen")
        } else {
            let recipeItems = CollectionData.getData()[indexPath.section + 1].items
            let resultFilter = recipeItems.filter {
                $0.category.rawValue == collectionData[indexPath.section].items[indexPath.item].category.rawValue
            }
            collectionData[indexPath.section + 1].items = resultFilter
            
            let indexSet = IndexSet(integer: indexPath.section + 1)
            mainView.collectionView.reloadSections(indexSet)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        false
    }
}

// MARK: - UICollectionViewDataSource
extension MainScreen: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        collectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionData[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = collectionData[indexPath.section].items[indexPath.item]
        
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TrendingCell.description(),
                for: indexPath
            ) as? TrendingCell else {
                return UICollectionViewCell()
            }
            
            cell.configureCell(item: item)
            return cell
            
        case 1:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CategoryCell.description(),
                for: indexPath
            ) as? CategoryCell else {
                return UICollectionViewCell()
            }
            cell.configureCell(item: item)
            return cell
            
        case 2:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CategoryRecipeCell.description(),
                for: indexPath
            ) as? CategoryRecipeCell else {
                return UICollectionViewCell()
            }
            
            cell.configureCell(item: item)
            return cell
            
        case 3:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RecentCell.description(),
                for: indexPath
            ) as? RecentCell else {
                return UICollectionViewCell()
            }
            
            cell.configureCell(item: item)
            return cell
            
        case 4:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: WorldCuisineCell.description(),
                for: indexPath
            ) as? WorldCuisineCell else {
                return UICollectionViewCell()
            }
            
            cell.configureCell(item: item)
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

