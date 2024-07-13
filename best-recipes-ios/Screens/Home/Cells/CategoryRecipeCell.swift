//
//  CategoryRecipeCell.swift
//  best-recipes-ios
//
//  Created by Алексей on 01.07.2024.
//

import UIKit

final class CategoryRecipeCell: UICollectionViewCell {
    
    // MARK: - UI
    private let coverImageView = CoverImageFactory.makeCoverImageView(image: Images.Trending.tranding4)
    
    private lazy var shadowView: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var customBackgroundView: UIView = {
        let element = UIView()
        element.layer.cornerRadius = 12
        element.backgroundColor = UIColor.Home.PopularCategory.viewBackground
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let titleLabel = LabelFactory.makePopularRecipeTitleLabel(text: "Title")
    
    private let timeSubtitleLabel = LabelFactory.makeTimeLabel(text: "Time")
    
    private let timeValueLabel = LabelFactory.makeMinutesLabel(text: "")
    
    private let buttonFavorite = ButtonFactory.makeButtonFavorite(bigSize: false)
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
        
        buttonFavorite.addTarget(self, action: #selector(didTapFavorite), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Overrides methods
    override func prepareForReuse() {
        super.prepareForReuse()
        coverImageView.image = nil
        titleLabel.text = nil
        timeValueLabel.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        buttonFavorite.layer.cornerRadius = buttonFavorite.frame.size.width / 2
        shadowView.layer.cornerRadius = shadowView.frame.width / 2
        shadowView.heightAnchor.constraint(equalToConstant: shadowView.frame.width).isActive = true
        coverImageView.layer.cornerRadius = shadowView.layer.cornerRadius
        shadowView.addShadow(
            offset: CGSize.init(width: 0, height: 8),
            color: UIColor.black,
            radius: 25,
            opacity: 0.25
        )

        let titleLabelBottomConstraint = titleLabel.bottomAnchor.constraint(equalTo: timeSubtitleLabel.topAnchor, constant: -5)
        titleLabelBottomConstraint.priority = .defaultHigh
        titleLabelBottomConstraint.isActive = true
    }
    
    // MARK: - Add subviews
    private func addSubviews() {
        addSubview(customBackgroundView)
        addSubview(shadowView)
        shadowView.addSubview(coverImageView)
        customBackgroundView.addSubview(titleLabel)
        customBackgroundView.addSubview(timeSubtitleLabel)
        customBackgroundView.addSubview(timeValueLabel)
        customBackgroundView.addSubview(buttonFavorite)
    }
    
    // MARK: - Configure Cell
    func configureCell(item: Recipe) {
        coverImageView.getImage(from: item.imageURL)
        titleLabel.text = item.title
        timeValueLabel.text = item.readyInMinutes.description + " Mins"
    }
    
    // MARK: - Actions
    @objc private func didTapFavorite(_ sender: UIButton) {
        let smallActiveIcon = Icons.bookmarkActiveSmall.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        let smallInctiveIcon = Icons.bookmarkInactiveSmall.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        let image = sender.currentImage == smallActiveIcon ? smallInctiveIcon : smallActiveIcon
        sender.setImage(image, for: .normal)
    }
}


// MARK: - Setup Constraints
private extension CategoryRecipeCell {
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            shadowView.topAnchor.constraint(equalTo: topAnchor),
            shadowView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22),
            shadowView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22),
            
            coverImageView.topAnchor.constraint(equalTo: shadowView.topAnchor),
            coverImageView.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor),
            coverImageView.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor),
            coverImageView.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor),
            
            customBackgroundView.topAnchor.constraint(equalTo: shadowView.centerYAnchor),
            customBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            customBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            customBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            
            titleLabel.topAnchor.constraint(equalTo: shadowView.bottomAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: customBackgroundView.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: customBackgroundView.trailingAnchor, constant: -12),
            
            timeSubtitleLabel.leadingAnchor.constraint(equalTo: customBackgroundView.leadingAnchor, constant: 12),
            timeSubtitleLabel.bottomAnchor.constraint(equalTo: timeValueLabel.topAnchor, constant: -4),
            
            timeValueLabel.leadingAnchor.constraint(equalTo: customBackgroundView.leadingAnchor, constant: 12),
            timeValueLabel.bottomAnchor.constraint(equalTo: customBackgroundView.bottomAnchor, constant: -11),
            
            buttonFavorite.trailingAnchor.constraint(equalTo: customBackgroundView.trailingAnchor, constant: -12),
            buttonFavorite.bottomAnchor.constraint(equalTo: customBackgroundView.bottomAnchor, constant: -11),
            buttonFavorite.widthAnchor.constraint(equalToConstant: 24),
            buttonFavorite.heightAnchor.constraint(equalToConstant: 24),
        ])
    }
}


