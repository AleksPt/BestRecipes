//
//  СuisineCell.swift
//  best-recipes-ios
//
//  Created by Алексей on 01.07.2024.
//

import UIKit

final class CuisineCell: UICollectionViewCell {
    
    // MARK: - UI
    private lazy var image: UIImageView = {
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
        addSubview(image)
        setupConstraints()
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        image.layer.cornerRadius = image.frame.width / 2
//    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.image.image = nil
    }
    
    func configureCell(image: UIImage) {
        self.image.image = image
    }
}


// MARK: - Setup Constraints
private extension CuisineCell {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: leadingAnchor),
            image.trailingAnchor.constraint(equalTo: trailingAnchor),
            image.topAnchor.constraint(equalTo: topAnchor),
            image.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
