//
//  SeeAllViewController.swift
//  best-recipes-ios
//
//  Created by  Maksim Stogniy on 29.06.2024.
//

import UIKit

final class SeeAllViewController: UIViewController {
    
    private var data: [RecipesType] = [
        .tradingNow(<#T##String#>, <#T##String#>, <#T##UIImage#>),
        .recentRecipe(<#T##String#>, <#T##String#>, <#T##UIImage#>),
        .popularCreators(<#T##String#>, <#T##String#>, <#T##UIImage#>)
        
    
    ]
    
    //MARK: - Properties
    private var collectionView: UICollectionView!
    
    private let customView = SeeAllView()
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        cell.titleLabel.text = "How to make yam & vegetable sauce at home \(indexPath.item + 1)"
        cell.descriptionLabel.text = "9 ingredients | 25 min"
        cell.imageView.image = UIImage(resource: .recipes)
        
        return cell
    }
}


