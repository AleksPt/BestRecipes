//
//  ServesAndTimeCell.swift
//  best-recipes-ios
//
//  Created by Vladimir Dmitriev on 06.07.24.
//

import UIKit

final class ServesAndTimeCell: UICollectionViewCell {
    
    enum TypeCell {
        case serves
        case time
    }
    
    private var iconView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var iconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "Profile")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Serves"
        label.font = UIFont.TextFonts.CreateRecipe.parametersTitle
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var subtitleServesLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = UIColor.CreateRecipe.subtitle
        label.font = UIFont.TextFonts.CreateRecipe.parametersSubtitle
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var subtitleCookTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "0 min"
        label.textColor = UIColor.CreateRecipe.subtitle
        label.font = UIFont.TextFonts.CreateRecipe.parametersSubtitle
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Arrow-Right"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
        
    var valueServes = 0 {
        didSet {
            subtitleServesLabel.text = "\(valueCookTime)"
        }
    }
    var valueCookTime = 0 {
        didSet {
            subtitleCookTimeLabel.text = "\(valueCookTime) min"
        }
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.neutral10
        layer.cornerRadius = 12
        
        addSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Public Methods
    func configure(_ type: TypeCell) {
        switch type {
        case .serves:
            titleLabel.text = "Serves"
            iconImage.image = UIImage(named: "Profile")
            subtitleCookTimeLabel.isHidden = true
        case .time:
            titleLabel.text = "Cook time"
            iconImage.image = UIImage(named: "Clock")
            subtitleServesLabel.isHidden = true
        }
    }
    
    // MARK: - Private Methods
    private func addSubviews() {
        addSubview(iconView)
        addSubview(iconImage)
        addSubview(titleLabel)
        addSubview(button)
        addSubview(subtitleServesLabel)
        addSubview(subtitleCookTimeLabel)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            iconView.widthAnchor.constraint(equalTo: iconView.heightAnchor, multiplier: 1),
            iconView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            iconView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            iconView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            
            iconImage.centerXAnchor.constraint(equalTo: iconView.centerXAnchor),
            iconImage.centerYAnchor.constraint(equalTo: iconView.centerYAnchor),
            iconImage.widthAnchor.constraint(equalTo: iconView.widthAnchor, multiplier: 0.55),
            iconImage.heightAnchor.constraint(equalTo: iconView.heightAnchor, multiplier: 0.55),
            
            titleLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: iconView.centerYAnchor),
            
            button.widthAnchor.constraint(equalToConstant: 20),
            button.heightAnchor.constraint(equalToConstant: 20),
            button.centerYAnchor.constraint(equalTo: centerYAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            subtitleServesLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            subtitleServesLabel.trailingAnchor.constraint(equalTo: button.leadingAnchor, constant: -12),
            
            subtitleCookTimeLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            subtitleCookTimeLabel.trailingAnchor.constraint(equalTo: button.leadingAnchor, constant: -12)
        ])
    }
}

