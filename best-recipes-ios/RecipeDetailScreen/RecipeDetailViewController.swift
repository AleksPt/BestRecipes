//
//  RecipeDetailViewController.swift
//  best-recipes-ios
//
//  Created by Елена Логинова on 04.07.2024.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    weak var delegate: HomeScreenDelegate?
    private let recipeDetailView = RecipeDetailView()
    
    //Data Store
    var firstRecipe: Recipe?
    private var firstRecipeIngredient: [Ingredient]? { firstRecipe?.extendedIngredients ?? [] }
    private var firstRecipeSteps: [Step]? { firstRecipe?.analyzedInstructions.first?.steps ?? [] }
    
    override func loadView() {
        view = recipeDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipeDetailView.setDelegate(viewController: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        delegate?.reloadRecentRecipeSection()
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
            let count = (firstRecipeIngredient?.count) ?? 1
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
            let countSteps = firstRecipeSteps?.count ?? 1
            return countSteps
        case 2:
            let countIngredients = firstRecipeIngredient?.count ?? 1
            return countIngredients
        default:
            return 1
        }
    }
    
    // Setup TableView cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0: guard let cell = tableView.dequeueReusableCell(withIdentifier: ImageTableViewCell.identifier, for: indexPath) as? ImageTableViewCell else { return UITableViewCell()}
            let recipe = firstRecipe
            cell.configureCell(with: recipe)
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: InstructionsTableViewCell.identifier, for: indexPath) as? InstructionsTableViewCell else { return UITableViewCell() }
            let instruction = firstRecipeSteps![indexPath.row]
            cell.configureCell(with: instruction)
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: IngredientsTableViewCell.identifier, for: indexPath) as? IngredientsTableViewCell else { return UITableViewCell() }
            let ingredient = firstRecipeIngredient![indexPath.row]
            cell.configureCell(with: ingredient)
            return cell
        default:
            return UITableViewCell()
        }
    }
}
