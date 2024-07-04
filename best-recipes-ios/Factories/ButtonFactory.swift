//
//  ButtonFactory.swift
//  best-recipes-ios
//
//  Created by Sergey Zakurakin on 02/07/2024.
//

import UIKit

//MARK: - Onboarding Screen

final class ButtonFactory {
    // onboarding main page Button
    static func onboardingMainPageButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.backgroundColor = .primary50
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: UIFont.Poppins.bold, size: 16)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    // onboarding next pages Button
    static func onboardingPagesButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.backgroundColor = .primary50
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: UIFont.Poppins.regular, size: 20)
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    // onboarding secondary Button
    static func onboardingSecondaryButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.backgroundColor = .clear
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: UIFont.Inter.medium, size: 10)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}
