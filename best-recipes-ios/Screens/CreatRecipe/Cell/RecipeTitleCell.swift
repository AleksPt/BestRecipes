//
//  RecipeTitleCell.swift
//  best-recipes-ios
//
//  Created by Vladimir Dmitriev on 06.07.24.
//

import UIKit

final class RecipeTitleCell: UICollectionViewCell, UITextFieldDelegate {
    
    private var titleTextField: UITextField = {
        let textField = RoundedTextFieldFactory(placeholderText: "recipe name")
        return textField.createTextField()
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleTextField.delegate = self
        addSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        titleTextField.layer.borderColor = UIColor.CreateRecipe.selectedBorderField.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        titleTextField.layer.borderColor = UIColor.CreateRecipe.unselectedBorderField.cgColor
    }
    
    // MARK: - Public Methods
    
    
    // MARK: - Private Methods
    private func addSubviews() {
        addSubview(titleTextField)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: topAnchor),
            titleTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleTextField.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
