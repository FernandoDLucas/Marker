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

protocol ShelfViewProtocol: UIView {
    var navigationItem: UINavigationItem? { get set }
    var delegate: ShelfViewDelegate? { get set }
    func update()
    func configure()
}

protocol ShelfViewDelegate: AnyObject {
    func didSelectCellWithObjec(object: Comic)
}

final class ShelfView: UIView, ShelfViewProtocol {
    
    private lazy var segmentedControl: DKSegmentedControl = {
        let segmentedControl = DKSegmentedControl(items: ComicStatus.allValues)
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        return segmentedControl
    }()
    
    private let searchController = UISearchController()
    private let viewModel: ShelfCollectionViewModelProtocol
    private let collectionView: ShelfCollectionViewProtocol
    weak var navigationItem: UINavigationItem?
    weak var delegate: ShelfViewDelegate?

    init(
        ViewModel: ShelfCollectionViewModelProtocol,
        collectionView: ShelfCollectionViewProtocol = ShelfCollectionView()
    ) {
        self.viewModel = ViewModel
        self.collectionView = collectionView
        super.init(frame: .zero)
        setupView()
        setupActions()
        self.viewModel.delegate = self
        collectionView.delegate = self.viewModel
        collectionView.dataSource = self.viewModel
        searchController.searchResultsUpdater = self.viewModel
        searchController.delegate = self.viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update() {
        let status = ComicStatus.getCaseInIndex(segmentedControl.selectedSegmentIndex)
        viewModel.fetch(status: status)
    }
    
    func configure() {
        navigationItem?.searchController = searchController
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
    
    func setupActions() {
        self.addLongPressAction(on: self, execute: #selector(didPerformLongPress))
        self.addTapAction(on: self, execute:  #selector(didPerformTap))
    }
    
    @objc
    func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        segmentedControl.indexChanged(newIndex: sender.selectedSegmentIndex)
        let status = ComicStatus.getCaseInIndex(sender.selectedSegmentIndex)
        viewModel.fetch(status: status)
    }
    
    @objc
    func didPerformLongPress() {
        collectionView.presentEditMode()
    }
    
    @objc
    func didPerformTap() {
        collectionView.removeEditMode()
    }
}

extension ShelfView: ShelfCollectionViewModelDelegate {
    func didSelectCellWithObjec(object: Comic) {
        delegate?.didSelectCellWithObjec(object: object)
    }
    
    func handleUpdate() {
        self.collectionView.reloadData()
    }
}
