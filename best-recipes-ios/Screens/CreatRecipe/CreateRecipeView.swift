//
//  CreateRecipeView.swift
//  best-recipes-ios
//
//  Created by Vladimir Dmitriev on 06.07.24.
//

import UIKit

final class CreateRecipeView: UIView {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delaysContentTouches = false
        collectionView.register(
            RecipeImageCell.self,
            forCellWithReuseIdentifier: "RecipeImageCell"
        )
        collectionView.register(
            RecipeTitleCell.self,
            forCellWithReuseIdentifier: "RecipeTitleCell"
        )
        collectionView.register(
            ServesAndTimeCell.self,
            forCellWithReuseIdentifier: "ServesAndTimeCell"
        )
        collectionView.register(
            CreateIngredientCell.self,
            forCellWithReuseIdentifier: "CreateIngredientCell"
        )
        collectionView.register(
            CreateInstructionCell.self,
            forCellWithReuseIdentifier: "CreateInstructionCell"
        )
        
        collectionView.register(
            CreateRecipeHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "CreateRecipeHeaderView"
        )
        return collectionView
    }()
    
    let createRecipeButton = ButtonFactory.onboardingMainPageButton(title: "Create recipe")
    
    private lazy var customView: UIView = {
        let element = UIView()
        element.backgroundColor = .white
        element.translatesAutoresizingMaskIntoConstraints = false
        element.addShadow(
            offset: CGSize(width: 0, height: -1),
            color: .black,
            radius: 8,
            opacity: 0.08
        )
        return element
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    func setDelegates(_ value: CreateRecipeController) {
        collectionView.delegate = value
        collectionView.dataSource = value
    }
    
    // MARK: - Private Methods
    private func addSubviews() {
        addSubview(collectionView)
        addSubview(customView)
        addSubview(createRecipeButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate(
            [
                collectionView.topAnchor.constraint(equalTo: topAnchor),
                collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
                collectionView.bottomAnchor.constraint(equalTo: customView.topAnchor),
                
                customView.leadingAnchor.constraint(equalTo: leadingAnchor),
                customView.trailingAnchor.constraint(equalTo: trailingAnchor),
                customView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
                customView.heightAnchor.constraint(equalToConstant: 69),
                
                createRecipeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 13),
                createRecipeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -13),
                createRecipeButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
                createRecipeButton.heightAnchor.constraint(equalToConstant: 56),
            ]
        )
    }
}
