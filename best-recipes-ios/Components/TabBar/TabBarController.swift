//
//  TabBarController.swift
//  best-recipes-ios
//
//  Created by  Maksim Stogniy on 02.07.2024.
//

import UIKit

final class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    private var middleBtn: UIButton?
    private var buttonContainer: UIView?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.delegate = self
        
        let tabBar = TabBar()
        self.setValue(tabBar, forKey: "tabBar")
        
        setupMiddleButton()
        setupTabBar()
        setupViewControllers()
    }

    func toggleMiddleButtonVisability(_ state: Bool) {
        middleBtn?.isHidden = state
        buttonContainer?.isHidden = state
    }
    
    private func setupViewControllers() {
        // MainScreen
        let homeVC = UINavigationController(rootViewController: HomeScreen())
        homeVC.tabBarItem = UITabBarItem(title: nil, image: Icons.TabBar.homeInactive, selectedImage: Icons.TabBar.homeActive.withRenderingMode(UIImage.RenderingMode.alwaysOriginal))
        homeVC.tabBarItem.tag = 1
        
        // Saved Recipes
        let favoriteRecipesVC = UINavigationController(rootViewController: SavedRecipesViewController())
        favoriteRecipesVC.tabBarItem = UITabBarItem(title: nil, image: Icons.TabBar.bookmarkInactive, selectedImage: Icons.TabBar.bookmarkActive.withRenderingMode(UIImage.RenderingMode.alwaysOriginal))
        favoriteRecipesVC.tabBarItem.tag = 2
        
        // Recipe Add
        let addRecipeVC = UINavigationController(rootViewController: CreateRecipeController())
        addRecipeVC.view.backgroundColor = .white
        addRecipeVC.tabBarItem = UITabBarItem(title: nil, image: nil, selectedImage: nil)
        addRecipeVC.tabBarItem.tag = 3
        
        // Empty notifications
        let notifyVC = UIViewController()
        notifyVC.tabBarItem = UITabBarItem(title: nil, image: Icons.TabBar.notificationInactive, selectedImage: Icons.TabBar.notificationActive.withRenderingMode(UIImage.RenderingMode.alwaysOriginal))
        notifyVC.tabBarItem.accessibilityRespondsToUserInteraction = false
        notifyVC.tabBarItem.tag = 4
        
        // Profile
        let profileVC = UINavigationController(rootViewController: ProfileController())
        profileVC.tabBarItem = UITabBarItem(title: nil, image: Icons.TabBar.profileInactive, selectedImage: Icons.TabBar.profileActive.withRenderingMode(UIImage.RenderingMode.alwaysOriginal))
        profileVC.tabBarItem.tag = 5
        
        self.viewControllers = [homeVC, favoriteRecipesVC, addRecipeVC, notifyVC, profileVC]
    }
    
    private func setupTabBar() {
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
    }
    
    func setupMiddleButton() {
        buttonContainer = UIView(
            frame: CGRect(
                x: (self.view.bounds.width / 2) - 25,
                y: self.view.bounds.height - tabBar.bounds.height - 50,
                width: 50,
                height: 50
            )
        )
        buttonContainer?.backgroundColor = .clear
        
        middleBtn = UIButton(type: .system)
        middleBtn?.frame = buttonContainer!.bounds
        
        middleBtn?.backgroundColor = UIColor.Colors.Primary.primary50
        middleBtn?.setImage(UIImage(systemName: "plus"), for: .normal)
        middleBtn?.tintColor = UIColor.Colors.Neutral.neutral100
        middleBtn?.layer.cornerRadius = 25
        
        buttonContainer?.addSubview(middleBtn!)
        self.view.addSubview(buttonContainer!)
        middleBtn?.addTarget(self, action: #selector(menuButtonAction), for: .touchUpInside)
        
        self.view.layoutIfNeeded()
    }
    
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.tabBarItem.tag == 4 {
            return false
        }
        if viewController.tabBarItem.tag == 3 {
            if let navigationController = self.viewControllers?[self.selectedIndex] as? UINavigationController {
                navigationController.pushViewController(CreateRecipeController(), animated: true)
            }
            return false
        }
        
        return true
    }
    
    
    @objc func menuButtonAction(sender: UIButton) {
        if let navigationController = self.viewControllers?[self.selectedIndex] as? UINavigationController {
            navigationController.pushViewController(CreateRecipeController(), animated: true)
        }
    }
}
