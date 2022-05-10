//
//  AddItemView.swift
//  Marker
//
//  Created by Fernando de Lucas da Silva Gomes on 24/04/22.
//  Copyright © 2022 Marker. All rights reserved.
//

import DesignKit
import UIKit
import Strategy

final class EditItemView: UIView {
        
    private lazy var nameTextField = DKTextField(viewModel: .init(title: "Nome"))
    
    private lazy var stepperField = DKStepperField(title: "Volumes")
    
    private lazy var finalNumberTextField = DKTextField(viewModel: .init(title: "VolumeFinal"))

    private lazy var typeField = DKSelectorField(
        viewModel: .init(
            title: "Tipo",
            value: "Quadrinho",
            imageAcessory: UIImage(systemName: "chevron.right")
        )
    )

    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EditItemView: ViewCode {
    public func setupViewHierarchy() {
        addSubViews([
            nameTextField,
            stepperField,
            finalNumberTextField,
            typeField
        ])
    }
    
    public func setupConstraints() {
        setupTextField()
        setupStepper()
        setupFinalNumberTextField()
        setupTypeField()
    }
    
    private func setupTextField() {
        nameTextField.anchorToHorizontalEdges(of: self, withSpace: 17)
        nameTextField.anchorToTop(of: self.safeAreaLayoutGuide)
        nameTextField.anchorHeight(basedOn: self, withSize: 0.05)
    }
    
    private func setupStepper() {
        stepperField.anchorToHorizontalEdges(of: self, withSpace: 17)
        stepperField.anchorTopToBottom(of: self.nameTextField)
        stepperField.anchorHeight(basedOn: self, withSize: 0.05)
    }
    
    private func setupFinalNumberTextField() {
        finalNumberTextField.anchorToHorizontalEdges(of: self, withSpace: 17)
        finalNumberTextField.anchorTopToBottom(of: self.stepperField)
        finalNumberTextField.anchorHeight(basedOn: self, withSize: 0.05)
    }
    
    private func setupTypeField() {
        typeField.anchorToHorizontalEdges(of: self, withSpace: 17)
        typeField.anchorTopToBottom(of: self.finalNumberTextField)
        typeField.anchorHeight(basedOn: self, withSize: 0.05)
    }

}
