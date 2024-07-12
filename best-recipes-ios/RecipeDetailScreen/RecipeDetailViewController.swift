//
//  RecipeDetailViewController.swift
//  best-recipes-ios
//
//  Created by Елена Логинова on 04.07.2024.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    private let storageManager = StorageManager.shared
    private let recipeDetailView = RecipeDetailView()
    
    private var recipe: Recipe
    private var recipeIngredient: [Ingredient]
    private var recipeSteps: [Step]
    
    init(recipe: Recipe) {
        self.recipe = recipe
        recipeIngredient = recipe.extendedIngredients ?? []
        recipeSteps = recipe.analyzedInstructions.first?.steps ?? []
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = recipeDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipeDetailView.setDelegate(viewController: self)
        setupNavBarWithButtons(on: self, text: "")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let tabBarController = self.tabBarController as? TabBarController {
            tabBarController.toggleMiddleButtonVisability(true)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let tabBarController = self.tabBarController as? TabBarController {
            tabBarController.toggleMiddleButtonVisability(false)
        }
    }
}

//MARK: - UITableViewDataSource

// Setup Header
extension RecipeDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return CGFloat.leastNonzeroMagnitude
        case 1,2:
            return 44
        default:
            return 44
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderTableView.identifier) as? HeaderTableView else { return UITableViewHeaderFooterView() }
        
        switch section {
        case 1:
            header.configureHeader(categoryName: "Instructions", countIngredient: "")
            return header
        case 2:
            let count = recipeIngredient.count
            header.configureHeader(categoryName: "Ingredients", countIngredient: "\(count)" + " " + "items")
            return header
        default:
            return UITableViewHeaderFooterView()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? IngredientsTableViewCell {
            
            if cell.checkCircleImageView.image == Icons.checkmark {
                cell.checkCircleImageView.image = Icons.uncheckmark
            } else {
                cell.checkCircleImageView.image = Icons.checkmark
            }
        }
    }
    
    // Setup Section
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0: return 1
        case 1:
            let countSteps = recipeSteps.count
            return countSteps
        case 2:
            let countIngredients = recipeIngredient.count
            return countIngredients
        default:
            return 1
        }
    }
    
    // Setup TableView cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0: guard let cell = tableView.dequeueReusableCell(withIdentifier: ImageTableViewCell.identifier, for: indexPath) as? ImageTableViewCell else { return UITableViewCell()}
            let imageData = storageManager.getImage(imgName: recipe.image)
            cell.configureCell(with: recipe, imageData: imageData)
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: InstructionsTableViewCell.identifier, for: indexPath) as? InstructionsTableViewCell else { return UITableViewCell() }
            let instruction = recipeSteps[indexPath.row]
            cell.configureCell(with: instruction)
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: IngredientsTableViewCell.identifier, for: indexPath) as? IngredientsTableViewCell else { return UITableViewCell() }
            let ingredient = recipeIngredient[indexPath.row]
            if recipe.id == 0 {
                cell.configureCell(with: ingredient, isUserCreated: true)
            } else {
                cell.configureCell(with: ingredient)
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
}
