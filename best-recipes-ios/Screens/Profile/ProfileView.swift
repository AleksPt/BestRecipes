//
//  ProfileView.swift
//  best-recipes-ios
//
//  Created by Vladimir Dmitriev on 05.07.24.
//

import UIKit

final class ProfileView: UIView {
    
    let collectionView: UICollectionView
    
    let emptyMessageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.PoppinsFont.regular(size: 24)
        label.textColor = UIColor.Colors.Neutral.neutral30
        label.numberOfLines = 0
        label.contentMode = .center
        label.textAlignment = .center
        label.text = "You haven't created any recipes yet"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    // MARK: - Init
    override init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(frame: frame)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(collectionView)
        addSubview(emptyMessageLabel)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showLabel() {
        emptyMessageLabel.alpha = 1
    }
    
    func hideLabel() {
        emptyMessageLabel.alpha = 0
    }

    // MARK: - Private Methods
    private func setupLayout() {
        NSLayoutConstraint.activate(
            [
                emptyMessageLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                emptyMessageLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
                emptyMessageLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
                emptyMessageLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
                
                collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
                collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ]
        )
    }
}
