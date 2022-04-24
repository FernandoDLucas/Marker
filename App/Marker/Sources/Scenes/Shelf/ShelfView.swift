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
import NetworkingKit

final class ShelfView: UIView {
    
    private lazy var segmentedControl: DKSegmentedControl = {
        let segmentedControl = DKSegmentedControl(items: ["Lido", "Lendo", "Para Ler"])
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        return segmentedControl
    }()
    private let viewModel: ShelfCollectionViewModelProtocol
    private let collectionView = ShelfCollectionView()
        
    init(
        ViewModel: ShelfCollectionViewModelProtocol
    ) {
        self.viewModel = ViewModel
        super.init(frame: .zero)
        setupView()
        self.viewModel.delegate = self
        collectionView.delegate = self.viewModel
        collectionView.dataSource = self.viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ShelfView: ViewCode {
    func setupViewHierarchy() {
        addSubViews([
            segmentedControl,
            collectionView
        ])
    }
    
    func setupConstraints() {
        segmentedControl.anchorToTop(of: self.safeAreaLayoutGuide)
        segmentedControl.anchorToHorizontalEdges(
            of: self,
            withSpace: 17
        )
        segmentedControl.anchorHeight(basedOn: self, withSize: 0.05)
        collectionView.anchorTopToBottom(of: segmentedControl)
        collectionView.anchorToHorizontalEdges(of: self, withSpace: 17)
        collectionView.anchorToBottom(of: self.safeAreaLayoutGuide)
    }
    
    @objc
    func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        segmentedControl.indexChanged(newIndex: sender.selectedSegmentIndex)
        self.viewModel.initialFetch()
    }
}

extension ShelfView: ShelfCollectionViewModelDelegate {
    func handleUpdate() {
        self.collectionView.reloadData()
    }
}
