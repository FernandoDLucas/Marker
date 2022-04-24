//
//  DKTextFieldCell.swift
//  DesignKit
//
//  Created by Fernando de Lucas da Silva Gomes on 24/04/22.
//  Copyright © 2022 Marker. All rights reserved.
//

import UIKit
import AnchorKit
import Strategy

class DKTextField: UIView {

    private let viewModel: DSTextFieldViewModel
    private lazy var label: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 14)
        return textField
    }()

    public init(
        viewModel: DSTextFieldViewModel
    ) {
        self.viewModel = viewModel
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DKTextField: ViewCode {
    func setupViewHierarchy() {
        addSubViews([
            label,
            textField
        ])
    }
    
    func setupConstraints() {
        buildLabel()
        buildTextField()
    }
    
    private func buildLabel() {
        label.anchorToHorizontalEdges(of: self)
        label.anchorToLeading(of: self)
        label.anchorWidth(basedOn: self, withSize: 0.5)
    }
    
    private func buildTextField() {
        textField.anchorToHorizontalEdges(of: self)
        textField.anchorToTrailing(of: self)
        textField.anchorWidth(basedOn: self, withSize: 0.5)
    }
}

struct DSTextFieldViewModel {
    public let identifier: String
    public let title: String
    public let type: DKTextFieldType
    
    public init(
        identifier: String,
        title: String,
        type: DKTextFieldType
    ) {
        self.identifier = identifier
        self.title = title
        self.type = type
    }
}

enum DKTextFieldType{
    case input, stepper
}
