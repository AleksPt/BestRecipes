//
//  InstructionsTableViewCell.swift
//  best-recipes-ios
//
//  Created by Елена Логинова on 04.07.2024.
//

import UIKit

final class InstructionsTableViewCell: UITableViewCell {

    static let identifier = "InstructionsTableViewCell"
    
    private let stepNumberLabel = LabelFactory.makeStepInstructionLabel(text: "10.")
    
    private let instructionTextLabel = LabelFactory.makeInstructionTextLabel(text: "instruction text")

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(stepNumberLabel)
        addSubview(instructionTextLabel)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        stepNumberLabel.text = nil
        instructionTextLabel.text = nil
    }
    
    public func configureCell(with instructionStep: Step) {
        stepNumberLabel.text = "\(instructionStep.number)."
        instructionTextLabel.text = instructionStep.step
        selectionStyle = .none
    }
    
    private func setConstraint() {
        NSLayoutConstraint.activate([
            stepNumberLabel.topAnchor.constraint(equalTo: topAnchor),
            stepNumberLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            stepNumberLabel.widthAnchor.constraint(equalToConstant: 25),
            
            instructionTextLabel.topAnchor.constraint(equalTo: topAnchor),
            instructionTextLabel.leadingAnchor.constraint(equalTo: stepNumberLabel.trailingAnchor, constant: 5),
            instructionTextLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -23),
            instructionTextLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

}
