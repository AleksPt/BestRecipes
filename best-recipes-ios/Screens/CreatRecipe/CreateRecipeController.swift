//
//  CreateRecipeController.swift
//  best-recipes-ios
//
//  Created by Vladimir Dmitriev on 06.07.24.
//

import UIKit

protocol CreateRecipeDelegate: AnyObject {
    func updateCookTime(time: Int)
    func updateServes(count: Int)
}

final class CreateRecipeController: UIViewController {
    private let dataStore = DataStore.shared
    private let storageManager = StorageManager.shared
    private let createRecipeView = CreateRecipeView()
    private var imagePicker = UIImagePickerController()
    
    // MARK: - Life Cycle
    override func loadView() {
        view = createRecipeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        createRecipeView.createRecipeButton.addTarget(
            self,
            action: #selector(createRecipe),
            for: .touchUpInside
        )
        addTapGestureToHideKeyboard()
        createRecipeView.setDelegates(self)
        setupImagePicker()
        addNotifications()
        setupNavBarWithButtons(on: self, text: "Create recipe")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let tabBarController = self.tabBarController as? TabBarController {
            tabBarController.tabBar.isHidden = true
            tabBarController.toggleMiddleButtonVisability(true)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let tabBarController = self.tabBarController as? TabBarController {
            tabBarController.tabBar.isHidden = false
            tabBarController.toggleMiddleButtonVisability(false)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        storageManager.instructions = []
        storageManager.ingredientsTuple = []
    }
    
    // MARK: - Private Methods
    private func setupImagePicker() {
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
    }
    
    // MARK: - Actions
    @objc private func createRecipe() {
        guard !storageManager.title.isEmpty else {
            showErrorAlert(message: "Enter recipe name")
            return
        }
        storageManager.creatRecipe()
        storageManager.clearAfterCreateRecipe()
        NotificationCenter.default.post(
            name: Notification.Name("reloadCollection"),
            object: nil,
            userInfo: nil
        )
        navigationController?.popViewController(animated: true)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        let keyboardHeight = keyboardFrame.height
        var contentInset = createRecipeView.collectionView.contentInset
        contentInset.bottom = keyboardHeight
        createRecipeView.collectionView.contentInset = contentInset
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        createRecipeView.collectionView.contentInset = .zero
    }
    
    @objc func showPickerCookTime() {
        let picker = PickerViewController()
        picker.delegate = self
        present(picker, animated: true)
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
                
                if let imageData = editedImage.pngData() {
                    storageManager.image = UUID().uuidString
                    storageManager.saveImage(data: imageData, name: storageManager.image)
                }
            }
        } else if let originalImage = info[.originalImage] as? UIImage {
            if let cell = createRecipeView.collectionView.cellForItem(
                at: IndexPath(item: 0, section: 0)
            ) as? RecipeImageCell {
                cell.setRecipeImage(originalImage)
                
                if let imageData = originalImage.pngData() {
                    storageManager.image = UUID().uuidString
                    storageManager.saveImage(data: imageData, name: storageManager.image)
                }
            }
        }
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDataSource
extension CreateRecipeController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 6
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        switch section {
        case 0, 1, 2, 3:
            return 1
        case 4:
            return storageManager.instructions.count + 1
        case 5:
            return storageManager.ingredientsTuple.count + 1
        default:
            return 1
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "RecipeImageCell",
                for: indexPath
            ) as! RecipeImageCell
            cell.completionHandler = { [weak self] in
                guard let self else { return }
                present(imagePicker, animated: true)
            }
            return cell

        case 1:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "RecipeTitleCell",
                for: indexPath
            ) as! RecipeTitleCell
            cell.completionHandler = { [weak self] titleRecipe in
                guard let self else { return }
                storageManager.title = titleRecipe
            }
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
            cell.configureCell(index: indexPath.item + 1)
            
            cell.completionHandlerAdd = { [weak self] text in
                guard let self else { return }
                storageManager.instructions.append(text)
                collectionView.insertItems(
                    at: [IndexPath(row: storageManager.instructions.count, section: 4)]
                )
                collectionView.scrollToItem(
                    at: IndexPath(row: indexPath.item + 1, section: 4),
                    at: .bottom,
                    animated: true
                )
            }
            
            cell.completionHandlerDelete = { [weak self] in
                guard let self else { return }
                storageManager.instructions.remove(at: indexPath.item)
                collectionView.deleteItems(
                    at: [IndexPath(row: indexPath.item, section: 4)]
                )
            }
            return cell

        default:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "CreateIngredientCell",
                for: indexPath
            ) as! CreateIngredientCell
            
            cell.completionHandlerAdd = { [weak self] ingredient in
                guard let self else { return }
                storageManager.ingredientsTuple.append(ingredient)
                collectionView.insertItems(
                    at: [IndexPath(row: storageManager.ingredientsTuple.count, section: 5)]
                )
                collectionView.scrollToItem(
                    at: IndexPath(row: indexPath.item + 1, section: 5),
                    at: .bottom,
                    animated: true
                )
            }
            
            cell.completionHandlerDelete = { [weak self] in
                guard let self else { return }
                storageManager.ingredientsTuple.remove(at: indexPath.item)
                collectionView.deleteItems(
                    at: [IndexPath(row: indexPath.item, section: 5)]
                )
            }
            
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
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CreateRecipeController: UICollectionViewDelegateFlowLayout {
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 2:
            showServesAlert()
        case 3:
            showPickerCookTime()
        default:
            break
        }
    }
}

// MARK: - Alert Controller
extension CreateRecipeController {
    func showErrorAlert(message: String) {
        let alert = UIAlertController(
            title: "Ooops!",
            message: message,
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(
            title: "Ok",
            style: .default
        )
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    func showServesAlert() {
        let alert = UIAlertController(
            title: "Enter count serves:",
            message: nil,
            preferredStyle: .alert
        )
        
        alert.addTextField { textField in
            textField.keyboardType = .numberPad
            
        }
        
        let okAction = UIAlertAction(
            title: "Ok",
            style: .default) { [weak self] _ in
                guard let self else { return }
                guard let text = alert.textFields?.first?.text,
                        !text.isEmpty else {
                    return
                }
                
                if let serves = Int(text) {
                    updateServes(count: serves)
                }
            }
        
        let cancelAction = UIAlertAction(
            title: "Cancel",
            style: .cancel
        )
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }

}

// MARK: - Notifications
extension CreateRecipeController {
    func addNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
}

// MARK: - CreateRecipeDelegate
extension CreateRecipeController: CreateRecipeDelegate {
    func updateCookTime(time: Int) {
        storageManager.readyInMinutes = time
        let index = IndexPath(row: 0, section: 3)
        if let cell = createRecipeView.collectionView.cellForItem(at: index) as? ServesAndTimeCell {
            cell.valueCookTime = time
        }
    }
    
    func updateServes(count: Int) {
        storageManager.servings = count
        let index = IndexPath(row: 0, section: 2)
        if let cell = createRecipeView.collectionView.cellForItem(at: index) as? ServesAndTimeCell {
            cell.valueServes = count
        }
    }
}
