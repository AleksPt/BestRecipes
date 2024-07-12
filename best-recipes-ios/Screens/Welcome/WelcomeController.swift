//
//  WelcomeController.swift
//  best-recipes-ios
//
//  Created by  Maksim Stogniy on 03.07.2024.
//

import UIKit

final class WelcomeController: UIViewController {
    private let welcomeView = WelcomeView()
    
    override func loadView() {
        view = welcomeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        welcomeView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        welcomeView.updateGradient()
    }
}

extension WelcomeController: WelcomeViewDelegate {
    func tappedGetStarted() {
        let vc = OnboardingViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
