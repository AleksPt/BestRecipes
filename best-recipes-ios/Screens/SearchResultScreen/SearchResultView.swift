//
//  SearchResultView.swift
//  best-recipes-ios
//
//  Created by Елена Логинова on 11.07.2024.
//

import UIKit

final class SearchResultView: UIView {
    
    //MARK: -  UI Elements
    let searchResultCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.bounces = false
        collectionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let emptyMessageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.PoppinsFont.regular(size: 24)
        label.textColor = UIColor.Colors.Neutral.neutral30
        label.numberOfLines = 0
        label.contentMode = .center
        label.textAlignment = .center
        label.text = "Looking for a recipe for you"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Set Delegates
    func setDelegate(viewController: SearchResultViewController) {
        searchResultCollectionView.delegate = viewController
        searchResultCollectionView.dataSource = viewController
    }
    
    private func setupView() {
        addSubview(searchResultCollectionView)
        addSubview(emptyMessageLabel)
    }
    
    func showLabel() {
        emptyMessageLabel.alpha = 1
    }
    
    func hideLabel() {
        emptyMessageLabel.alpha = 0
    }
    
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            emptyMessageLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            emptyMessageLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            emptyMessageLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            emptyMessageLabel.heightAnchor.constraint(equalToConstant: 250),
            
            searchResultCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            searchResultCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchResultCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchResultCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
