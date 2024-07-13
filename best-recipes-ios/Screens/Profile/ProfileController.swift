//
//  ProfileController.swift
//  best-recipes-ios
//
//  Created by Vladimir Dmitriev on 04.07.24.
//

import UIKit

final class ProfileController: UIViewController {
    
    private var dataStore = DataStore.shared
    private let storageManager = StorageManager.shared
    private let profileView = ProfileView()
    
    private var imagePicker = UIImagePickerController()
    
    // MARK: - Life Cycle
    override func loadView() {
        view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupCollectionView()
        setupImagePicker()
        setupNavBarWithoutButtons(on: self, with: "My Profile")
		addNotifications()    
	}
        
    
    // MARK: - Private Methods
    private func setupCollectionView() {
        profileView.collectionView.register(
            ProfileCell.self,
            forCellWithReuseIdentifier: "ProfileCell"
        )
        profileView.collectionView.register(
            RecipeCell.self,
            forCellWithReuseIdentifier: "RecipeCell"
        )
        profileView.collectionView.register(
            ProfileSectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "ProfileSectionHeaderView"
        )
        
        profileView.collectionView.delegate = self
        profileView.collectionView.dataSource = self
    }
    
    private func setupImagePicker() {
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
    }
    
    // MARK: - Actions
    @objc private func reloadCollection() {
        profileView.collectionView.reloadData()
    }
    
    @objc func addProfileImage() {
        present(imagePicker, animated: true)
    }
    
}

// MARK: - UICollectionViewDataSource
extension ProfileController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        if section == 0 {
            return 1
        } else {
            return dataStore.userRecipes.count
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "ProfileCell",
                for: indexPath
            ) as! ProfileCell
            cell.addProfileImageTapGesture(target: self, action: #selector(addProfileImage))
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "RecipeCell",
                for: indexPath
            ) as! RecipeCell
            
            let recipe = dataStore.userRecipes[indexPath.item]
            let imageData = storageManager.getImage(imgName: recipe.image)
            cell.configure(with: recipe, imageData: imageData)
            return cell
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "ProfileSectionHeaderView",
                for: indexPath
            ) as! ProfileSectionHeaderView
            if indexPath.section == 1 {
                headerView.configure(with: "My Recipes")
            }
            return headerView
        }
        return UICollectionReusableView()
    }
}

// MARK: - UICollectionViewDelegate
extension ProfileController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = RecipeDetailViewController(recipe: dataStore.userRecipes[indexPath.item])
        detailVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: collectionView.frame.width - 32, height: 150)
        }
        return CGSize(width: collectionView.frame.width - 32, height: 200)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 25
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        if section == 1 {
            return CGSize(width: collectionView.frame.width, height: 50)
        }
        return .zero
    }
}

// MARK: - Image Picker Delegate & Navigation Controller Delegate
extension ProfileController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        if let editedImage = info[.editedImage] as? UIImage {
            if let cell = profileView.collectionView.cellForItem(
                at: IndexPath(item: 0, section: 0)
            ) as? ProfileCell {
                cell.setProfileImage(editedImage)
            }
        } else if let originalImage = info[.originalImage] as? UIImage {
            if let cell = profileView.collectionView.cellForItem(
                at: IndexPath(item: 0, section: 0)
            ) as? ProfileCell {
                cell.setProfileImage(originalImage)
            }
        }
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Notifications
extension ProfileController {
    func addNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(reloadCollection),
            name: NSNotification.Name("reloadCollection"),
            object: nil
        )
    }
}
