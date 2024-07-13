//
//  Rating.swift
//  best-recipes-ios
//
//  Created by  Maksim Stogniy on 13.07.2024.
//

import UIKit

class RatingView: UIView {
    
    private let blurEffectView: UIVisualEffectView
    private let imageView: UIImageView
    private let label: UILabel
    
    // MARK: - Initialization
    
    private init(
        label: UILabel,
        blurEffect: UIBlurEffect?
    ) {
        self.imageView = UIImageView(image: Icons.star)
        self.label = label
        self.blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        super.init(frame: CGRect(origin: .zero, size: CGSize(width: 58, height: 28)))
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    static func make(ratingLabel: String, blur: Bool = true) -> RatingView {
        let label = UILabel()
        label.font = UIFont.PoppinsFont.semibold(size: 14)
        label.text = ratingLabel
        label.textColor = blur ? UIColor.Colors.Rating.ratingWhite : UIColor.Colors.Rating.ratingBlack
        
        return RatingView(label: label, blurEffect: blur ? UIBlurEffect(style: .systemUltraThinMaterialDark) : nil)
    }
    
    func setRatingLabel(_ value: Double) {
        label.text = convertToRating(score: value)
    }
    
    private func convertToRating(score: Double) -> String {
        // Максимальное значение исходного диапазона
        let maxOriginalValue: Double = 100.0
        
        // Максимальное значение целевого диапазона
        let maxTargetValue: Double = 5.0
        
        // Преобразование
        let rating = (score / maxOriginalValue) * maxTargetValue
        
        // Округление до одного знака после запятой и форматирование строки
        let formattedRating = String(format: "%.1f", rating)
        
        return formattedRating.replacingOccurrences(of: ".", with: ",")
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        self.translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 8
        blurEffectView.layer.cornerRadius = 8
        blurEffectView.clipsToBounds = true
        blurEffectView.frame = self.frame
        
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(blurEffectView)
        
        blurEffectView.contentView.addSubview(imageView)
        blurEffectView.contentView.addSubview(label)

        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: blurEffectView.centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: blurEffectView.leadingAnchor, constant: 8),
            imageView.widthAnchor.constraint(equalToConstant: 16),
            imageView.heightAnchor.constraint(equalToConstant: 16),
            
            label.centerYAnchor.constraint(equalTo: blurEffectView.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 3),
            label.trailingAnchor.constraint(equalTo: blurEffectView.trailingAnchor, constant: -8),
        ])
    }
}
