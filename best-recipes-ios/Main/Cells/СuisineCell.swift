//
//  СuisineCell.swift
//  best-recipes-ios
//
//  Created by Алексей on 01.07.2024.
//

import UIKit

final class CuisineCell: UICollectionViewCell {
    
    // MARK: - UI
    private lazy var coverImageView: UIImageView = {
        let element = UIImageView()
        element.contentMode = .scaleAspectFill
        element.clipsToBounds = true
        element.translatesAutoresizingMaskIntoConstraints = false
        element.layer.cornerRadius = 10
        return element
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(coverImageView)
        setupConstraints()
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        image.layer.cornerRadius = image.frame.width / 2
//    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Overrides methods
    override func prepareForReuse() {
        super.prepareForReuse()
        self.coverImageView.image = nil
    }
    
    func configureCell(item: Item) {
        coverImageView.image = item.coverImage
    }
}

// MARK: - Setup Constraints
private extension CuisineCell {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            coverImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            coverImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            coverImageView.topAnchor.constraint(equalTo: topAnchor),
            coverImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
