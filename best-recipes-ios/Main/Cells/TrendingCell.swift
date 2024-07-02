//
//  TrendingCell.swift
//  best-recipes-ios
//
//  Created by Алексей on 01.07.2024.
//

import UIKit

final class TrendingCell: UICollectionViewCell {
    
    // MARK: - UI
    private lazy var coverImageView: UIImageView = {
        let element = UIImageView()
        element.contentMode = .scaleAspectFill
        element.clipsToBounds = true
        element.translatesAutoresizingMaskIntoConstraints = false
        element.layer.cornerRadius = 10
        return element
    }()
    
    private lazy var titleLabel: UILabel = {
        let element = UILabel()
        element.font = UIFont.TextFonts.Home.Trending.titleTrendingCell
        element.textColor = UIColor.Home.title
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var avatar: UIImageView = {
        let element = UIImageView()
        element.contentMode = .scaleAspectFill
        element.clipsToBounds = true
        element.layer.cornerRadius = 16
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var nameAuthor: UILabel = {
        let element = UILabel()
        element.font = UIFont.TextFonts.Home.Trending.nameAuthor
        element.textColor = UIColor.Home.authorName
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
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
        avatar.image = nil
        nameAuthor.text = nil
    }
    
    // MARK: - Configure Cell
    func configureCell(item: Item) {
        coverImageView.image = item.coverImage
        titleLabel.text = item.title
        avatar.image = item.avatar
        nameAuthor.text = "By " + item.nameAuthor
    }
    
    // MARK: - Add subviews
    private func addSubviews(){
        addSubview(coverImageView)
        addSubview(titleLabel)
        addSubview(avatar)
        addSubview(nameAuthor)
    }
}

// MARK: - Setup Constraints
private extension TrendingCell {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            coverImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            coverImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            coverImageView.topAnchor.constraint(equalTo: topAnchor),
            coverImageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -12),
            
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 22),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: avatar.topAnchor, constant: -8),
            
            avatar.leadingAnchor.constraint(equalTo: leadingAnchor),
            avatar.widthAnchor.constraint(equalToConstant: 32),
            avatar.heightAnchor.constraint(equalToConstant: 32),
            avatar.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            nameAuthor.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 8),
            nameAuthor.centerYAnchor.constraint(equalTo: avatar.centerYAnchor),
            nameAuthor.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
