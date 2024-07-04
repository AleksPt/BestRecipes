//
//  ProfileViewController.swift
//  best-recipes-ios
//
//  Created by Vladimir Dmitriev on 04.07.24.
//

import UIKit

class ProfileViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let dataStore = DataStore.shared
    
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
    
    private var imagePicker = UIImagePickerController()
    
    private var myRecipeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.TextFonts.Home.titleSection
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "My recipes"
        return label
    }()
    
    init() {
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "My Profile"
        
        addSubviews()
        setupCollectionView()
        setupLayout()
        setupProfileImageView()
        setupImagePicker()
    }
    
    @objc func addProfileImage() {
        present(imagePicker, animated: true)
    }
    
    private func addSubviews() {
        view.addSubview(profileImageView)
        view.addSubview(myRecipeLabel)
    }
    
    private func setupCollectionView() {
        collectionView.register(RecipeCell.self, forCellWithReuseIdentifier: "RecipeCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupProfileImageView() {
        let gesture = UITapGestureRecognizer(
            target: self,
            action: #selector(addProfileImage)
        )
        profileImageView.addGestureRecognizer(gesture)
    }
    
    private func setupImagePicker() {
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate(
            [
                profileImageView.topAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.topAnchor,
                    constant: 16
                ),
                profileImageView.leadingAnchor.constraint(
                    equalTo: view.leadingAnchor,
                    constant: 16
                ),
                profileImageView.widthAnchor.constraint(equalToConstant: 100),
                profileImageView.heightAnchor.constraint(equalToConstant: 100),
                
                myRecipeLabel.topAnchor.constraint(
                    equalTo: profileImageView.bottomAnchor,
                    constant: 50
                ),
                myRecipeLabel.leadingAnchor.constraint(
                    equalTo: view.leadingAnchor,
                    constant: 32
                ),
                
                collectionView.topAnchor.constraint(
                    equalTo: myRecipeLabel.bottomAnchor,
                    constant: 16
                ),
                collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ]
        )
    }
    
    // MARK: - UICollectionViewDataSource
    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return dataStore.recipes.count
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "RecipeCell",
            for: indexPath
        ) as! RecipeCell
        
        let recipe = dataStore.recipes[indexPath.item]
        cell.configure(with: recipe)
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: collectionView.frame.width - 32, height: 200)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 25
    }
}

// MARK: - Image Picker Delegate & Navigation Controller Delegate
extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        if let editedImage = info[.editedImage] as? UIImage {
            profileImageView.image = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            profileImageView.image = originalImage
        }
        dismiss(animated: true, completion: nil)
    }
}
