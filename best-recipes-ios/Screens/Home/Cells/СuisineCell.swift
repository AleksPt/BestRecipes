//
//  СuisineCell.swift
//  best-recipes-ios
//
//  Created by Алексей on 01.07.2024.
//

import UIKit

final class WorldCuisineCell: UICollectionViewCell {
    
    // MARK: - UI
    private lazy var borderCoverView: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.layer.borderWidth = 1.5
        element.layer.borderColor = UIColor.Home.PopularCategory.cellUnselectedTitle.cgColor
        return element
    }()
    
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
        borderCoverView.layer.cornerRadius = borderCoverView.frame.width / 2
        coverImageView.layer.cornerRadius = coverImageView.frame.width / 2
        
        borderCoverView.heightAnchor.constraint(equalToConstant: borderCoverView.frame.width).isActive = true
        coverImageView.heightAnchor.constraint(equalToConstant: coverImageView.frame.width).isActive = true
    }
    
    // MARK: - Add subviews
    private func addSubviews() {
        addSubview(borderCoverView)
        addSubview(coverImageView)
        addSubview(titleLabel)
    }
    
    // MARK: - Configure Cell
    func configureCell(item: Cuisine) {
        coverImageView.image = UIImage(named: item.rawValue)
        titleLabel.text = item.rawValue
    }
}

// MARK: - Setup Constraints
private extension WorldCuisineCell {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            borderCoverView.topAnchor.constraint(equalTo: topAnchor),
            borderCoverView.leadingAnchor.constraint(equalTo: leadingAnchor),
            borderCoverView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            coverImageView.topAnchor.constraint(equalTo: borderCoverView.topAnchor, constant: 5),
            coverImageView.leadingAnchor.constraint(equalTo: borderCoverView.leadingAnchor, constant: 5),
            coverImageView.trailingAnchor.constraint(equalTo: borderCoverView.trailingAnchor, constant: -5),
            
            titleLabel.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
