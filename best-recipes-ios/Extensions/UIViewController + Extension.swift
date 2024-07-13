//
//  UIViewController + Extension.swift
//  best-recipes-ios
//
//  Created by Алексей on 10.07.2024.
//

import UIKit

extension UIViewController {
    func addTapGestureToHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    func setupHomeScreenNavBar(on viewController: UIViewController,
                               with text: String,
                               searchController: UISearchController) {
        
        guard let width = viewController.navigationController?.navigationBar.frame.size.width,
              let height = viewController.navigationController?.navigationBar.frame.size.height  else { return }
        let titleHomeScreen: UILabel = {
            let label = UILabel(frame: CGRectMake(0, 0, width, height))
            label.backgroundColor = .clear
            label.numberOfLines = 0
            label.font = UIFont.PoppinsFont.semibold(size: 24)
            label.textAlignment = .left
            label.textColor = .black
            label.text = text
            return label
        }()
        
        navigationItem.titleView = titleHomeScreen
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        extendedLayoutIncludesOpaqueBars = true
    }
    
    func setupNavBarWithoutButtons(on viewController: UIViewController, with text: String)
        {
        let titleLabel: UILabel = {
            let label = UILabel()
            label.text = text
            label.textAlignment = .center
            label.font = UIFont.PoppinsFont.semibold(size: 24)
            return label
        }()
        viewController.navigationItem.titleView = titleLabel
    }

    func setupNavBarWithButtons(on viewController: UIViewController, text: String) {

        let backButton: UIButton = {
            let button = UIButton()
            button.setImage(Icons.arrowLeft, for: .normal)
            button.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
            return button
        }()
        
        let titleLabel: UILabel = {
            let label = UILabel()
            label.text = text
            label.textAlignment = .center
            label.font = UIFont.PoppinsFont.semibold(size: 24)
            return label
        }()
        
        viewController.navigationItem.titleView = titleLabel
        viewController.navigationItem.setHidesBackButton(true, animated: true)
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    @objc func backButtonPressed(_ sender: UIButton) {
        sender.alpha = 0.45
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            sender.alpha = 1
            self.navigationController?.popViewController(animated: true)
       }
    }
}
