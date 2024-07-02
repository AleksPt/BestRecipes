//
//  MainScreen.swift
//  best-recipes-ios
//
//  Created by Алексей on 01.07.2024.
//

import UIKit

final class MainScreen: UIViewController {
    
    private let sections = MockData.shared.pageData
    
    // MARK: - UI
    private let collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .none
        return collectionView
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setDelegates()
    }
    
    // MARK: - Set Delegates
    private func setDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        view.backgroundColor = UIColor.GlobalBackground.light
        
        view.addSubview(collectionView)
        
        collectionView.register(
            TrendingCell.self,
            forCellWithReuseIdentifier: TrendingCell.description()
        )
        collectionView.register(
            CategoryCell.self,
            forCellWithReuseIdentifier: CategoryCell.description()
        )
        collectionView.register(
            CategoryRecipeCell.self,
            forCellWithReuseIdentifier: CategoryRecipeCell.description()
        )
        collectionView.register(
            RecentCell.self,
            forCellWithReuseIdentifier: RecentCell.description()
        )
        collectionView.register(
            CuisineCell.self,
            forCellWithReuseIdentifier: CuisineCell.description()
        )
        collectionView.register(
            HeaderSupplementaryView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HeaderSupplementaryView.description()
        )
        
        collectionView.collectionViewLayout = createLayout()
    }
}

// MARK: - Create Layout
extension MainScreen {
    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            guard let self else { return nil }
            let section = sections[sectionIndex]
            switch section {
            case .trending(_):
                return createTrendingSection()
            case .category(_):
                return createCategorySection()
            case .categoryRecipe(_):
                return createCategoryRecipeSection()
            case .recent(_):
                return createRecentSection()
            case .cuisine(_):
                return createCuisineSection()
            }
        }
    }
    
    private func createLayoutSection(
        group: NSCollectionLayoutGroup,
        behavior: UICollectionLayoutSectionOrthogonalScrollingBehavior,
        interGroupSpacing: CGFloat,
        supplementaryItems: [NSCollectionLayoutBoundarySupplementaryItem],
        contentInsets: Bool
    ) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = behavior
        section.interGroupSpacing = interGroupSpacing
        section.boundarySupplementaryItems = supplementaryItems
        section.supplementariesFollowContentInsets = contentInsets
        return section
    }
    
    private func createTrendingSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(0.75),
                heightDimension: .fractionalHeight(0.3)
            ),
            subitems: [item]
        )
        
        let section = createLayoutSection(
            group: group,
            behavior: .groupPaging,
            interGroupSpacing: 16,
            supplementaryItems: [supplementaryHeaderItem()],
            contentInsets: false
        )
        section.contentInsets = .init(
            top: 16,
            leading: 16,
            bottom: 24,
            trailing: 16
        )
        
        return section
    }
    
    private func createCategorySection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .estimated(83),
                heightDimension: .absolute(34)
            ),
            subitems: [item]
        )
        group.interItemSpacing = .flexible(10)
        
        let section = createLayoutSection(
            group: group,
            behavior: .continuous,
            interGroupSpacing: 8,
            supplementaryItems: [supplementaryHeaderItem()],
            contentInsets: false
        )
        
        section.contentInsets = .init(
            top: 19,
            leading: 16,
            bottom: 0,
            trailing: 16
        )
        
        return section
    }
    
    private func createCategoryRecipeSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(0.4),
                heightDimension: .fractionalHeight(0.3)
            ),
            subitems: [item]
        )
        
        let section = createLayoutSection(
            group: group,
            behavior: .continuous,
            interGroupSpacing: 16,
            supplementaryItems: [],
            contentInsets: false
        )
        
        section.contentInsets = .init(
            top: 19,
            leading: 16,
            bottom: 10,
            trailing: 16
        )
        
        return section
    }
    
    private func createRecentSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(0.4),
                heightDimension: .fractionalHeight(0.25)
            ),
            subitems: [item]
        )
        
        let section = createLayoutSection(
            group: group,
            behavior: .continuous,
            interGroupSpacing: 10,
            supplementaryItems: [supplementaryHeaderItem()],
            contentInsets: false
        )
        section.contentInsets = .init(
            top: 16,
            leading: 16,
            bottom: 13,
            trailing: 16
        )
        
        return section
    }
    
    private func createCuisineSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(0.3),
                heightDimension: .fractionalHeight(0.2)
            ),
            subitems: [item]
        )
        
        let section = createLayoutSection(
            group: group,
            behavior: .continuous,
            interGroupSpacing: 16,
            supplementaryItems: [supplementaryHeaderItem()],
            contentInsets: false
        )
        section.contentInsets = .init(
            top: 16,
            leading: 16,
            bottom: 21,
            trailing: 16
        )
        
        return section
    }
    
    private func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        .init(
            layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(30)),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
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

// MARK: - Setup Constraints
private extension MainScreen {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}
