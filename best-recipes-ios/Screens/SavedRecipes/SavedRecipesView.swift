//
//  SavedRecipesView.swift
//  best-recipes-ios
//
//  Created by Vadim Zhelnov on 4.07.24.
//

import UIKit

final class SavedRecipesView:UIView {
    
    // MARK: - UI Components
    
    let collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.itemSize = CGSize(width: 343, height: 258)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(SavedRecipesCell.self, forCellWithReuseIdentifier: SavedRecipesCell.identifier)
        return collectionView
    }()
    
    let emptyMessageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.PoppinsFont.regular(size: 24)
        label.textColor = UIColor.Colors.Neutral.neutral30
        label.numberOfLines = 0
        label.contentMode = .center
        label.textAlignment = .center
        label.text = "You haven't saved any recipes yet"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.GlobalBackground.light
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("MainView not initialised")
    }
    
    func showLabel() {
        emptyMessageLabel.alpha = 1
    }
    
    func hideLabel() {
        emptyMessageLabel.alpha = 0
    }
    
    // MARK: - Set Delegates
    func setDelegates(viewController: SavedRecipesViewController) {
        collectionView.delegate = viewController
        collectionView.dataSource = viewController
    }
    //MARK: - UI Setup
    
    private func addSubviews() {
        addSubview(collectionView)
        addSubview(emptyMessageLabel)
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            emptyMessageLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            emptyMessageLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            emptyMessageLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            emptyMessageLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

