//
//  ShelfView.swift
//  Marker
//
//  Created by Fernando de Lucas da Silva Gomes on 15/03/22.
//  Copyright © 2022 Marker. All rights reserved.
//

import UIKit
import AnchorKit
import DesignKit

class ShelfView: UIView {
    
    private lazy var segmentedControl = DKSegmentedControl(items: ["Lido", "Lendo", "Para Ler"])
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ShelfView: ViewCode {
    func setupViewHierarchy() {
        addSubview(segmentedControl)
    }
    
    func setupConstraints() {
        segmentedControl.anchorToSafeArea(of: self.safeAreaLayoutGuide)
    }
}
