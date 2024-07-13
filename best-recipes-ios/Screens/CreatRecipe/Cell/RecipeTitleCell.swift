//
//  RecipeTitleCell.swift
//  best-recipes-ios
//
//  Created by Vladimir Dmitriev on 06.07.24.
//

import UIKit

final class RecipeTitleCell: UICollectionViewCell {
    
    var completionHandler: ((String)->())?
    
    private var titleTextField: UITextField = {
        let textField = RoundedTextFieldFactory(placeholderText: "Enter recipe name")
        return textField.createTextField()
    }()
    
    private lazy var toolbar = Toolbar.setupToolbar(target: self, selector: #selector(didTapToolbarButton))
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleTextField.delegate = self
        titleTextField.inputAccessoryView = toolbar
        addSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
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
    
    @objc private func didTapToolbarButton() {
        titleTextField.resignFirstResponder()
    }
}

// MARK: - UITextFieldDelegate
extension RecipeTitleCell: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        titleTextField.layer.borderColor = UIColor.CreateRecipe.selectedBorderField.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        titleTextField.layer.borderColor = UIColor.CreateRecipe.unselectedBorderField.cgColor
        
        guard let text = textField.text, !text.isEmpty else {
            return
        }
        completionHandler?(text)
    }
}
