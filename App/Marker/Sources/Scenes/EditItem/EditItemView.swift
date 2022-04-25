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
    
    private let textField = DKTextField(viewModel: .init(title: "Nome"))

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
            textField
        ])
    }
    
    public func setupConstraints() {
        textField.anchorToHorizontalEdges(of: self)
        textField.anchorToTop(of: self.safeAreaLayoutGuide)
        textField.anchorHeight(basedOn: self, withSize: 0.05)
    }
}
