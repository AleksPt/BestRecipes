//
//  MainScreen.swift
//  best-recipes-ios
//
//  Created by Алексей on 01.07.2024.
//

import UIKit

final class MainScreen: UIViewController {
    
    private let mainView = MainView()
    private let sections = MockData.shared.pageData
    
    // MARK: - Life Cycle
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.setDelegates(viewController: self)
        mainView.collectionView.collectionViewLayout = mainView.createLayout(sections: sections)
    }
}

// MARK: - UICollectionViewDelegate
extension MainScreen: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDataSource
extension MainScreen: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch sections[indexPath.section] {
        case .trending(let trending):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TrendingCell.description(),
                for: indexPath
            ) as? TrendingCell else {
                return UICollectionViewCell()
            }
            
            cell.configureCell(image: trending[indexPath.item].image)
            return cell
            
        case .category(let category):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CategoryCell.description(),
                for: indexPath
            ) as? CategoryCell else {
                return UICollectionViewCell()
            }
            cell.configureCell(title: category[indexPath.item].title)
            return cell
            
        case .categoryRecipe(let categoryRecipe):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CategoryRecipeCell.description(),
                for: indexPath
            ) as? CategoryRecipeCell else {
                return UICollectionViewCell()
            }
            
            cell.configureCell(image: categoryRecipe[indexPath.item].image)
            return cell
            
        case .recent(let recent):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RecentCell.description(),
                for: indexPath
            ) as? RecentCell else {
                return UICollectionViewCell()
            }
            
            cell.configureCell(image: recent[indexPath.item].image)
            return cell
            
        case .cuisine(let cuisine):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CuisineCell.description(),
                for: indexPath
            ) as? CuisineCell else {
                return UICollectionViewCell()
            }
            
            cell.configureCell(image: cuisine[indexPath.item].image)
            return cell
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
            
            header.configureHeader(
                title: sections[indexPath.section].title,
                section: indexPath.section
            )
            return header
        default:
            return UICollectionReusableView()
        }
    }
}

