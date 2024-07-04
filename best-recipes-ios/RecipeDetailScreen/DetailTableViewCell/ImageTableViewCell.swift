//
//  ImageTableViewCell.swift
//  best-recipes-ios
//
//  Created by Елена Логинова on 04.07.2024.
//

import UIKit

final class ImageTableViewCell: UITableViewCell {

    static let identifier = "ImageTableViewCell"
    
    private let titleLabel: UILabel = {
        let label = LabelFactory.makeScreenTitleLabel(text: "How to make Tasty Fish (point & Kill)")
        return label
    }()
    
    private let recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let reviewLabel: UILabel = {
        let label = LabelFactory.createReviewsLabel(text: "(300 Reviews)")
        return label
    }()
    
    private let ratingView: UIView = {
        let view = RatingFactory.makeSavedTrandingRating(image: UIImageView(image: UIImage(systemName: "star")), ratingLabel: "4,5")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(titleLabel)
        addSubview(recipeImageView)
        addSubview(ratingView)
        addSubview(reviewLabel)
        randomReviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        recipeImageView.image = nil
        titleLabel.text = nil
    }
    
    public func configureCell(with recipe: Recipe) {
        recipeImageView.getImage(from: recipe.imageURL)
        titleLabel.text = recipe.title
        selectionStyle = .none
    }
    
    private func randomReviews() {
        let randomNumber = Int.random(in: 300...5000)
        self.reviewLabel.text = "\(randomNumber) Reviews"
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 19),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -19),

            recipeImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25),
            recipeImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            recipeImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            recipeImageView.heightAnchor.constraint(equalToConstant: 200),
            
            ratingView.leadingAnchor.constraint(equalTo: recipeImageView.leadingAnchor, constant: 0),
            ratingView.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor, constant: 15),
            ratingView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -25),
            
            reviewLabel.leadingAnchor.constraint(equalTo: ratingView.trailingAnchor, constant: 66),
            reviewLabel.centerYAnchor.constraint(equalTo: ratingView.centerYAnchor, constant: 14),
        ])
    }
}
