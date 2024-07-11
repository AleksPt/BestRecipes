//
//  TabBarController.swift
//  best-recipes-ios
//
//  Created by  Maksim Stogniy on 02.07.2024.
//

import UIKit

final class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.delegate = self
        
        let tabBar = TabBar()
        self.setValue(tabBar, forKey: "tabBar")
        
        setupMiddleButton()
        setupTabBar()
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        // MainScreen
        let homeVC = UINavigationController(rootViewController: HomeScreen())
        homeVC.tabBarItem = UITabBarItem(title: nil, image: Icons.TabBar.homeInactive, selectedImage: Icons.TabBar.homeActive.withRenderingMode(UIImage.RenderingMode.alwaysOriginal))
        homeVC.tabBarItem.tag = 1
        
        // Saved Recipes
        let savedRecipesVC = SavedRecipesViewController()
        savedRecipesVC.tabBarItem = UITabBarItem(title: nil, image: Icons.TabBar.bookmarkInactive, selectedImage: Icons.TabBar.bookmarkActive.withRenderingMode(UIImage.RenderingMode.alwaysOriginal))
        savedRecipesVC.tabBarItem.tag = 2
        
        // Recipe Add
//        let thirdVC = UIViewController()
//        thirdVC.view.backgroundColor = .white
//        thirdVC.tabBarItem = UITabBarItem(title: nil, image: nil, selectedImage: nil)
//        thirdVC.tabBarItem.tag = 3
        // Empty notifications
//        let fourthVC = UIViewController()
//        fourthVC.tabBarItem = UITabBarItem(title: nil, image: Icons.TabBar.notificationInactive, selectedImage: Icons.TabBar.notificationActive.withRenderingMode(UIImage.RenderingMode.alwaysOriginal))
//        fourthVC.tabBarItem.accessibilityRespondsToUserInteraction = false
//        fourthVC.tabBarItem.tag = 4
        
        // Profile
        let profileVC = UINavigationController(rootViewController: ProfileController())
        profileVC.tabBarItem = UITabBarItem(title: nil, image: Icons.TabBar.profileInactive, selectedImage: Icons.TabBar.profileActive.withRenderingMode(UIImage.RenderingMode.alwaysOriginal))
        profileVC.tabBarItem.tag = 5
        
        self.viewControllers = [homeVC, savedRecipesVC, profileVC] //[firstVC, secondVC, thirdVC, fourthVC, fifththVC]
    }
    
    private func setupTabBar() {
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
    }
    
    func setupMiddleButton() {
        let buttonContainer = UIView(
            frame: CGRect(
                x: (self.view.bounds.width / 2) - 25,
                y: self.view.bounds.height - tabBar.bounds.height - 50,
                width: 50,
                height: 50
            )
        )
        buttonContainer.backgroundColor = .clear
        
        let middleBtn = UIButton(type: .system)
        middleBtn.frame = buttonContainer.bounds
        
        middleBtn.backgroundColor = UIColor.Colors.Primary.primary50
        middleBtn.setImage(UIImage(systemName: "plus"), for: .normal)
        middleBtn.tintColor = UIColor.Colors.Neutral.neutral100
        middleBtn.layer.cornerRadius = 25
        
        buttonContainer.addSubview(middleBtn)
        self.view.addSubview(buttonContainer)
        middleBtn.addTarget(self, action: #selector(menuButtonAction), for: .touchUpInside)
        
        self.view.layoutIfNeeded()
    }
    
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.tabBarItem.tag == 4 {
            return false
        }
        
        return true
    }
    
    
    @objc func menuButtonAction(sender: UIButton) {
        // Select RecipeAddController manualy, because it is hidden
        self.selectedIndex = 2
    }
}
