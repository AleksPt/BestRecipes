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
    
    func update(with results: [Recipe]) {
        self.filteredRecipe = results
        resultView.searchResultCollectionView.reloadData()
    }
}

//MARK: - UICollectionViewDataSource

extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let resultDelegate = resultDelegate else { return }
        let result = filteredRecipe[indexPath.row]
        resultDelegate.didTapResult(result)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredRecipe.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.identifier, for: indexPath) as? SearchResultCollectionViewCell else { return UICollectionViewCell() }
        cell.configureCell(with: filteredRecipe[indexPath.item])
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension SearchResultViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 32, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        return .zero
    }
}



