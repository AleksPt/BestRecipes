//
//  RecentCell.swift
//  best-recipes-ios
//
//  Created by Алексей on 01.07.2024.
//

import UIKit

final class RecentCell: UICollectionViewCell {
    
    // MARK: - UI
    private let coverImageView = CoverImageFactory.makeCoverImageView(image: Images.Trending.tranding4)
    
    private let titleLabel = LabelFactory.makeRecentRecipeTitleLabel(text: "Title")
    
    private let nameAuthor = LabelFactory.makeRecentRecipeCreatorLabel(text: "Name")
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Overrides Methods
    override func prepareForReuse() {
        super.prepareForReuse()
        coverImageView.image = nil
        titleLabel.text = nil
        nameAuthor.text = nil
    }
    
    // MARK: - Add subviews
    private func addSubviews() {
        addSubview(coverImageView)
        addSubview(titleLabel)
        addSubview(nameAuthor)
    }
    
    // MARK: - Private methods
    /// Ищет первый пробел в строке и сносит на новый абзац
    private func replaceFirstSpace(in string: String, with character: Character) -> String? {
        if let spaceIndex = string.firstIndex(of: " ") {
            var modifiedString = string
            modifiedString.replaceSubrange(spaceIndex...spaceIndex, with: String(character))
            return modifiedString
        } else {
            return string
        }
    }

    // MARK: - Configure Cell
    func configureCell(item: Recipe) {
        coverImageView.getImage(from: item.imageURL)
        titleLabel.text = replaceFirstSpace(in: item.title, with: "\n")
        nameAuthor.text = "By "
    }
}

// MARK: - Setup Constraints
private extension RecentCell {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            coverImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            coverImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            coverImageView.topAnchor.constraint(equalTo: topAnchor),
            coverImageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -8),
            
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            titleLabel.bottomAnchor.constraint(equalTo: nameAuthor.topAnchor, constant: -4),
            
            nameAuthor.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 3),
            nameAuthor.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            nameAuthor.heightAnchor.constraint(equalToConstant: 14),
            nameAuthor.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
