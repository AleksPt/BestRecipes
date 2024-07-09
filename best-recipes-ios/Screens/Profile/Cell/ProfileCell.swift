//
//  ProfileCell.swift
//  best-recipes-ios
//
//  Created by Vladimir Dmitriev on 08.07.24.
//

import UIKit

final class ProfileCell: UICollectionViewCell {
    
    private var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        
        if let image = UIImage(
            systemName: "person.circle"
        )?.withTintColor(.gray, renderingMode: .alwaysOriginal) {
            imageView.image = image
        }
        
        return imageView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(profileImageView)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    func addProfileImageTapGesture(target: Any, action: Selector) {
        let gesture = UITapGestureRecognizer(target: target, action: action)
        profileImageView.addGestureRecognizer(gesture)
    }
    
    func setProfileImage(_ image: UIImage?) {
        profileImageView.image = image
    }
    
    // MARK: - Private Methods
    private func setupLayout() {
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: topAnchor),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}
