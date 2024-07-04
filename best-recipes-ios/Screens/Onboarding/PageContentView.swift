//
//  PageContentView.swift
//  best-recipes-ios
//
//  Created by  Maksim Stogniy on 04.07.2024.
//
import UIKit

protocol PageContentViewDelegate: AnyObject {
    func tappedButton()
    func tappedSkip()
}


class PageContentView: UIView {
    
    weak var delegate: PageContentViewDelegate?
    
    // MARK: - Properties
    private let imageView: UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.contentMode = .scaleAspectFill
        return element
    }()
    
    private let shadowGradientView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let shadowGradientLayer = CAGradientLayer()
    
    private let label = LabelFactory.makeOnboardingPageLabel()
    private let button = ButtonFactory.onboardingPagesButton(title: "")
    private let skipButton = ButtonFactory.onboardingSecondaryButton(title: "Skip")
    
    private let pageControl: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var dots = [UIView]()
    
    // MARK: - Initialization
    init(pageData: OnboardingPageData) {
        super.init(frame: .zero)
        configure(pageData)
        setupPageControl()
        setViews()
        setupConstraints()
        addShadowGradient()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateGradient() {
        if let gradientLayer = self.layer.sublayers?.compactMap({ $0 as? CAGradientLayer }).first {
            gradientLayer.frame = self.bounds
        }
    }
    
    func updatePageControl(with currentIndex: Int) {
        for (index, dot) in dots.enumerated() {
            if index == currentIndex {
                applyGradientToDot(
                    to: dot,
                    colors: [
                        UIColor.Colors.Primary.primary20.cgColor,
                        UIColor.Colors.Secondary.secondary20.cgColor
                    ]
                )
            } else {
                dot.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
                dot.backgroundColor = UIColor.Colors.Neutral.neutral20
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func setViews() {
        self.backgroundColor = .clear
        [
            label,
            button,
            skipButton,
            imageView,
            shadowGradientView,
            pageControl
            
        ].forEach { addSubview($0) }
        
        sendSubviewToBack(shadowGradientView)
        sendSubviewToBack(imageView)
        
        setUpViews()
    }
    
    private func configure(_ pageData: OnboardingPageData) {
        imageView.image = pageData.backgroundImage
        label.attributedText = pageData.pageText
        button.setTitle(pageData.buttonText, for: .normal)
        
        if pageData.showSkip {
            skipButton.isHidden = false
        } else {
            skipButton.isHidden = true
        }
    }
    
    private func setUpViews() {
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        skipButton.addTarget(self, action: #selector(skipTapped), for: .touchUpInside)
    }
    
    private func setupPageControl() {
        for _ in 0..<3 {
            let dot = UIView()
            dot.backgroundColor = UIColor.Colors.Neutral.neutral20
            dot.layer.cornerRadius = 5
            dot.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                dot.widthAnchor.constraint(equalToConstant: 40),
                dot.heightAnchor.constraint(equalToConstant: 10)
            ])
            pageControl.addArrangedSubview(dot)
            dots.append(dot)
        }
    }
    
    private func applyGradientToDot(to view: UIView, colors: [CGColor]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.cornerRadius = 5
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    internal func addShadowGradient() {
        shadowGradientLayer.frame = shadowGradientView.bounds
        shadowGradientLayer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        shadowGradientLayer.startPoint = CGPoint(x: 0.5, y: 0.9)
        shadowGradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        shadowGradientView.layer.addSublayer(shadowGradientLayer)
        
        shadowGradientView.setNeedsLayout()
        shadowGradientView.layoutIfNeeded()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        shadowGradientLayer.frame = shadowGradientView.bounds
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            shadowGradientView.leftAnchor.constraint(equalTo: leftAnchor),
            shadowGradientView.rightAnchor.constraint(equalTo: rightAnchor),
            shadowGradientView.bottomAnchor.constraint(equalTo: bottomAnchor),
            shadowGradientView.heightAnchor.constraint(equalToConstant: 500),
            
            label.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -80),
            label.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            label.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -80),
            button.widthAnchor.constraint(equalToConstant: 195),
            button.heightAnchor.constraint(equalToConstant: 45),
            
            skipButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            skipButton.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 20),
            skipButton.widthAnchor.constraint(equalToConstant: 160),
            skipButton.heightAnchor.constraint(equalToConstant: 40),
            
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -160),
            pageControl.heightAnchor.constraint(equalToConstant: 10),
            pageControl.widthAnchor.constraint(equalToConstant: 140)
        ])
    }
    
    // MARK: - Actions
    @objc private func buttonTapped() {
        delegate?.tappedButton()
    }
    
    @objc private func skipTapped() {
        delegate?.tappedSkip()
    }
}
