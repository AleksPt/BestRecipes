//
//  SearchResultTableViewCell.swift
//  best-recipes-ios
//
//  Created by Елена Логинова on 11.07.2024.
//

import UIKit

final class SearchResultTableViewCell: UITableViewCell {

    static let identifier = "SearchResultTableViewCell"
    
    private let backgroundImageView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let backgroundCellView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.9372548461, blue: 0.9372549057, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let recipeTitleLabel: UILabel = {
        let label = LabelFactory.makeRecipeTitleLabel(text: "Fish")
        label.numberOfLines = 0
        return label
    }()
    
    private  let recipeDescriptionStepLabel : UILabel = {
        let label = LabelFactory.makeValueLabel(text: "250g")
        label.numberOfLines = 0
        label.contentMode = .top
        label.textAlignment = .left
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(backgroundCellView)
        backgroundCellView.addSubview(backgroundImageView)
        backgroundImageView.addSubview(recipeImageView)
        backgroundCellView.addSubview(recipeTitleLabel)
        backgroundCellView.addSubview(recipeDescriptionStepLabel)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        recipeTitleLabel.text = nil
        recipeDescriptionStepLabel.text = nil
        recipeImageView.image = nil
    }
    
    public func configureCell(with recipe: Recipe) {
        recipeTitleLabel.text = recipe.title
        recipeDescriptionStepLabel.text = recipe.analyzedInstructions.first?.steps.first?.step
        recipeImageView.getImage(from: recipe.imageURL)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 150),
            
            backgroundCellView.topAnchor.constraint(equalTo: topAnchor, constant: 6.5),
            backgroundCellView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            backgroundCellView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            backgroundCellView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            
            backgroundImageView.leadingAnchor.constraint(equalTo: backgroundCellView.leadingAnchor, constant: 10),
            backgroundImageView.centerYAnchor.constraint(equalTo: backgroundCellView.centerYAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: backgroundCellView.topAnchor, constant: 10),
            backgroundImageView.bottomAnchor.constraint(equalTo: backgroundCellView.bottomAnchor, constant: -10),
            backgroundImageView.widthAnchor.constraint(equalToConstant: 130),
           
            recipeImageView.centerYAnchor.constraint(equalTo: backgroundImageView.centerYAnchor),
            recipeImageView.topAnchor.constraint(equalTo: backgroundImageView.topAnchor, constant: 0),
            recipeImageView.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor, constant: 0),
            recipeImageView.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor, constant: 0),
            recipeImageView.bottomAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: 0),
            
            recipeTitleLabel.topAnchor.constraint(equalTo: backgroundCellView.topAnchor, constant: 10),
            recipeTitleLabel.leadingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor, constant: 10),
            recipeTitleLabel.trailingAnchor.constraint(equalTo: backgroundCellView.trailingAnchor, constant: -10),
            
            recipeDescriptionStepLabel.topAnchor.constraint(equalTo: recipeTitleLabel.bottomAnchor, constant: 0),
            recipeDescriptionStepLabel.leadingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: 10),
            recipeDescriptionStepLabel.trailingAnchor.constraint(equalTo: backgroundCellView.trailingAnchor, constant: -10),
            recipeDescriptionStepLabel.bottomAnchor.constraint(equalTo: backgroundCellView.bottomAnchor, constant: -10),
        ])
    }
}
