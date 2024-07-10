//
//  AllCuisinesView.swift
//  best-recipes-ios
//
//  Created by Алексей on 10.07.2024.
//

import UIKit

final class AllCuisinesView: UIView {
    
    // MARK: - UI
    private lazy var tableView: UITableView = {
        let element = UITableView(frame: .zero)
        element.register(AllCuisinesCell.self, forCellReuseIdentifier: AllCuisinesCell.description())
        element.translatesAutoresizingMaskIntoConstraints = false
        element.separatorStyle = .none
        element.showsVerticalScrollIndicator = false
        return element
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Public methods
    func setDelegates(_ value: AllCuisinesVC) {
        tableView.delegate = value
        tableView.dataSource = value
    }
    
    // MARK: - Private methods
    private func addSubviews() {
        addSubview(tableView)
    }
    
    private func setupView() {
        backgroundColor = UIColor.GlobalBackground.light
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
