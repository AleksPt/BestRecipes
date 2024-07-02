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
    
    // MARK: - Overrides methods
    override func prepareForReuse() {
        title.text = nil
    }
    
    // MARK: - Configure Header
    func configureHeader(section: Int) {
        switch section {
        case 0:
            title.text = "Trending now 🔥"
        case 1:
            title.text = "Popular category"
        case 2:
            title.text = ""
        case 3:
            title.text = "Recent recipe"
        case 4:
            title.text = "World cuisine"
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
