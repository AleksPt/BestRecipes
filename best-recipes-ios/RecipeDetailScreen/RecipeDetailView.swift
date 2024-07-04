//
//  RecipeDetailView.swift
//  best-recipes-ios
//
//  Created by Елена Логинова on 04.07.2024.
//

import UIKit

class RecipeDetailView: UIView {

    //MARK: -  UI Elements
    private let instructionsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .none
        tableView.bounces = false
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = true
        tableView.showsVerticalScrollIndicator = false
        
        tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: ImageTableViewCell.identifier)
        tableView.register(InstructionsTableViewCell.self, forCellReuseIdentifier: InstructionsTableViewCell.identifier)
        tableView.register(IngredientsTableViewCell.self, forCellReuseIdentifier: IngredientsTableViewCell.identifier)
        tableView.register(HeaderTableView.self, forHeaderFooterViewReuseIdentifier: HeaderTableView.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("RecipeDetailView not initialised")
    }
    
    func setupView() {
        backgroundColor = .white
        addSubview(instructionsTableView)
    }
    
    //MARK: - Set Delegates
    func setDelegate(viewController: RecipeDetailViewController) {
        instructionsTableView.delegate = viewController
        instructionsTableView.dataSource = viewController
    }
    
    // MARK: - Set Constraints
    func setConstraints() {
        NSLayoutConstraint.activate([
            
            instructionsTableView.topAnchor.constraint(equalTo: topAnchor),
            instructionsTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            instructionsTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            instructionsTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

