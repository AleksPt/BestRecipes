//
//  ProfileView.swift
//  best-recipes-ios
//
//  Created by Vladimir Dmitriev on 05.07.24.
//

import UIKit

final class ProfileView: UIView {
    
    let collectionView: UICollectionView
        
    // MARK: - Init
    override init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(frame: frame)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(collectionView)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods
    private func setupLayout() {
        NSLayoutConstraint.activate(
            [
                collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
                collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ]
        )
    }
}
