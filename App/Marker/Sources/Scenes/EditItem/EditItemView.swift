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
            value: "Quadrinho"
        )
    )
    
    private lazy var organizedByField = DKSelectorField(
        viewModel: .init(
            title: "Organizar por",
            value: "Volume"
        )
    )
    
    private lazy var statusField = DKSelectorField(
        viewModel: .init(
            title: "Status",
            value: "Quero ler"
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
            typeField,
            organizedByField,
            statusField
        ])
    }
    
    public func setupConstraints() {
        setupTextField()
        setupStepper()
        setupFinalNumberTextField()
        setupTypeField()
        setupOrganizedField()
        setupStatusField()
    }
    
    private func setupTextField() {
        nameTextField.anchorToHorizontalEdges(of: self, withSpace: 17)
        nameTextField.anchorToTop(of: self, constant: 0.22)
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

    private func setupOrganizedField() {
        organizedByField.anchorToHorizontalEdges(of: self, withSpace: 17)
        organizedByField.anchorTopToBottom(of: self.typeField)
        organizedByField.anchorHeight(basedOn: self, withSize: 0.05)
    }
    
    private func setupStatusField() {
        statusField.anchorToHorizontalEdges(of: self, withSpace: 17)
        statusField.anchorTopToBottom(of: self.organizedByField)
        statusField.anchorHeight(basedOn: self, withSize: 0.05)
    }
}
