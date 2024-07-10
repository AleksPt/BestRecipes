//
//  AllCuisinesCell.swift
//  best-recipes-ios
//
//  Created by Алексей on 10.07.2024.
//

import UIKit

final class AllCuisinesCell: UITableViewCell {
    var lol = 0
    // MARK: - UI
    private let backgroundCellView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.9372548461, blue: 0.9372549057, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let flagImageView = CoverImageFactory.makeCoverImageView(image: .american)
    
    private let title = LabelFactory.makeRecipeTitleLabel(text: "USA")
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Overrides methods
    override func prepareForReuse() {
        super.prepareForReuse()
        flagImageView.image = nil
        title.text = nil
    }
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set {
            var frame =  newValue
            frame.size.height -= 13
            super.frame = frame
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            UIView.animate(withDuration: 0.15) { [weak self] in
                guard let self else { return }
                backgroundCellView.backgroundColor = UIColor.Home.PopularCategory.cellUnselectedTitle
            } completion: { _ in
                UIView.animate(withDuration: 0.15) { [ weak self] in
                    guard let self else { return }
                    backgroundCellView.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.9372548461, blue: 0.9372549057, alpha: 1)
                }
            }
        } else {
            backgroundCellView.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.9372548461, blue: 0.9372549057, alpha: 1)
        }
    }
    
    // MARK: - Public methods
    func configureCell(cuisine: Cuisine) {
        flagImageView.image = UIImage(named: cuisine.rawValue.lowercased())
        title.text = cuisine.rawValue
        selectionStyle = .none
    }
    
    // MARK: - Private methods
    private func addSubviews() {
        addSubview(backgroundCellView)
        backgroundCellView.addSubview(flagImageView)
        backgroundCellView.addSubview(title)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundCellView.topAnchor.constraint(equalTo: topAnchor),
            backgroundCellView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundCellView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundCellView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            flagImageView.leadingAnchor.constraint(equalTo: backgroundCellView.leadingAnchor, constant: 10),
            flagImageView.centerYAnchor.constraint(equalTo: backgroundCellView.centerYAnchor),
            flagImageView.widthAnchor.constraint(equalToConstant: 60),
            flagImageView.heightAnchor.constraint(equalToConstant: 45),
            
            title.centerYAnchor.constraint(equalTo: flagImageView.centerYAnchor),
            title.leadingAnchor.constraint(equalTo: flagImageView.trailingAnchor, constant: 10),
        ])
    }
}
