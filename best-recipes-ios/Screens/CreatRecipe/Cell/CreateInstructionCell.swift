//
//  CreateInstructionCell.swift
//  best-recipes-ios
//
//  Created by Vladimir Dmitriev on 09.07.24.
//

import UIKit

final class CreateInstructionCell: UICollectionViewCell, UITextFieldDelegate {
    
    private var numberOfInstruction: UILabel = {
        let label = UILabel()
        label.text = "1."
        label.font = UIFont.TextFonts.CreateRecipe.parametersTitle
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var InstructionTextField: UITextField = {
        let textField = RoundedTextFieldFactory(placeholderText: "Instruction name")
        return textField.createTextField()
    }()
        
    private var button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Plus-Border"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        InstructionTextField.delegate = self
        
        addSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.CreateRecipe.selectedBorderField.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.CreateRecipe.unselectedBorderField.cgColor
    }
    
    // MARK: - Private Methods
    private func addSubviews() {
        addSubview(numberOfInstruction)
        addSubview(InstructionTextField)
        addSubview(button)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            numberOfInstruction.topAnchor.constraint(equalTo: topAnchor),
            numberOfInstruction.leadingAnchor.constraint(equalTo: leadingAnchor),
            numberOfInstruction.bottomAnchor.constraint(equalTo: bottomAnchor),
            numberOfInstruction.widthAnchor.constraint(equalToConstant: 30),
            
            InstructionTextField.heightAnchor.constraint(equalTo: numberOfInstruction.heightAnchor),
            InstructionTextField.leadingAnchor.constraint(equalTo: numberOfInstruction.trailingAnchor, constant: 12),
            
            button.centerYAnchor.constraint(equalTo: centerYAnchor),
            button.leadingAnchor.constraint(equalTo: InstructionTextField.trailingAnchor, constant: 12),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.heightAnchor.constraint(equalToConstant: 24),
            button.widthAnchor.constraint(equalToConstant: 24)
        ])
    }
}

