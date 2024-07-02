//
//  ButtonFactory.swift
//  best-recipes-ios
//
//  Created by Sergey Zakurakin on 02/07/2024.
//

import UIKit



//MARK: - Onboarding Screen

final class ButtonFactory {
    
    static func createButton(title: String, backgroundColor: UIColor, textColor: UIColor, font: UIFont) -> UIButton {
          let button = UIButton(type: .system)
          button.setTitle(title, for: .normal)
          button.backgroundColor = backgroundColor
          button.setTitleColor(textColor, for: .normal)
          button.titleLabel?.font = font
          button.layer.cornerRadius = 15
          button.translatesAutoresizingMaskIntoConstraints = false
          return button
      }
    
    
    
    
    
}
