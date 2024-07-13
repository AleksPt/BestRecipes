//
//  SavedRecipesCell.swift
//  best-recipes-ios
//
//  Created by Vadim Zhelnov on 4.07.24.
//

import UIKit

final class SavedRecipesCell: UICollectionViewCell {
    
    weak var delegate: FavoriteProtocol?
    private var recipe: Recipe?
    
    static let identifier = "SavedRecipesCell"
    
    // MARK: - UI Components
    
    private var ratingView = RatingView.make(ratingLabel: "", blur: true)
    
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
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.Colors.Rating.ratingWhite
        label.font = UIFont.PoppinsFont.regular(size: 12)
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var saveRecipesTimeLabel: UIView = {
        return ReadyInMinutesFactory.makeView(label: timeLabel)
    }()
    

    
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
        delegate = nil
        recipe = nil
        ratingView.setRatingLabel(0.0)
        timeLabel.text = nil
    }
    
    func configureCell(recipe: Recipe, delegate: FavoriteProtocol) {
        self.recipe = recipe
        recipesImageView.getImage(from: recipe.imageURL)
        recipesTitleLabel.text = recipe.title
        if let author = Images.Avatars.getAvatar().randomElement() {
            cookAvatarImage.image = author.value
            cookNameLabel.text = "By \(author.key)"
        }
        self.delegate = delegate
        updateFavoriteButtonAppearance()
        timeLabel.text = convertMinutesToHHMM(recipe.readyInMinutes)
        ratingView.setRatingLabel(recipe.spoonacularScore)
    }
    
    private func convertMinutesToHHMM(_ totalMinutes: Int) -> String {
        let hours = totalMinutes / 60
        let minutes = totalMinutes % 60
        return String(format: "%02d:%02d", hours, minutes)
    }
    
    private func updateFavoriteButtonAppearance() {
        let bigActiveIcon =
            Icons.TabBar.bookmarkActive
            .withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        likeButton.setImage(bigActiveIcon, for: .normal)
    }
    
    // MARK: - Actions
    @objc func didTapLikeButton(_ sender:UIButton) {
        guard let recipe = recipe else { return }
        delegate?.switchFavorite(for: recipe)
    }
    
    //MARK: - UI Setup
    private func addSubviews() {
        addSubview(recipesImageView)
        addSubview(ratingView)
        recipesImageView.addSubview(likeButton)
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
