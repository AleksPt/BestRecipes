//
//  PickerView.swift
//  best-recipes-ios
//
//  Created by Алексей on 12.07.2024.
//

import UIKit

final class PickerViewController: UIViewController {
    
    weak var delegate: CreateRecipeDelegate?
    
    // MARK: - UI
    private lazy var background: UIView = {
        let element = UIView()
        element.frame = view.frame
        element.backgroundColor = .black
        element.layer.opacity = 0.75
        let gesture = UITapGestureRecognizer(target: self, action: #selector(closed))
        element.addGestureRecognizer(gesture)
        return element
    }()
    
    private lazy var customView: UIView = {
       let element = UIView()
        element.backgroundColor = .white
        element.layer.cornerRadius = 12
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let element = UIDatePicker()
        element.backgroundColor = .green
        element.preferredDatePickerStyle = .wheels
        element.datePickerMode = .countDownTimer
        element.translatesAutoresizingMaskIntoConstraints = false
        element.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged)
        return element
    }()
    
    private lazy var closedButton: UIButton = {
        let element = UIButton(type: .system)
        element.tintColor = .black
        element.setBackgroundImage(UIImage(systemName: "multiply.circle.fill"), for: .normal)
        element.translatesAutoresizingMaskIntoConstraints = false
        element.addTarget(self, action: #selector(closed), for: .touchUpInside)
        return element
    }()
    
    private let selectTimeButton = ButtonFactory.onboardingMainPageButton(title: "Select Time")
    
    // MARK: - Init
    init() {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(background)
        view.addSubview(customView)
        customView.addSubview(datePicker)
        customView.addSubview(closedButton)
        customView.addSubview(selectTimeButton)
        setupConstraints()
        selectTimeButton.addTarget(
            self,
            action: #selector(didTapSelectTimeButton(sender:)),
            for: .touchUpInside
        )
    }
    
    // MARK: - Actions
    @objc private func dateChanged(datePicker: UIDatePicker) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        let hours = dateFormatter.string(from: datePicker.date)
        let hoursInt: Int = Int(hours)!
        dateFormatter.dateFormat = "mm"
        let minutes = dateFormatter.string(from: datePicker.date)
        let minutesInt: Int = Int(minutes)!
        let result = hoursInt * 60 + minutesInt
        return result
    }
    
    @objc private func didTapSelectTimeButton(sender: UIButton) {
        let value = dateChanged(datePicker: datePicker)
        if value == 0 {
            delegate?.updateCookTime(time: 1)
        } else {
            delegate?.updateCookTime(time: value)
        }
        dismiss(animated: true)
    }
    
    @objc private func closed() {
        dismiss(animated: true)
    }

}

// MARK: - Setup Constraints
extension PickerViewController {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            customView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            customView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            customView.heightAnchor.constraint(equalToConstant: 248),
            customView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            datePicker.leadingAnchor.constraint(equalTo: customView.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: customView.trailingAnchor),
            datePicker.topAnchor.constraint(equalTo: customView.topAnchor),
            datePicker.bottomAnchor.constraint(equalTo: selectTimeButton.topAnchor),
            
            closedButton.topAnchor.constraint(equalTo: customView.topAnchor, constant: 8),
            closedButton.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -8),
            closedButton.widthAnchor.constraint(equalToConstant: 24),
            closedButton.heightAnchor.constraint(equalToConstant: 24),
            
            selectTimeButton.widthAnchor.constraint(equalTo: datePicker.widthAnchor, multiplier: 0.95),
            selectTimeButton.heightAnchor.constraint(equalToConstant: 48),
            selectTimeButton.bottomAnchor.constraint(equalTo: customView.bottomAnchor, constant: -8),
            selectTimeButton.centerXAnchor.constraint(equalTo: customView.centerXAnchor),
        ])
    }
}
