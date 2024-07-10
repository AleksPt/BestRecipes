//
//  SearchResultView.swift
//  best-recipes-ios
//
//  Created by Елена Логинова on 11.07.2024.
//

import UIKit

final class SearchResultView: UIView {
    
    //MARK: -  UI Elements
    let searchResultTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .none
        tableView.bounces = false
        tableView.separatorStyle = .none
        tableView.register(SearchResultTableViewCell.self, forCellReuseIdentifier: SearchResultTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Set Delegates
    func setDelegate(viewController: SearchResultViewController) {
        searchResultTableView.delegate = viewController
        searchResultTableView.dataSource = viewController
    }
    
    private func setupView() {
        addSubview(searchResultTableView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            searchResultTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            searchResultTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchResultTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchResultTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
