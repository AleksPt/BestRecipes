//
//  SeeAllViewController.swift
//  best-recipes-ios
//
//  Created by  Maksim Stogniy on 29.06.2024.
//

import UIKit

final class SeeAllViewController: UIViewController {
    
    //MARK: - Properties
    private var collectionView: UICollectionView!
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
        setDelegates()
        setupConstraint()
    }
    
    
    //MARK: - setup Views
    private func setViews() {
        self.title = "Trending Now"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 340, height: 200)
        layout.minimumLineSpacing = 24
        //        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.layer.cornerRadius = 15
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "CustomCell")
        
        view.addSubview(collectionView)
    }
    
    
    private func setDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}


//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension SeeAllViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
        cell.titleLabel.text = "How to make yam & vegetable sauce at home \(indexPath.item + 1)"
        cell.descriptionLabel.text = "9 ingredients | 25 min"
        cell.imageView.image = UIImage(resource: .recipes)
        
        return cell
    }
}


//MARK: - Setup Constraint
extension SeeAllViewController {
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}

