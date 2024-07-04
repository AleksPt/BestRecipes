//
//  WelcomeView.swift
//  best-recipes-ios
//
//  Created by  Maksim Stogniy on 03.07.2024.
//

import UIKit

protocol WelcomeViewDelegate: AnyObject {
    func tappedGetStarted()
}

final class WelcomeView: UIView {

    weak var delegate: WelcomeViewDelegate?
    
    private let getStartedButton = ButtonFactory.onboardingMainPageButton(title: "Get started")
    private let title = LabelFactory.makeOnboardingScreenLabel(text: "Best\nRecipe")
    private let subtitle = LabelFactory.makeOnboardingSmallLabel(text: "Find best recipes for cooking")
    private let upperLabel = LabelFactory.makeOnboardingSmallLabel(text: "Premium recipes")
    private let countLabel = LabelFactory.makeOnboardingSmallBoldLabel(text: "100+")
    private let starImage: UIImageView = {
        let element = UIImageView(image: Icons.star)
        element.translatesAutoresizingMaskIntoConstraints = false
        element.contentMode = .scaleAspectFill
        return element
    }()
    private let backgroundImage: UIImageView = {
        let element = UIImageView(image: Images.Onboarding.page0)
        element.translatesAutoresizingMaskIntoConstraints = false
        element.contentMode = .scaleAspectFill
        return element
    }()
    private let gradientView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let gradientLayer = CAGradientLayer()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        layoutViews()
        addGradient()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateGradient() {
        if let gradientLayer = self.layer.sublayers?.compactMap({ $0 as? CAGradientLayer }).first {
            gradientLayer.frame = self.bounds
        }
    }
    
    private func setViews() {
        self.backgroundColor = .clear
        [
            title,
            starImage,
            subtitle,
            upperLabel,
            countLabel,
            backgroundImage,
            getStartedButton,
            gradientView
            
        ].forEach { addSubview($0) }
        
        sendSubviewToBack(gradientView)
        sendSubviewToBack(backgroundImage)
        
        setUpViews()
    }
    
    private func setUpViews(){
        getStartedButton.addTarget(nil, action: #selector(getStartedTapped), for: .touchUpInside)
    }
    
    
    private func layoutViews() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backgroundImage.leftAnchor.constraint(equalTo: self.leftAnchor),
            backgroundImage.rightAnchor.constraint(equalTo: self.rightAnchor),
            
            gradientView.leftAnchor.constraint(equalTo: self.leftAnchor),
            gradientView.rightAnchor.constraint(equalTo: self.rightAnchor),
            gradientView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            gradientView.heightAnchor.constraint(equalToConstant: 500),
            
            
            getStartedButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -50),
            getStartedButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            getStartedButton.heightAnchor.constraint(equalToConstant: 60),
            getStartedButton.widthAnchor.constraint(equalToConstant: 160),
            
            subtitle.bottomAnchor.constraint(equalTo: getStartedButton.topAnchor, constant: -35),
            subtitle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            title.bottomAnchor.constraint(equalTo: subtitle.topAnchor, constant: -15),
            title.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            starImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15),
            starImage.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 85),
            countLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15),
            countLabel.leftAnchor.constraint(equalTo: starImage.rightAnchor, constant: 10),
            countLabel.centerYAnchor.constraint(equalTo: starImage.centerYAnchor),
            
            upperLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15),
            upperLabel.leftAnchor.constraint(equalTo: countLabel.rightAnchor),
            upperLabel.centerYAnchor.constraint(equalTo: starImage.centerYAnchor),
        ])
    }
    
    private func addGradient() {
        gradientLayer.frame = gradientView.bounds
        gradientLayer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.9)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientView.layer.addSublayer(gradientLayer)
        
        gradientView.setNeedsLayout()
        gradientView.layoutIfNeeded()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = gradientView.bounds
    }
    
    @objc private func getStartedTapped(){
        delegate?.tappedGetStarted()
    }
    
}
