//
//  RecentCell.swift
//  best-recipes-ios
//
//  Created by Алексей on 01.07.2024.
//

import UIKit

final class RecentCell: UICollectionViewCell {
    
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
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Overrides Methods
    override func prepareForReuse() {
        super.prepareForReuse()
        self.coverImageView.image = nil
    }
    
    // MARK: - Configure Cell
    func configureCell(item: Item) {
        coverImageView.image = item.coverImage
    }
}


// MARK: - Setup Constraints
private extension RecentCell {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            coverImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            coverImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            coverImageView.topAnchor.constraint(equalTo: topAnchor),
            coverImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
