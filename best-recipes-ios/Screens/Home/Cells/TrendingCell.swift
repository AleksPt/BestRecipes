//
//  TrendingCell.swift
//  best-recipes-ios
//
//  Created by Алексей on 01.07.2024.
//

import UIKit

final class TrendingCell: UICollectionViewCell {
    
    weak var delegate: FavoriteProtocol?
    private var recipe: Recipe?
    
    // MARK: - UI
    private lazy var ratingView = RatingView.make(ratingLabel: "", blur: true)
    
    private let buttonFavorite = ButtonFactory
        .makeButtonFavorite()
    
    private let coverImageView = CoverImageFactory
        .makeCoverImageView(image: Images.Trending.tranding4)
    
    private let titleLabel = LabelFactory
        .makeRecipeTitleLabel(text: "Title Recipe")
    
    private lazy var avatar: UIImageView = {
        let element = UIImageView()
        element.contentMode = .scaleAspectFill
        element.clipsToBounds = true
        element.layer.cornerRadius = 16
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let nameAuthor = LabelFactory
        .makeCreatorNameLabel(text: "Name")
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()

        buttonFavorite.addTarget(
            self,
            action: #selector(didTapFavorite),
            for: .touchUpInside
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Overrides methods
    override func prepareForReuse() {
        super.prepareForReuse()
        coverImageView.image = nil
        titleLabel.text = nil
        avatar.image = nil
        nameAuthor.text = nil
        delegate = nil
        recipe = nil
        ratingView.setRatingLabel(0.0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        buttonFavorite.layer.cornerRadius = buttonFavorite.frame.size.width / 2
    }
    
    // MARK: - Configure Cell
    func configureCell(item: Recipe, isFavorite: Bool, delegate: FavoriteProtocol) {
        self.recipe = item
        coverImageView.getImage(from: item.imageURL)
        titleLabel.text = item.title
        if let author = Images.Avatars.getAvatar().randomElement() {
            avatar.image = author.value
        }
        ratingView.setRatingLabel(item.spoonacularScore)
        nameAuthor.text = item.sourceName
        self.delegate = delegate
        updateFavoriteButtonAppearance(isFavorite: isFavorite)
    }
    
    // MARK: - Add subviews
    private func addSubviews(){
        addSubview(coverImageView)
        addSubview(titleLabel)
        addSubview(avatar)
        addSubview(nameAuthor)
        addSubview(ratingView)
        coverImageView.addSubview(ratingView)
        coverImageView.addSubview(buttonFavorite)
    }
    
    private func updateFavoriteButtonAppearance(isFavorite: Bool) {
        let bigActiveIcon =
            Icons.TabBar.bookmarkActive
            .withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        let bigInactiveIcon =
            Icons.TabBar.bookmarkInactive
            .withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        let image = isFavorite ? bigActiveIcon : bigInactiveIcon
        buttonFavorite.setImage(image, for: .normal)
    }
    
    // MARK: - Actions
    @objc private func didTapFavorite(_ sender: UIButton) {
        guard let recipe = recipe else { return }
        delegate?.switchFavorite(for: recipe)
    }
}

// MARK: - Setup Constraints
private extension TrendingCell {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            coverImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            coverImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            coverImageView.topAnchor.constraint(equalTo: topAnchor),
            coverImageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -12),
            
            ratingView.leadingAnchor.constraint(equalTo: coverImageView.leadingAnchor, constant: 8),
            ratingView.topAnchor.constraint(equalTo: coverImageView.topAnchor, constant: 8),
            
            buttonFavorite.topAnchor.constraint(equalTo: coverImageView.topAnchor, constant: 8),
            buttonFavorite.trailingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: -8),
            buttonFavorite.widthAnchor.constraint(equalToConstant: 32),
            buttonFavorite.heightAnchor.constraint(equalToConstant: 32),
            
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 22),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: avatar.topAnchor, constant: -8),
            
            avatar.leadingAnchor.constraint(equalTo: leadingAnchor),
            avatar.widthAnchor.constraint(equalToConstant: 32),
            avatar.heightAnchor.constraint(equalToConstant: 32),
            avatar.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            nameAuthor.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 8),
            nameAuthor.centerYAnchor.constraint(equalTo: avatar.centerYAnchor),
            nameAuthor.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
