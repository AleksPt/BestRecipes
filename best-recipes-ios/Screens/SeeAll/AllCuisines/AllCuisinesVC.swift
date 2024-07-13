//
//  AllCuisinesVC.swift
//  best-recipes-ios
//
//  Created by Алексей on 10.07.2024.
//

import UIKit

final class AllCuisinesVC: UIViewController {
    
    var cuisines: [Cuisine] = Cuisine.getCuisines()
    private let allCuisinesView = AllCuisinesView()
    
    // MARK: - Life Cycle
    override func loadView() {
        view = allCuisinesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allCuisinesView.setDelegates(self)
        setupNavBarWithButtons(on: self, text: "World cuisine")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let tabBarController = self.tabBarController as? TabBarController {
            tabBarController.tabBar.isHidden = true
            tabBarController.toggleMiddleButtonVisability(true)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let tabBarController = self.tabBarController as? TabBarController {
            tabBarController.tabBar.isHidden = false
            tabBarController.toggleMiddleButtonVisability(false)
        }
    }
}

// MARK: - UITableViewDataSource
extension AllCuisinesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cuisines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: AllCuisinesCell.description(),
            for: indexPath
        ) as? AllCuisinesCell else {
            return UITableViewCell()
        }
        cell.configureCell(cuisine: cuisines[indexPath.item])
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

// MARK: - UITableViewDelegate
extension AllCuisinesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        89
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let seeAllVC = SeeAllViewController(type: .worldCuisine)
        seeAllVC.hidesBottomBarWhenPushed = true
        seeAllVC.nameCuisine = cuisines[indexPath.row].rawValue
        navigationController?.pushViewController(seeAllVC, animated: true)
    }
}
