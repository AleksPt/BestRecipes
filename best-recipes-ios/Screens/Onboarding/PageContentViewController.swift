//
//  PageContentViewController.swift
//  best-recipes-ios
//
//  Created by  Maksim Stogniy on 04.07.2024.
//
import UIKit

class PageContentViewController: UIViewController {
    
    weak var delegate: OnboardingActionsDelegate?
    
    private let contentView: PageContentView

    init(pageData: OnboardingPageData) {
        self.contentView = PageContentView(pageData: pageData)
        super.init(nibName: nil, bundle: nil)
        
        contentView.delegate = self
        view.addSubview(contentView)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        contentView.updateGradient()
    }
    
    func updatePageControl(with currentIndex: Int) {
        contentView.updatePageControl(with: currentIndex)
    }
    
    // MARK: - Private Methods
    private func setupConstraints() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }    
}

extension PageContentViewController: PageContentViewDelegate {
    func tappedButton() {
        delegate?.onboardingButtonTapped()
    }
    
    func tappedSkip() {
        delegate?.onboardingSkipTapped()
    }
}
    
