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
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 12)
        textField.textAlignment = .right
        return textField
    }()
    
    public var value: Int {
        guard let text = self.textField.text else {
            return 0
        }
        return Int(text) ?? 0
    }
    
    public var text: String? {
        self.textField.text
    }
    
    public init(
        title: String
    ) {
        super.init(frame: .zero)
        self.backgroundColor = .systemBackground
        configure(with: title)
        setupView()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with title: String) {
        self.label.text = title
    }
}

extension DKTextField: ViewCode {
    public func setupViewHierarchy() {
        addSubViews([
            label,
            textField
        ])
        self.addBottomBorder(of: 0.7)
    }
    
    public func setupConstraints() {
        buildLabel()
        buildTextField()
    }
    
    private func buildLabel() {
        label.anchorToVerticalEdges(of: self)
        label.anchorToLeading(of: self)
        label.anchorWidth(basedOn: self, withSize: 0.4)
    }
    
    private func buildTextField() {
        textField.anchorToVerticalEdges(of: self)
        textField.anchorToTrailing(of: self)
        textField.anchorWidth(basedOn: self, withSize: 0.6)
    }
}
