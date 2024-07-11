//
//  ProfileSectionHeaderView.swift
//  best-recipes-ios
//
//  Created by Vladimir Dmitriev on 08.07.24.
//

import UIKit

final class ProfileSectionHeaderView: UICollectionReusableView {
        
    private var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.TextFonts.Home.titleSection
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "My recipes"
        return label
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(label)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    func configure(with title: String) {
        label.text = title
    }
    
    // MARK: - Private Methods
    private func setupLayout() {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            label.topAnchor.constraint(equalTo: topAnchor)
        ])
    }
}
