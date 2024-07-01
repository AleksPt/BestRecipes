//
//  SeeAllView.swift
//  best-recipes-ios
//
//  Created by Sergey Zakurakin on 01/07/2024.
//

import UIKit

final class SeeAllView: UIView {
    
    private var collectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: 340, height: 200)
        layout.minimumLineSpacing = 24
        
        var collectionView = UICollectionView()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.layer.cornerRadius = 15
        
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "CustomCell")
        return collectionView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraint()
        setViews()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    
    func setDelegates(value: SeeAllViewController) {
        collectionView.delegate = value
        collectionView.dataSource = value
    }
    
    

    //MARK: - setup Views
    private func setViews() {
//        self.title = "Trending Now"
//        self.navigationController?.navigationBar.prefersLargeTitles = true
//        
        
        addSubview(collectionView)
    }
}
