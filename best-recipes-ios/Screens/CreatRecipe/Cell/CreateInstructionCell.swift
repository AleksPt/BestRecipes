//
//  CreateInstructionCell.swift
//  best-recipes-ios
//
//  Created by Vladimir Dmitriev on 09.07.24.
//

import UIKit

final class CreateInstructionCell: UICollectionViewCell {
    
    var completionHandlerAdd: ((String)->())?
    var completionHandlerDelete: (()->())?
    
    var numberOfInstruction: UILabel = {
        let label = UILabel()
        label.font = UIFont.TextFonts.CreateRecipe.parametersTitle
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let instructionTextField = RoundedTextFieldFactory(placeholderText: "Enter instruction").createTextField()
        
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(Icons.plus.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(addInstruction), for: .touchUpInside)
        return button
    }()
    
    private lazy var toolbar = Toolbar.setupToolbar(target: self, selector: #selector(didTapToolbarButton))
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        instructionTextField.delegate = self
        instructionTextField.inputAccessoryView = toolbar
        addSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        numberOfInstruction.text = nil
    }
    
    func configureCell(index: Int) {
        numberOfInstruction.text = index.description
    }
    
    // MARK: - Private Methods
    private func addSubviews() {
        addSubview(numberOfInstruction)
        addSubview(instructionTextField)
        addSubview(button)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            numberOfInstruction.topAnchor.constraint(equalTo: topAnchor),
            numberOfInstruction.leadingAnchor.constraint(equalTo: leadingAnchor),
            numberOfInstruction.bottomAnchor.constraint(equalTo: bottomAnchor),
            numberOfInstruction.widthAnchor.constraint(equalToConstant: 30),
            
            instructionTextField.heightAnchor.constraint(equalTo: numberOfInstruction.heightAnchor),
            instructionTextField.leadingAnchor.constraint(equalTo: numberOfInstruction.trailingAnchor),
            
            button.centerYAnchor.constraint(equalTo: centerYAnchor),
            button.leadingAnchor.constraint(equalTo: instructionTextField.trailingAnchor, constant: 12),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.heightAnchor.constraint(equalToConstant: 24),
            button.widthAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    // MARK: - Actions
    @objc private func addInstruction(_ sender: UIButton) {
        if sender.currentImage == Icons.plus.withRenderingMode(UIImage.RenderingMode.alwaysOriginal) {
            if let text = instructionTextField.text, !text.isEmpty {
                completionHandlerAdd?(text)
                sender.setImage(Icons.minus.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), for: .normal)
            }
        } else {
            completionHandlerDelete?()
        }
    }
    
    @objc private func didTapToolbarButton() {
        instructionTextField.resignFirstResponder()
    }
}

// MARK: - UITextFieldDelegate
extension CreateInstructionCell: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.CreateRecipe.selectedBorderField.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.CreateRecipe.unselectedBorderField.cgColor
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
