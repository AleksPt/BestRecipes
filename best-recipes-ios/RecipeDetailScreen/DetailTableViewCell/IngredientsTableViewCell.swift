//
//  IngredientsTableViewCell.swift
//  best-recipes-ios
//
//  Created by Елена Логинова on 04.07.2024.
//

import UIKit

final class IngredientsTableViewCell: UITableViewCell {

    static let identifier = "IngredientsTableViewCell"
    
    private let backgroundIngredientView: UIView = {
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
    
    private let ingredientImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "Ingredients") //Icons.Ingredients.cucumber
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        
    }()
    private  let ingredientNameLabel: UILabel = {
        let label = LabelFactory.makeRecipeTitleLabel(text: "Fish")
        return label
    }()
    
    private  let countItemsLabel: UILabel = {
        let label = LabelFactory.makeValueLabel(text: "250g")
        return label
    }()
    
    let checkCircleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "uncheckCircle")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        backgroundCellView.addSubview(backgroundIngredientView)
        backgroundIngredientView.addSubview(ingredientImageView)
        backgroundCellView.addSubview(ingredientNameLabel)
        backgroundCellView.addSubview(countItemsLabel)
        backgroundCellView.addSubview(checkCircleImageView)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        ingredientNameLabel.text = nil
        countItemsLabel.text = nil
        ingredientImageView.image = nil
    }
    
    public func configureCell(with ingredient: Ingredient) {
        ingredientNameLabel.text = ingredient.capitalizedName
        let measureUntilShort = ingredient.measures.metric.unitShort
        let amountIngredient = String(format: "%.1f", ingredient.measures.metric.amount)
        countItemsLabel.text = "\(amountIngredient)" + " " + "\(measureUntilShort)"
        ingredientImageView.getImage(from: ingredient.fullImageURL)
        selectionStyle = .none
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(greaterThanOrEqualToConstant: 100),
            
            backgroundCellView.topAnchor.constraint(equalTo: topAnchor, constant: 6.5),
            backgroundCellView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            backgroundCellView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            backgroundCellView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            
            backgroundIngredientView.leadingAnchor.constraint(equalTo: backgroundCellView.leadingAnchor, constant: 10),
            backgroundIngredientView.centerYAnchor.constraint(equalTo: backgroundCellView.centerYAnchor),
            backgroundIngredientView.widthAnchor.constraint(equalToConstant: 45),
            backgroundIngredientView.heightAnchor.constraint(equalToConstant: 45),
            
            ingredientImageView.centerYAnchor.constraint(equalTo: backgroundIngredientView.centerYAnchor),
            ingredientImageView.centerXAnchor.constraint(equalTo: backgroundIngredientView.centerXAnchor),
            ingredientImageView.topAnchor.constraint(equalTo: backgroundIngredientView.topAnchor, constant: 2),
            ingredientImageView.leadingAnchor.constraint(equalTo: backgroundIngredientView.leadingAnchor, constant: 2),
            ingredientImageView.trailingAnchor.constraint(equalTo: backgroundIngredientView.trailingAnchor, constant: -2),
            ingredientImageView.bottomAnchor.constraint(equalTo: backgroundIngredientView.bottomAnchor, constant: -2),
            
            ingredientNameLabel.centerYAnchor.constraint(equalTo: backgroundIngredientView.centerYAnchor),
            ingredientNameLabel.leadingAnchor.constraint(equalTo: backgroundIngredientView.trailingAnchor, constant: 10),
            
            countItemsLabel.centerYAnchor.constraint(equalTo: backgroundIngredientView.centerYAnchor),
            countItemsLabel.leadingAnchor.constraint(equalTo: ingredientNameLabel.trailingAnchor, constant: -20),
            
            checkCircleImageView.centerYAnchor.constraint(equalTo: backgroundIngredientView.centerYAnchor),
            checkCircleImageView.leadingAnchor.constraint(equalTo: countItemsLabel.trailingAnchor, constant: 10),
            checkCircleImageView.trailingAnchor.constraint(equalTo: backgroundCellView.trailingAnchor, constant: -16),
            checkCircleImageView.heightAnchor.constraint(equalToConstant: 23.08),
            checkCircleImageView.widthAnchor.constraint(equalToConstant: 23.08),
        ])
    }

}
