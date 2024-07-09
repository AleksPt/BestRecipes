//
//  CreateRecipeController.swift
//  best-recipes-ios
//
//  Created by Vladimir Dmitriev on 06.07.24.
//

import UIKit

final class CreateRecipeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let dataStore = DataStore.shared
    private let createRecipeView = CreateRecipeView()
    
    private var imagePicker = UIImagePickerController()
    
    // MARK: - Life Cycle
    override func loadView() {
        view = createRecipeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Create recipe"
        
        setupCollectionView()
        setupImagePicker()
    }
    
    @objc func addRecipeImage() {
        present(imagePicker, animated: true)
    }
    
    // MARK: - Private Methods
    private func setupCollectionView() {
        createRecipeView.collectionView.register(
            RecipeImageCell.self,
            forCellWithReuseIdentifier: "RecipeImageCell"
        )
        createRecipeView.collectionView.register(
            RecipeTitleCell.self,
            forCellWithReuseIdentifier: "RecipeTitleCell"
        )
        createRecipeView.collectionView.register(
            ServesAndTimeCell.self,
            forCellWithReuseIdentifier: "ServesAndTimeCell"
        )
        createRecipeView.collectionView.register(
            CreateIngredientCell.self,
            forCellWithReuseIdentifier: "CreateIngredientCell"
        )
        createRecipeView.collectionView.register(
            CreateInstructionCell.self,
            forCellWithReuseIdentifier: "CreateInstructionCell"
        )
        
        createRecipeView.collectionView.register(
            CreateRecipeHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "CreateRecipeHeaderView"
        )
        
        createRecipeView.collectionView.delegate = self
        createRecipeView.collectionView.dataSource = self
    }
    
    private func setupImagePicker() {
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
    }
    
    // MARK: - UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 6
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        if section == 0 {
            return 1
        } else {
            return 1
        }
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "RecipeImageCell",
                for: indexPath
            ) as! RecipeImageCell
            cell.addRecipeImageTapGesture(target: self, action: #selector(addRecipeImage))
            return cell

        case 1:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "RecipeTitleCell",
                for: indexPath
            ) as! RecipeTitleCell
            return cell

        case 2:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "ServesAndTimeCell",
                for: indexPath
            ) as! ServesAndTimeCell
            cell.configure(.serves)
            return cell

        case 3:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "ServesAndTimeCell",
                for: indexPath
            ) as! ServesAndTimeCell
            cell.configure(.time)
            return cell

        case 4:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "CreateInstructionCell",
                for: indexPath
            ) as! CreateInstructionCell
            return cell

        default:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "CreateIngredientCell",
                for: indexPath
            ) as! CreateIngredientCell
            return cell
        }
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "CreateRecipeHeaderView",
                for: indexPath
            ) as! CreateRecipeHeaderView
            
            switch indexPath.section {
            case 4:
                headerView.configure(with: "Instructions")
            case 5:
                headerView.configure(with: "Ingredients")
            default:
                break
            }
            return headerView
        }
        return UICollectionReusableView()
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: collectionView.frame.width - 32, height: 200)
        case 1, 4, 5:
            return CGSize(width: collectionView.frame.width - 32, height: 44)
        default:
            return CGSize(width: collectionView.frame.width - 32, height: 60)
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        if section == 4 || section == 5 {
            return CGSize(width: collectionView.frame.width, height: 50)
        }
        return .zero
    }
}

// MARK: - Image Picker Delegate & Navigation Controller Delegate
extension CreateRecipeController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        if let editedImage = info[.editedImage] as? UIImage {
            if let cell = createRecipeView.collectionView.cellForItem(
                at: IndexPath(item: 0, section: 0)
            ) as? RecipeImageCell {
                cell.setRecipeImage(editedImage)
            }
        } else if let originalImage = info[.originalImage] as? UIImage {
            if let cell = createRecipeView.collectionView.cellForItem(
                at: IndexPath(item: 0, section: 0)
            ) as? RecipeImageCell {
                cell.setRecipeImage(originalImage)
            }
        }
        dismiss(animated: true, completion: nil)
    }
}
