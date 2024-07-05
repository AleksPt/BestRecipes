//
//  SeeAllViewController.swift
//  best-recipes-ios
//
//  Created by  Maksim Stogniy on 29.06.2024.
//

import UIKit

final class SeeAllViewController: UIViewController {
    
    private var type: RecipesType
    
    private var data = CollectionData.allRecipes()
    
    init(type: RecipesType) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
        
    //MARK: - Properties
    private var collectionView: UICollectionView!
    
    private let customView = SeeAllView()
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.setTitle(type)
        customView.setDelegates(value: self)
    }
    
    override func loadView() {
        
        view = customView
    }
}


//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension SeeAllViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
        
        let item = data[indexPath.item]
        cell.configure(with: item)
        
        return cell
    }
}


