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
import Strategy

class ShelfView: UIView {
    
    private lazy var segmentedControl: DKSegmentedControl = {
        let segmentedControl = DKSegmentedControl(items: ["Lido", "Lendo", "Para Ler"])
        segmentedControl.setBackgroundImage(UIImage(ciImage: .clear), for: .normal, barMetrics: .default)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        return segmentedControl
    }()
    
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
        segmentedControl.anchorToTop(of: self.safeAreaLayoutGuide)
        segmentedControl.anchorToHorizontalEdges(
            of: self,
            withSpace: 17
        )
        segmentedControl.anchorHeight(basedOn: self, withSize: 0.05)
    }
    
    @objc
    func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        segmentedControl.indexChanged(newIndex: sender.selectedSegmentIndex)
    }
}
