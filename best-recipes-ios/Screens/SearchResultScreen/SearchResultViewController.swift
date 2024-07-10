//
//  SearchResultViewController.swift
//  best-recipes-ios
//
//  Created by Елена Логинова on 11.07.2024.
//

import UIKit

protocol SearchResultViewControllerDelegate: AnyObject {
    func didTapResult(_ result: Recipe)
}

final class SearchResultViewController: UIViewController {

    weak var resultDelegate: SearchResultViewControllerDelegate?
    let resultView = SearchResultView()
    var filteredRecipe: [Recipe] = []

    override func loadView() {
        view = resultView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        definesPresentationContext = false
        resultView.setDelegate(viewController: self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func update(with results: [Recipe]) {
        self.filteredRecipe = results
        resultView.searchResultTableView.isHidden = results.isEmpty
        resultView.searchResultTableView.reloadData()
        
    }
}

//MARK: - UITableViewDataSource

extension SearchResultViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let resultDelegate = resultDelegate else { return }
        let result = filteredRecipe[indexPath.row]
        resultDelegate.didTapResult(result)
        print("go to Recipe Detail Screen")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredRecipe.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.identifier, for: indexPath) as? SearchResultTableViewCell else { return UITableViewCell() }
        cell.configureCell(with: filteredRecipe[indexPath.item])
        return cell
    }
}

