//
//  DKStepperField.swift
//  DesignKit
//
//  Created by Fernando de Lucas da Silva Gomes on 04/05/22.
//  Copyright © 2022 Marker. All rights reserved.
//

import UIKit
import Strategy
import CloudKit

public final class DKStepperField: UIView {
    
    private lazy var label: UILabel = {
       let label = UILabel()
        label.font = .systemFont(
            ofSize: 15,
            weight: .semibold
        )
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var stepper: UIStepper = {
        let stepper = UIStepper()
        stepper.tintColor = .black
        stepper.backgroundColor = .clear
        stepper.addTarget(
            self,
            action: #selector(didTapStepper),
            for: .valueChanged
        )
        return stepper
    }()
    
    public var value: Int {
        Int(self.stepper.value)
    }
    
    private var title: String

    public init(
        title: String
    ) {
        self.title = title
        super.init(frame: .zero)
        self.backgroundColor = .systemBackground
        setupView()
        setupActions()
        self.label.text = title
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DKStepperField: ViewCode {
    public func setupViewHierarchy() {
        addSubViews([
            label,
            stepper
        ])
        self.addBottomBorder(of: 0.7)
    }
    
    public func setupConstraints() {
        buildLabel()
        buildStepper()
    }
    
    public func setupActions() {
    }
    
    private func buildLabel() {
        label.anchorToVerticalEdges(of: self)
        label.anchorToLeading(of: self)
        label.anchorWidth(basedOn: self, withSize: 0.7)
    }
    
    private func buildStepper() {
        stepper.anchorToVerticalEdges(of: self)
        stepper.anchorToTrailing(of: self)
        stepper.anchorWidth(basedOn: self, withSize: 0.3)
    }
}

extension DKStepperField {
    @objc
    private func didTapStepper(sender: UIStepper) {
        var description: String = " "
        if sender.value > 0 {
            description += "\(Int(sender.value))"
        }
        self.label.text = self.title + description
    }
}
