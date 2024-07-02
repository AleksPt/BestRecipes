//
//  HeaderSupplementaryView.swift
//  best-recipes-ios
//
//  Created by Алексей on 01.07.2024.
//

import UIKit

final class HeaderSupplementaryView: UICollectionReusableView {
    
    // MARK: - UI
    private lazy var title: UILabel = {
        let element = UILabel()
        element.font = UIFont.TextFonts.Home.titleSection
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(title)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configureHeader(title: String, section: Int) {
        self.title.text = title

        switch section {
        case 0:
            guard self.title.text != nil else { return }
            self.title.text! += " 🔥"
        default:
            break
        }
    }
}

// MARK: - Setup Constraints
private extension HeaderSupplementaryView {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            title.centerYAnchor.constraint(equalTo: centerYAnchor),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
        ])
    }
}
