//
//  SeeAllView.swift
//  best-recipes-ios
//
//  Created by Sergey Zakurakin on 01/07/2024.
//

import UIKit

final class SeeAllView: UIView {
    
    // MARK: - UI
    private let title = LabelFactory.makeScreenTitleLabel(text: "")
    
    let collectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 24
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "CustomCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delaysContentTouches = false
        return collectionView
    }()
    
    lazy var activityIndicator: CustomSpinner = {
       let element = CustomSpinner(squareLength: 50)
        return element
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    func setTitle(_ type: RecipesType) {
        switch type {
        case .trendingNow:
            title.text = "Trending now"
        case .recentRecipe:
            title.text = "Recent recipe"
        case .worldCuisine:
            title.text = "World cuisine"
        }
    }
    
    func setDelegates(value: SeeAllViewController) {
        collectionView.delegate = value
        collectionView.dataSource = value
    }
    
    // MARK: - Private methods
    private func setViews() {
        backgroundColor = UIColor.GlobalBackground.light
        addSubview(collectionView)
        addSubview(activityIndicator)
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
    }
}
