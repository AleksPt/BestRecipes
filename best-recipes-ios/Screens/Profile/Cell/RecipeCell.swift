//
//  RecipeCell.swift
//  best-recipes-ios
//
//  Created by Vladimir Dmitriev on 04.07.24.
//

import UIKit

final class RecipeCell: UICollectionViewCell {
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    
    private var ratingView = RatingView.make(ratingLabel: "", blur: true)
    
    private var recipeTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont.TextFonts.Home.Trending.titleTrendingCell
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var ingredientsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.TextFonts.SeeAll.timeLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.TextFonts.SeeAll.timeLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var subTitleStack: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        return stackView
    }()
    
    private var titleStack: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()
    private var textStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupLayout()
        imageView.addGradient()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.addGradient()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        recipeTitleLabel.text = nil
        ingredientsLabel.text = nil
        timeLabel.text = nil
        ratingView.setRatingLabel(0.0)
    }
    
    // MARK: - Public Methods
    func configure(with recipe: Recipe, imageData: Data?) {
        recipeTitleLabel.text = recipe.title
        ingredientsLabel.text = "\(recipe.extendedIngredients.count) ingredients"
        timeLabel.text = "\(recipe.readyInMinutes) mins"
        guard let image = imageData else {
            imageView.image = UIImage(named: "defaultCover")
            return
        }
        ratingView.setRatingLabel(recipe.spoonacularScore)
        imageView.image = UIImage(data: image)
    }
    
    // MARK: - Private Methods
    private func addSubviews(){
        addSubview(imageView)
        addSubview(ratingView)
        
        subTitleStack.addArrangedSubview(ingredientsLabel)
        subTitleStack.addArrangedSubview(lineView)
        subTitleStack.addArrangedSubview(timeLabel)
        
        titleStack.addArrangedSubview(recipeTitleLabel)
        titleStack.addArrangedSubview(subTitleStack)
        
        textStack.addArrangedSubview(ratingView)
        textStack.addArrangedSubview(titleStack)
        
        addSubview(textStack)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            lineView.widthAnchor.constraint(equalToConstant: 1),
            lineView.heightAnchor.constraint(equalToConstant: 18),
            
            textStack.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            textStack.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            textStack.widthAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.90),
            textStack.heightAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 0.85)
        ])
    }
    
}
