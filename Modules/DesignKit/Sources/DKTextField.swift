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

public final class DKTextField: UIView {

    private lazy var label: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 12)
        return textField
    }()

    public init(
        viewModel: DSTextFieldViewModel
    ) {
        super.init(frame: .zero)
        self.backgroundColor = .gray
        configure(with: viewModel)
        setupView()
        self.addBottomBorder(of: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: DSTextFieldViewModel) {
        self.label.text = viewModel.title
    }
}

extension DKTextField: ViewCode {
    public func setupViewHierarchy() {
        addSubViews([
            label,
            textField
        ])
    }
    
    public func setupConstraints() {
        buildLabel()
        buildTextField()
    }
    
    private func buildLabel() {
        label.anchorToVerticalEdges(of: self)
        label.anchorToLeading(of: self)
        label.anchorWidth(basedOn: self, withSize: 0.5)
    }
    
    private func buildTextField() {
        textField.anchorToVerticalEdges(of: self)
        textField.anchorToTrailing(of: self)
        textField.anchorWidth(basedOn: self, withSize: 0.5)
    }
}

public struct DSTextFieldViewModel {
    public let title: String
    
    public init(
        title: String
     ) {
        self.title = title
    }
}

enum DKTextFieldType{
    case input, stepper
}
