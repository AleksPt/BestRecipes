//
//  RoundedTextFieldFactory.swift
//  best-recipes-ios
//
//  Created by Vladimir Dmitriev on 06.07.24.
//

import UIKit

protocol TextFieldFactory {
    func createTextField() -> UITextField
}

final class RoundedTextFieldFactory: TextFieldFactory {
    
    let placeholderText: String
    
    init(placeholderText: String) {
        self.placeholderText = placeholderText
    }
    
    func createTextField() -> UITextField {
        
        let textField = UITextField()
        
        textField.placeholder = placeholderText
        textField.borderStyle = .none
        textField.font = UIFont.TextFonts.CreateRecipe.ingredientsField
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.Colors.Neutral.neutral20.cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.rightView = paddingView
        textField.rightViewMode = .always
        
        return textField
    }
}
