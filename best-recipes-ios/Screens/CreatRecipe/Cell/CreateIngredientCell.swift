//
//  CreateIngredientCell.swift
//  best-recipes-ios
//
//  Created by Vladimir Dmitriev on 06.07.24.
//

import UIKit

final class CreateIngredientCell: UICollectionViewCell, UITextFieldDelegate {
    
    private var ingredientNameTextField: UITextField = {
        let textField = RoundedTextFieldFactory(placeholderText: "Item name")
        return textField.createTextField()
    }()
    
    private var quantityTextField: UITextField = {
        let textField = RoundedTextFieldFactory(placeholderText: "Quantity")
        return textField.createTextField()
    }()
    
    private var unitTextField: UITextField = {
        let textField = RoundedTextFieldFactory(placeholderText: "Unit")
        return textField.createTextField()
    }()
    
    private var button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Plus-Border"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        ingredientNameTextField.delegate = self
        quantityTextField.delegate = self
        unitTextField.delegate = self
        
        addSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.CreateRecipe.selectedBorderField.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.CreateRecipe.unselectedBorderField.cgColor
    }
    
    // MARK: - Private Methods
    private func addSubviews() {
        addSubview(ingredientNameTextField)
        addSubview(quantityTextField)
        addSubview(unitTextField)
        addSubview(button)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            ingredientNameTextField.topAnchor.constraint(equalTo: topAnchor),
            ingredientNameTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            ingredientNameTextField.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            quantityTextField.heightAnchor.constraint(equalTo: ingredientNameTextField.heightAnchor),
            quantityTextField.widthAnchor.constraint(equalTo: ingredientNameTextField.widthAnchor, multiplier: 0.7),
            quantityTextField.leadingAnchor.constraint(equalTo: ingredientNameTextField.trailingAnchor, constant: 12),
            
            unitTextField.heightAnchor.constraint(equalTo: quantityTextField.heightAnchor),
            unitTextField.widthAnchor.constraint(equalTo: quantityTextField.widthAnchor, multiplier: 0.7),
            unitTextField.leadingAnchor.constraint(equalTo: quantityTextField.trailingAnchor, constant: 12),
            
            button.centerYAnchor.constraint(equalTo: centerYAnchor),
            button.leadingAnchor.constraint(equalTo: unitTextField.trailingAnchor, constant: 12),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.heightAnchor.constraint(equalToConstant: 24),
            button.widthAnchor.constraint(equalToConstant: 24)
        ])
    }
}

