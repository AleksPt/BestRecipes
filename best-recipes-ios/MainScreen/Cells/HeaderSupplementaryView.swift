//
//  HeaderSupplementaryView.swift
//  best-recipes-ios
//
//  Created by Алексей on 01.07.2024.
//

import UIKit

final class HeaderSupplementaryView: UICollectionReusableView {
    
    // MARK: - UI
    private lazy var title: UILabel = {
        let element = UILabel()
        element.font = UIFont.TextFonts.Home.titleSection
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    lazy var seeAllButton: UIButton = {
        let element = UIButton(type: .system)
        element.setTitle("See All", for: .normal)
        element.tintColor = UIColor.NavigationBar.title
        element.setTitleColor(UIColor.Home.buttonSeeAll, for: .normal)
        element.translatesAutoresizingMaskIntoConstraints = false
        element.addTarget(self, action: #selector(didTapSeeAll), for: .touchUpInside)
        
        let arrowImage = Icons.arrowRight
        element.semanticContentAttribute = .forceRightToLeft
        element.setImage(arrowImage, for: .normal)
        
        var configuration = UIButton.Configuration.plain()
        element.configuration = configuration
        element.configurationUpdateHandler = { button in
            button.configuration?.attributedTitle?.font = UIFont.TextFonts.Home.buttonSeeAll
            button.configuration?.imagePadding = 6
            button.configuration?.contentInsets = NSDirectionalEdgeInsets(
                top: 0,
                leading: 0,
                bottom: 0,
                trailing: -6
            )
        }
        
        return element
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(title)
        addSubview(seeAllButton)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Overrides methods
    override func prepareForReuse() {
        title.text = nil
    }
    
    // MARK: - Configure Header
    func configureHeader(section: Int) {
        switch section {
        case 0:
            title.text = "Trending now 🔥"
        case 1:
            title.text = "Popular category"
            seeAllButton.isHidden = true
        case 2:
            title.text = ""
        case 3:
            title.text = "Recent recipe"
        case 4:
            title.text = "World cuisine"
        default:
            break
        }
    }
    
    // MARK: - Actions
    @objc
    private func didTapSeeAll() {
        print("go to See All Screen")
    }
}

// MARK: - Setup Constraints
private extension HeaderSupplementaryView {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            title.centerYAnchor.constraint(equalTo: centerYAnchor),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            seeAllButton.centerYAnchor.constraint(equalTo: title.centerYAnchor),
            seeAllButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
}
