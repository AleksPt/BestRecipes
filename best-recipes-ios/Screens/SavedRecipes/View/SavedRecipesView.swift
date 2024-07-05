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
    
    let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "Saved recipes"
        label.textColor = UIColor.Home.title
        label.font = UIFont.TextFonts.NavigationBar.title
        label.textAlignment = .center
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
    
    // MARK: - Set Delegates
    func setDelegates(viewController: SavedRecipesViewController) {
        collectionView.delegate = viewController
        collectionView.dataSource = viewController
    }
    //MARK: - UI Setup
    
    private func addSubviews() {
        addSubview(collectionView)
        addSubview(titleLabel)
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 20),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
           
            
        ])
    }
}

