//
//  RecipeImageCell.swift
//  best-recipes-ios
//
//  Created by Vladimir Dmitriev on 06.07.24.
//

import UIKit

final class RecipeImageCell: UICollectionViewCell {
    
    var completionHandler: (()->())?
    
    // MARK: - UI
    private let recipeImageView = CoverImageFactory.makeCoverImageView(image: .defaultCover)
    
    private lazy var editButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.backgroundColor = .white
        button.setImage(Icons.edit.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), for: .normal)
        button.addShadow(offset: CGSize(width: 0, height: 8), color: .black, radius: 25, opacity: 0.15)
        button.addTarget(self, action: #selector(addImage), for: .touchUpInside)
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
    func setRecipeImage(_ image: UIImage?) {
        recipeImageView.image = image
    }
    
    // MARK: - Actions
    @objc private func addImage() {
        completionHandler?()
    }
    
    // MARK: - Private Methods
    private func addSubviews() {
        addSubview(recipeImageView)
        recipeImageView.addSubview(editButton)
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
