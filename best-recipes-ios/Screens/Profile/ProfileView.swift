//
//  ProfileView.swift
//  best-recipes-ios
//
//  Created by Vladimir Dmitriev on 05.07.24.
//

import UIKit

final class ProfileView: UIView {
    
    let collectionView: UICollectionView
    
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
    
    private var myRecipeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.TextFonts.Home.titleSection
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "My recipes"
        return label
    }()
    
    override init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(frame: frame)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addProfileImageTapGesture(target: Any, action: Selector) {
        let gesture = UITapGestureRecognizer(target: target, action: action)
        profileImageView.addGestureRecognizer(gesture)
    }
    
    func setProfileImage(_ image: UIImage?) {
        profileImageView.image = image
    }
    
    private func setupSubviews() {
        addSubview(profileImageView)
        addSubview(myRecipeLabel)
        addSubview(collectionView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate(
            [
                profileImageView.topAnchor.constraint(
                    equalTo: safeAreaLayoutGuide.topAnchor,
                    constant: 16
                ),
                profileImageView.leadingAnchor.constraint(
                    equalTo: leadingAnchor,
                    constant: 16
                ),
                profileImageView.widthAnchor.constraint(equalToConstant: 100),
                profileImageView.heightAnchor.constraint(equalToConstant: 100),
                
                myRecipeLabel.topAnchor.constraint(
                    equalTo: profileImageView.bottomAnchor,
                    constant: 50
                ),
                myRecipeLabel.leadingAnchor.constraint(
                    equalTo: leadingAnchor,
                    constant: 32
                ),
                
                collectionView.topAnchor.constraint(
                    equalTo: myRecipeLabel.bottomAnchor,
                    constant: 16
                ),
                collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
                collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ]
        )
    }
}
