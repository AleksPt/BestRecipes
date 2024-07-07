//
//  CustomCell.swift
//  best-recipes-ios
//
//  Created by Sergey Zakurakin on 01/07/2024.
//

import UIKit


final class CustomCell: UICollectionViewCell {
    
    //MARK: - Setup UI
    private let ratingLabel = RatingFactory.makeSavedTrandingRating(
        image: UIImageView(image: UIImage(resource: .star)),
        ratingLabel: "5,0",
        blur: true
    )
    
    private let titleLabel = LabelFactory.makeTrendScreenRecipeTitleLabel(text: "")
    
    private let descriptionLabel = LabelFactory.maketTrendScreenValueLabel(text: "")
    
    lazy var imageView: UIImageView = {
        let element = UIImageView()
        
        element.contentMode = .scaleAspectFill
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
        contentView.addSubview(ratingLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
    }
    
    
    func configure(with item: Item) {
        titleLabel.text = item.title
        imageView.image = item.coverImage
        descriptionLabel.text = "\(item.category.rawValue.count) ingradients | \(item.time) min"
    }
}


//MARK: - Setup Constraints
extension CustomCell {
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            ratingLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            ratingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            titleLabel.bottomAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: -20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            imageView.heightAnchor.constraint(equalToConstant: 250),
            imageView.widthAnchor.constraint(equalToConstant: 400),
        ])
    }
}

