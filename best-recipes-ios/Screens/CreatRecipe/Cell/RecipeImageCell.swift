//
//  RecipeImageCell.swift
//  best-recipes-ios
//
//  Created by Vladimir Dmitriev on 06.07.24.
//

import UIKit

final class RecipeImageCell: UICollectionViewCell {
    
    private var recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 12
        imageView.image = UIImage(named: "recipe-image")
        return imageView
    }()
    
    private var editButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        button.backgroundColor = .white
        button.setImage(UIImage(named: "Edit-Stroke"), for: .normal)
        button.addShadow(offset: CGSize(width: 0, height: 0), color: .black, radius: 25, opacity: 0.15)
        return button
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Public Methods
    func addRecipeImageTapGesture(target: Any, action: Selector) {
        let gesture = UITapGestureRecognizer(target: target, action: action)
        editButton.addGestureRecognizer(gesture)
    }
    
    func setRecipeImage(_ image: UIImage?) {
        recipeImageView.image = image
    }
    
    // MARK: - Private Methods
    private func addSubviews() {
        addSubview(recipeImageView)
        addSubview(editButton)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            recipeImageView.topAnchor.constraint(equalTo: topAnchor),
            recipeImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            recipeImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            recipeImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            editButton.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            editButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            editButton.widthAnchor.constraint(equalToConstant: 32),
            editButton.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
}
