//
//  MainScreen.swift
//  best-recipes-ios
//
//  Created by Алексей on 01.07.2024.
//

import UIKit

protocol HomeScreenDelegate: AnyObject {
    func addRecentRecipe(recipe: Recipe)
}

final class HomeScreen: UIViewController, HomeScreenDelegate {
    
    private let mainView = HomeView()
    private let networkManager = NetworkManager.shared
    private var dataStore = DataStore.shared
    private var dataSource: [Section] = []
    private var selectedCategory: IndexPath = IndexPath(item: 0, section: 1)
    
    // MARK: - Life Cycle
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.setDelegates(viewController: self)
        fetchRecipes(typeUrl: .recipesURL(offset: dataStore.offsetRecipes, query: ""))
        fetchRecipes(typeUrl: .popularRecipesURL(offset: dataStore.offsetPopularResipes))
        setupHomeScreenNavBar(on: self, with: "Get amazing recipes",
                              searchController: mainView.searchController)
        addTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectCategory()
    }
    
    // MARK: - Private methods
    /// Сетевой запрос рецептов
    private func fetchRecipes(typeUrl: APIEndpoint) {
        mainView.activityIndicator.startAnimation(delay: 0.0075, replicates: 120)
        let url = typeUrl.url
        networkManager.fetch(ComplexSearch.self, from: url) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let recipes):

                switch typeUrl {
                case .recipesURL(_, _):
                    dataStore.trendingRecipes = recipes.results
                case .popularRecipesURL(_):
                    dataStore.popularRecipes = recipes.results
                case .cuisineSortedRecipesURL(_, _):
                    dataStore.worlCuisineRecipes = recipes.results
                case .ingredientImageURL(_):
                    break
                }
                
                dataSource = dataStore.getData()
                
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    mainView.collectionView.reloadData()
                    selectCategory()
                    mainView.activityIndicator.stopAnimation()
                }
            case .failure(let error):
                print(error.localizedDescription)
                mainView.activityIndicator.stopAnimation()
            }
        }
    }
    
    /// Поиск рецепта
    private func searchRecipe(query: String) {
        let url = APIEndpoint.recipesURL(offset: 0, query: query).url
        networkManager.fetch(ComplexSearch.self, from: url) { [weak self]  result in
            guard let self else { return }
            switch result {
            case .success(let recipes):
                if let resultController = self.mainView.searchController.searchResultsController as? SearchResultViewController {
                    DispatchQueue.main.async {
                        resultController.update(with: recipes.results)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    /// Выделяет популярную категорию перед показом экрана
    private func selectCategory() {
        if !dataSource.isEmpty {
//            let indexPath = IndexPath(item: 0, section: 1)
            mainView.collectionView.selectItem(
                at: selectedCategory,
                animated: true,
                scrollPosition: []
            )
            filterRecipes(IndexPath(item: 0, section: 1))
        }
    }
    
    /// Фильтр рецептов по категории
    private func filterRecipes(_ indexPath: IndexPath) {
        let currentCategory = dataSource[indexPath.section].categories[indexPath.item]
        
        let recipes = dataStore.getData()[indexPath.section + 1].recipes
        
        let filteredRecipes = recipes.filter {
            $0.dishTypes.contains(currentCategory.lowercased())
        }
        
        dataSource[indexPath.section + 1].recipes = filteredRecipes
        
        let indexSection = IndexSet(integer: indexPath.section + 1)
        mainView.collectionView.reloadSections(indexSection)
    }
}

// MARK: - UICollectionViewDelegate
extension HomeScreen: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let indexSection = indexPath.section
        
        switch indexSection {
        case 0, 2, 3:
            let recipe = dataSource[indexSection].recipes[indexPath.item]
            let detailVC = RecipeDetailViewController(recipe: recipe)
            addRecentRecipe(recipe: recipe)
            detailVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(detailVC, animated: true)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                guard let self else { return }
                mainView.collectionView.reloadData()
            }
        case 1:
            selectedCategory = indexPath
            filterRecipes(indexPath)
        case 4:
            let seeAllVC = SeeAllViewController(type: .worldCuisine)
            seeAllVC.nameCuisine = dataSource[4].cuisines[indexPath.item].rawValue
            seeAllVC.delegate = self
            seeAllVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(seeAllVC, animated: true)
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        false
    }
}

// MARK: - UICollectionViewDataSource
extension HomeScreen: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0, 2, 3:
            dataSource[section].recipes.count
        case 1:
            dataSource[section].categories.count
        case 4:
            dataSource[section].cuisines.prefix(10).count
        default:
            0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let recipe = dataSource[indexPath.section].recipes[indexPath.item]
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TrendingCell.description(),
                for: indexPath
            ) as? TrendingCell else {
                return UICollectionViewCell()
            }
            
            cell.configureCell(item: recipe)
            return cell
            
        case 1:
            let category = dataSource[indexPath.section].categories[indexPath.item]
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CategoryCell.description(),
                for: indexPath
            ) as? CategoryCell else {
                return UICollectionViewCell()
            }
            cell.configureCell(item: category)
            return cell
            
        case 2:
            let recipe = dataSource[indexPath.section].recipes[indexPath.item]
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CategoryRecipeCell.description(),
                for: indexPath
            ) as? CategoryRecipeCell else {
                return UICollectionViewCell()
            }
            
            cell.configureCell(item: recipe)
            return cell
            
        case 3:
            let recipe = dataSource[indexPath.section].recipes[indexPath.item]
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RecentCell.description(),
                for: indexPath
            ) as? RecentCell else {
                return UICollectionViewCell()
            }
            
            cell.configureCell(item: recipe)
            return cell
            
        case 4:
            let cuisines10 = Array(dataSource[indexPath.section].cuisines.prefix(10))[indexPath.item]

            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: WorldCuisineCell.description(),
                for: indexPath
            ) as? WorldCuisineCell else {
                return UICollectionViewCell()
            }
            
            cell.configureCell(item: cuisines10)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HeaderSupplementaryView.description(),
                for: indexPath
            ) as? HeaderSupplementaryView else {
                return UICollectionReusableView()
            }
            
            header.configureHeader(section: indexPath.section, dataSource: dataSource)
            
            header.completionHandler = { [weak self] in
                guard let self else { return }
                
                switch indexPath.section {
                case 0:
                    let vc = SeeAllViewController(type: .trendingNow)
                    vc.delegate = self
                    vc.recipes = dataStore.trendingRecipes
                    vc.hidesBottomBarWhenPushed = true
                    navigationController?.pushViewController(vc, animated: true)
                case 3:
                    let vc = SeeAllViewController(type: .recentRecipe)
                    vc.delegate = self
                    vc.recipes = dataStore.recentRecipes
                    vc.hidesBottomBarWhenPushed = true
                    navigationController?.pushViewController(vc, animated: true)
                case 4:
                    let vc = AllCuisinesVC()
                    vc.hidesBottomBarWhenPushed = true
                    navigationController?.pushViewController(vc, animated: true)
                default:
                    break
                }
            }
            
            return header
        default:
            return UICollectionReusableView()
        }
    }
}

// MARK: - HomeScreenDelegate
extension HomeScreen {
    /// Проверяет просмотренный рецепт, если ранее не был просмотрен - добавляет в секцию
    func addRecentRecipe(recipe: Recipe) {
        if let recentRecipes = dataStore.recentRecipes {
            if !recentRecipes.isEmpty {
                let result = recentRecipes.contains { recentRecipe in
                    recentRecipe.id == recipe.id
                }
                if !result {
                    dataStore.recentRecipes?.insert(recipe, at: 0)
                }
            } else {
                dataStore.recentRecipes?.insert(recipe, at: 0)
            }
        }
        dataSource = dataStore.getData()
        mainView.collectionView.reloadData()
    }
}

//MARK: - SearchResultViewControllerDelegate
extension HomeScreen: SearchResultViewControllerDelegate {

    func didTapResult(_ result: Recipe) {
        let detail = RecipeDetailViewController(recipe: result)
        addRecentRecipe(recipe: result)
        navigationController?.pushViewController(detail, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self else { return }
            self.mainView.collectionView.reloadData()
        }
    }
}

//MARK: - UITapDestureRecognizer

extension HomeScreen {
    func addTapGesture() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        tapRecognizer.cancelsTouchesInView = false
        mainView.addGestureRecognizer(tapRecognizer)
    }
    
    @objc private func handleTapGesture(sender: UITapGestureRecognizer) {
        self.mainView.searchController.searchBar.resignFirstResponder()
    }
}

//MARK: - UISearchResultsUpdating
extension HomeScreen: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            
            if let tabBarController = self.tabBarController as? TabBarController {
                tabBarController.tabBar.isHidden = false
                tabBarController.toggleMiddleButtonVisability(false)
            }
            return
        }
        
        
        if let tabBarController = self.tabBarController as? TabBarController {
            tabBarController.tabBar.isHidden = true
            tabBarController.toggleMiddleButtonVisability(true)
        }
        
        //searchRecipe(query: query)
        filterContentForSearchText(query)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        
        let filterFirstSection = dataSource[0].recipes.filter { (recipe: Recipe) -> Bool in
            return recipe.title.lowercased().contains(searchText.lowercased())
        }
        let filterThirdSection = dataSource[2].recipes.filter { (recipe: Recipe) -> Bool in
            return recipe.title.lowercased().contains(searchText.lowercased())
        }
        let filterFifthSection = dataSource[4].recipes.filter { (recipe: Recipe) -> Bool in
            return recipe.title.lowercased().contains(searchText.lowercased())
        }
        let filterAllSections = filterFirstSection + filterThirdSection + filterFifthSection

        if let resultController = mainView.searchController.searchResultsController as? SearchResultViewController {
            resultController.filteredRecipe = filterAllSections
            resultController.resultView.searchResultCollectionView.reloadData()
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.searchTextField.layer.borderColor = UIColor.Search.borderSelectedField.cgColor
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.searchTextField.layer.borderColor = UIColor.Search.borderField.cgColor
    }
}
