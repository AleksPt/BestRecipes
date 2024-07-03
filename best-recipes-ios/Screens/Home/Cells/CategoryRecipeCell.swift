//
//  CategoryRecipeCell.swift
//  best-recipes-ios
//
//  Created by Алексей on 01.07.2024.
//

import UIKit

final class CategoryRecipeCell: UICollectionViewCell {
    
    // MARK: - UI
    private lazy var coverImageView: UIImageView = {
        let element = UIImageView()
        element.contentMode = .scaleAspectFill
        element.clipsToBounds = true
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
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
    
    private lazy var titleLabel: UILabel = {
        let element = UILabel()
        element.font = UIFont.TextFonts.Home.PopularCategory.titleCell
        element.textColor = UIColor.Home.title
        element.numberOfLines = 2
        element.textAlignment = .center
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var timeSubtitleLabel: UILabel = {
        let element = UILabel()
        element.font = UIFont.TextFonts.Home.PopularCategory.timeSubtitle
        element.textColor = UIColor.Home.PopularCategory.timeLabel
        element.text = "Time"
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var timeValueLabel: UILabel = {
        let element = UILabel()
        element.font = UIFont.TextFonts.Home.PopularCategory.timeTitle
        element.textColor = UIColor.Home.title
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
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
        shadowView.layer.cornerRadius = shadowView.frame.width / 2
        shadowView.heightAnchor.constraint(equalToConstant: shadowView.frame.width).isActive = true
        
        coverImageView.layer.cornerRadius = shadowView.layer.cornerRadius
    }
    
    // MARK: - Add subviews
    private func addSubviews() {
        addSubview(customBackgroundView)
        addSubview(shadowView)
        shadowView.addSubview(coverImageView)
        customBackgroundView.addSubview(titleLabel)
        customBackgroundView.addSubview(timeSubtitleLabel)
        customBackgroundView.addSubview(timeValueLabel)
        
        shadowView.addShadow(
            offset: CGSize.init(width: 0, height: 8),
            color: UIColor.black,
            radius: 25,
            opacity: 0.25
        )
    }
    
    // MARK: - Configure Cell
    func configureCell(item: Item) {
        coverImageView.image = item.coverImage
        titleLabel.text = item.title
        timeValueLabel.text = item.time.description + " Mins"
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
        ])
    }
}


