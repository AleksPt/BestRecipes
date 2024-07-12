//
//  CreateIngredientCell.swift
//  best-recipes-ios
//
//  Created by Vladimir Dmitriev on 06.07.24.
//

import UIKit

final class CreateIngredientCell: UICollectionViewCell {
    
    var completionHandlerAdd: (((String, Double, String))->())?
    var completionHandlerDelete: (()->())?
    
    private var ingredientNameTextField = RoundedTextFieldFactory(placeholderText: "Item name").createTextField()
    
    private var quantityTextField = RoundedTextFieldFactory(placeholderText: "Quantity").createTextField()
    
    private let unitTextField = RoundedTextFieldFactory(placeholderText: "Unit").createTextField()
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(Icons.plus.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addIngredient), for: .touchUpInside)
        return button
    }()
    
    private lazy var toolbar = Toolbar.setupToolbar(target: self, selector: #selector(didTapToolbarButton))
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        quantityTextField.keyboardType = .decimalPad
        ingredientNameTextField.inputAccessoryView = toolbar
        quantityTextField.inputAccessoryView = toolbar
        unitTextField.inputAccessoryView = toolbar
        addSubviews()
        setupLayout()
        setDelegates()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Set delegates
    private func setDelegates() {
        ingredientNameTextField.delegate = self
        quantityTextField.delegate = self
        unitTextField.delegate = self
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
    
    private func verifyTextFields() -> (String, Double, String)? {
        var name: String
        var quantity: Double
        var unit: String
        guard let nameValue = ingredientNameTextField.text, !nameValue.isEmpty else {
            return nil
        }
        guard let quantityValue = quantityTextField.text, !quantityValue.isEmpty else {
            return nil
        }
        guard let unitValue = unitTextField.text, !unitValue.isEmpty else {
            return nil
        }
        if let quantityDouble = Double(quantityValue) {
            name = nameValue
            quantity = quantityDouble
            unit = unitValue
            return (name, quantity, unit)
        } else {
            return nil
        }
        
    }
    
    // MARK: - Actions
    @objc private func addIngredient(_ sender: UIButton) {        
        if sender.currentImage == Icons.plus.withRenderingMode(UIImage.RenderingMode.alwaysOriginal) {
            guard let ingredient = verifyTextFields() else {
                return
            }
            completionHandlerAdd?(ingredient)
            sender.setImage(Icons.minus.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), for: .normal)
        } else {
            completionHandlerDelete?()
        }
    }
    
    @objc private func didTapToolbarButton() {
        ingredientNameTextField.resignFirstResponder()
        quantityTextField.resignFirstResponder()
        unitTextField.resignFirstResponder()
    }
}

// MARK: - UITextFieldDelegate
extension CreateIngredientCell: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.CreateRecipe.selectedBorderField.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.CreateRecipe.unselectedBorderField.cgColor
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
