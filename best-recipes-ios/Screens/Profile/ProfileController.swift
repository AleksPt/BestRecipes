//
//  ProfileController.swift
//  best-recipes-ios
//
//  Created by Vladimir Dmitriev on 04.07.24.
//

import UIKit

final class ProfileController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let dataStore = DataStore.shared
    private let profileView = ProfileView()
    
    private var imagePicker = UIImagePickerController()
    
    // MARK: - Life Cycle
    override func loadView() {
        view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "My Profile"
        
        setupCollectionView()
        setupProfileImageView()
        setupImagePicker()
    }
    
    @objc func addProfileImage() {
        present(imagePicker, animated: true)
    }
    
    private func setupCollectionView() {
        profileView.collectionView.register(
            RecipeCell.self,
            forCellWithReuseIdentifier: "RecipeCell"
        )
        profileView.collectionView.delegate = self
        profileView.collectionView.dataSource = self
    }
    
    private func setupProfileImageView() {
        profileView.addProfileImageTapGesture(
            target: self,
            action: #selector(addProfileImage)
        )
    }
    
    private func setupImagePicker() {
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
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
extension ProfileController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        if let editedImage = info[.editedImage] as? UIImage {
            profileView.setProfileImage(editedImage)
        } else if let originalImage = info[.originalImage] as? UIImage {
            profileView.setProfileImage(originalImage)
        }
        dismiss(animated: true, completion: nil)
    }
}
