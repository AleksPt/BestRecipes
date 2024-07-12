//
//  SavedRecipesCell.swift
//  best-recipes-ios
//
//  Created by Vadim Zhelnov on 4.07.24.
//

import UIKit

final class SavedRecipesCell: UICollectionViewCell {
    
    static let identifier = "SavedRecipesCell"
    
    // MARK: - UI Components
    
    private var ratingView = RatingFactory.makeSavedTrandingRating(image: UIImageView(image: Icons.star), ratingLabel: "2.9")
    private let likeButton : UIButton = {
        var button = ButtonFactory.makeButtonFavorite(isActive: true)
        button.layer.cornerRadius = 16
        return button
    }()
    
    private var recipesImageView = CoverImageFactory.makeCoverImageView(image: Images.Trending.tranding1)
    private var recipesTitleLabel = LabelFactory
        .makeRecipeTitleLabel(text: "Title Recipe")
    private var cookAvatarImage : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 16
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private var cookNameLabel = LabelFactory.makeCreatorNameLabel(text: "")
    private let saveRecipesTimeLabel = ReadyInMinutesFactory.makeView(ratingLabel: "15:10")

    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
        likeButton.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - Configure Cell
    override func prepareForReuse() {
        super.prepareForReuse()
        recipesImageView.image = nil
        recipesTitleLabel.text = nil
        cookAvatarImage.image = nil
        cookNameLabel.text = nil
    }
    func configureCell(recipe:Recipe) {
        recipesImageView.getImage(from: recipe.imageURL)
        recipesTitleLabel.text = recipe.title
        if let author = Images.Avatars.getAvatar().randomElement() {
            cookAvatarImage.image = author.value
            cookNameLabel.text = "By \(author.key)"
        }
    }
    
    // MARK: - Actions
    @objc func didTapLikeButton(_ sender:UIButton) {
        if sender.isSelected {
    
        }
    }
    
    //MARK: - UI Setup
    private func addSubviews() {
        addSubview(recipesImageView)
        recipesImageView.addSubview(likeButton)
        recipesImageView.addSubview(ratingView)
        recipesImageView.addSubview(saveRecipesTimeLabel)
        addSubview(recipesTitleLabel)
        addSubview(cookAvatarImage)
        addSubview(cookNameLabel)
    }
        
    // MARK: - Setup Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            recipesImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            recipesImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            recipesImageView.topAnchor.constraint(equalTo: topAnchor),
            recipesImageView.bottomAnchor.constraint(equalTo: recipesTitleLabel.topAnchor, constant: -12),
            
            ratingView.leadingAnchor.constraint(equalTo: recipesImageView.leadingAnchor, constant: 8),
            ratingView.topAnchor.constraint(equalTo: recipesImageView.topAnchor, constant: 8),
            
            likeButton.topAnchor.constraint(equalTo: recipesImageView.topAnchor, constant: 8),
            likeButton.trailingAnchor.constraint(equalTo: recipesImageView.trailingAnchor, constant: -8),
            likeButton.widthAnchor.constraint(equalToConstant: 32),
            likeButton.heightAnchor.constraint(equalToConstant: 32),
            
            saveRecipesTimeLabel.leadingAnchor.constraint(equalTo: recipesImageView.trailingAnchor, constant: -49),
            saveRecipesTimeLabel.topAnchor.constraint(equalTo: recipesImageView.bottomAnchor, constant: -33),
            
            recipesTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            recipesTitleLabel.heightAnchor.constraint(equalToConstant: 22),
            recipesTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            recipesTitleLabel.bottomAnchor.constraint(equalTo: cookAvatarImage.topAnchor, constant: -8),
            
            cookAvatarImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            cookAvatarImage.widthAnchor.constraint(equalToConstant: 32),
            cookAvatarImage.heightAnchor.constraint(equalToConstant: 32),
            cookAvatarImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            cookNameLabel.leadingAnchor.constraint(equalTo: cookAvatarImage.trailingAnchor, constant: 8),
            cookNameLabel.centerYAnchor.constraint(equalTo: cookAvatarImage.centerYAnchor),
            cookNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
        ])
    }
}
