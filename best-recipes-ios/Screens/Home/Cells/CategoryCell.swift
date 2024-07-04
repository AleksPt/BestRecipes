//
//  CategoryCell.swift
//  best-recipes-ios
//
//  Created by Алексей on 01.07.2024.
//

import UIKit

final class CategoryCell: UICollectionViewCell {
    
    // MARK: - UI
    private let title = LabelFactory.makeCategoryRecipeLabel(text: "Category")
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 10
        addSubview(title)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Overrides methods
    override func prepareForReuse() {
        super.prepareForReuse()
        title.text = nil
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                backgroundColor = UIColor.Home.PopularCategory.cellSelectedBackground
                title.textColor = UIColor.Home.PopularCategory.cellSelectedTitle
            } else {
                backgroundColor = UIColor.Home.PopularCategory.cellUnselectedBackground
                title.textColor = UIColor.Home.PopularCategory.cellUnselectedTitle
            }
        }
    }
    
    // MARK: - Configure Cell
    func configureCell(item: Item) {
        title.text = item.category.rawValue.capitalized
    }
}


// MARK: - Setup Constraints
private extension CategoryCell {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            title.centerYAnchor.constraint(equalTo: centerYAnchor),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
        ])
    }
}
