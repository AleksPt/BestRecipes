//
//  СuisineCell.swift
//  best-recipes-ios
//
//  Created by Алексей on 01.07.2024.
//

import UIKit

final class WorldCuisineCell: UICollectionViewCell {
    
    // MARK: - UI
    private let coverImageView = CoverImageFactory.makeCoverImageView(image: Images.Trending.tranding4)
    
    private let titleLabel = LabelFactory.makePopularCreatorNameLabel(text: "Country")
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Overrides methods
    override func prepareForReuse() {
        super.prepareForReuse()
        coverImageView.image = nil
        titleLabel.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        coverImageView.layer.cornerRadius = coverImageView.frame.width / 2
        coverImageView.heightAnchor.constraint(equalToConstant: coverImageView.frame.width).isActive = true
    }
    
    // MARK: - Add subviews
    private func addSubviews() {
        addSubview(coverImageView)
        addSubview(titleLabel)
    }
    
    // MARK: - Configure Cell
    func configureCell(item: String) {
        coverImageView.image = Images.Popular.popular4
        titleLabel.text = item
    }
}

// MARK: - Setup Constraints
private extension WorldCuisineCell {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            coverImageView.topAnchor.constraint(equalTo: topAnchor),
            coverImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            coverImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
