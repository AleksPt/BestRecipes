//
//  MainView.swift
//  best-recipes-ios
//
//  Created by Алексей on 02.07.2024.
//

import UIKit

final class MainView: UIView {
    
    // MARK: - UI
    let collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewLayout()
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: collectionViewLayout
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
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
            WorldCuisineCell.self,
            forCellWithReuseIdentifier: WorldCuisineCell.description()
        )
        collectionView.register(
            HeaderSupplementaryView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HeaderSupplementaryView.description()
        )
        collectionView.delaysContentTouches = false
        return collectionView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("MainView not initialised")
    }
    
    // MARK: - Set Delegates
    func setDelegates(viewController: MainScreen) {
        collectionView.delegate = viewController
        collectionView.dataSource = viewController
    }
    
    // MARK: - Setup View
    private func setupView() {
        backgroundColor = UIColor.GlobalBackground.light
        collectionView.collectionViewLayout = createLayout()
    }
    
    // MARK: - Add subviews
    private func addSubviews() {
        addSubview(collectionView)
    }
    
    // MARK: - Setup Constraint
    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

// MARK: - Create Layout
extension MainView {
    func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            guard let self else { return nil }
            switch sectionIndex {
            case 0:
                return createTrendingSection()
            case 1:
                return createCategorySection()
            case 2:
                return createCategoryRecipeSection()
            case 3:
                return createRecentSection()
            case 4:
                return createCuisineSection()
            default:
                return nil
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
                heightDimension: .fractionalHeight(0.35)
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
                heightDimension: .fractionalHeight(0.35)
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
                widthDimension: .fractionalWidth(0.35),
                heightDimension: .fractionalHeight(0.3)
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
