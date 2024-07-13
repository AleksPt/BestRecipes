//
//  CustomCell.swift
//  best-recipes-ios
//
//  Created by Sergey Zakurakin on 01/07/2024.
//

import UIKit

final class CustomCell: UICollectionViewCell {
    
    weak var delegate: FavoriteProtocol?
    private var recipe: Recipe?
    
    //MARK: - UI
    private let ratingLabel = RatingView.make(ratingLabel: "", blur: true)
    
    
    private let coverImageView = CoverImageFactory.makeCoverImageView(image: Images.Trending.tranding1)
    
    private let buttonFavorite = ButtonFactory
        .makeButtonFavorite()
    
    private let titleLabel = LabelFactory
        .makeRecipeTitleLabel(text: "Title")
    
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
    
    
    private lazy var timeLabelInner: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.Colors.Rating.ratingWhite
        label.font = UIFont.PoppinsFont.regular(size: 12)
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var timeLabel: UIView = {
        return ReadyInMinutesFactory.makeView(label: timeLabelInner)
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraint()
        
        buttonFavorite.addTarget(
            self,
            action: #selector(didTapFavorite),
            for: .touchUpInside
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override methods
    override func layoutSubviews() {
        super.layoutSubviews()
        buttonFavorite.layer.cornerRadius = buttonFavorite.frame.size.width / 2
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        coverImageView.image = nil
        titleLabel.text = nil
        avatar.image = nil
        nameAuthor.text = nil
        delegate = nil
        recipe = nil
        timeLabelInner.text = nil
        ratingLabel.setRatingLabel(0.0)
    }
    
    // MARK: - Public methods
    func configure(with item: Recipe, isFavorite: Bool, delegate: FavoriteProtocol) {
        self.recipe = item
        titleLabel.text = item.title
        coverImageView.getImage(from: item.imageURL)
        if let author = Images.Avatars.getAvatar().randomElement() {
            avatar.image = author.value
        }
        nameAuthor.text = item.sourceName
        timeLabelInner.text = convertMinutesToHHMM(item.readyInMinutes)
        ratingLabel.setRatingLabel(item.spoonacularScore)
        self.delegate = delegate
        updateFavoriteButtonAppearance(isFavorite: isFavorite)
    }
    
    private func convertMinutesToHHMM(_ totalMinutes: Int) -> String {
        let hours = totalMinutes / 60
        let minutes = totalMinutes % 60
        return String(format: "%02d:%02d", hours, minutes)
    }
    
    //MARK: - Private methods
    private func setupView() {
        addSubview(coverImageView)
        addSubview(ratingLabel)
        coverImageView.addSubview(buttonFavorite)
        coverImageView.addSubview(timeLabel)
        addSubview(titleLabel)
        addSubview(avatar)
        addSubview(nameAuthor)
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

//MARK: - Setup Constraints
extension CustomCell {
    private func setupConstraint() {
        let widthCell = UIScreen.main.bounds.width - 32
        
        NSLayoutConstraint.activate([
            ratingLabel.topAnchor.constraint(equalTo: coverImageView.topAnchor, constant: 8),
            ratingLabel.leadingAnchor.constraint(equalTo: coverImageView.leadingAnchor, constant: 8),
            
            coverImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            coverImageView.topAnchor.constraint(equalTo: topAnchor),
            coverImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            coverImageView.widthAnchor.constraint(equalToConstant: widthCell),
            coverImageView.heightAnchor.constraint(equalTo: coverImageView.widthAnchor, multiplier: 0.524),
            
            buttonFavorite.topAnchor.constraint(equalTo: coverImageView.topAnchor, constant: 8),
            buttonFavorite.trailingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: -8),
            buttonFavorite.widthAnchor.constraint(equalToConstant: 32),
            buttonFavorite.heightAnchor.constraint(equalToConstant: 32),
            
            timeLabel.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: -49),
            timeLabel.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: -33),
            
            titleLabel.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: avatar.topAnchor, constant: -12),
            
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

