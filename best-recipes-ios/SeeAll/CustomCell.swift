//
//  CustomCell.swift
//  best-recipes-ios
//
//  Created by Sergey Zakurakin on 01/07/2024.
//

import UIKit


final class CustomCell: UICollectionViewCell {
    
    //MARK: - Setup UI
    lazy var ratingButton: UIButton = {
        let element = UIButton(type: .system)
        element.backgroundColor = .black
        element.layer.cornerRadius = 10
        element.setTitle("5", for: .normal)
        //        element.imageView?.image = UIImage(systemName: "star.fill")
        element.alpha = 0.9
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    lazy var titleLabel: UILabel = {
        let element = UILabel()
        element.textAlignment = .left
        element.numberOfLines = 0
        element.textColor = .white
        element.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    lazy var descriptionLabel: UILabel = {
        let element = UILabel()
        element.textAlignment = .left
        element.textColor = .white
        element.font = UIFont.systemFont(ofSize: 14)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    lazy var imageView: UIImageView = {
        let element = UIImageView()
        
        element.contentMode = .scaleAspectFit
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    //MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Setup View
    private func setupView() {
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true
        
        contentView.addSubview(imageView)
        contentView.addSubview(ratingButton)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
    }
    
    
    func configure(with type: RecipesType) {
        switch type {
        case .tradingNow(let title, let description, let image):
            titleLabel.text = title
            descriptionLabel.text = description
            imageView.image = image
        case .recentRecipe(let title, let description, let image):
            titleLabel.text = title
            descriptionLabel.text = description
            imageView.image = image
        case .popularCreators(let title, let description, let image):
            titleLabel.text = title
            descriptionLabel.text = description
            imageView.image = image
        }
    }
    
}


//MARK: - Setup Constraints
extension CustomCell {
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            ratingButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            ratingButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            titleLabel.bottomAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: -20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
}

