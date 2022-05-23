//
//  AddItemViewController.swift
//  Marker
//
//  Created by Fernando de Lucas da Silva Gomes on 24/04/22.
//  Copyright © 2022 Marker. All rights reserved.
//

import Foundation
import UIKit
import DesignKit

protocol EditItemViewControllerProtocol: UIViewController {
    func updateField(
        item: Any?,
        identifier: SelectableField
    )
}

final class EditItemViewController: UIViewController, EditItemViewControllerProtocol {
    
    typealias CustomView = EditItemViewProtocol
    private let customView: CustomView
    private let coordinator: ShelfViewCoordinatorProtocol
    
    init(
        view: CustomView,
        coordinator: ShelfViewCoordinatorProtocol
    ) {
        self.customView = view
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = customView
    }
    
    override func viewDidLoad() {
        customView.navigationItem = self.navigationItem
        customView.configure()
        addChildPickerView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = false 
    }
    
    func addChildPickerView() {
        let child = DKImagePicker()
        child.delegate = customView
        addChild(child)
        view.addSubview(child.view)
        child.view.anchorToHorizontalEdges(of: self.view, withSpace: 17)
        child.view.anchorToTop(of: self.view.safeAreaLayoutGuide)
        child.view.anchorHeight(basedOn: self.view, withSize: 0.18)
        child.willMove(toParent: self)
    }
    
    func updateField(
        item: Any?,
        identifier: SelectableField
    ) {
        customView.updateField(item: item, identifier: identifier)
    }
}

extension EditItemViewController: EditItemViewDelegate {
    func didSelectOptionsField(
        itens: [Any?],
        identifier: SelectableField
    ) {
        coordinator.callSelectItemScreen(
            itens: itens,
            identifier: identifier
        )
    }
    
    func didSavedItem() {
        coordinator.popEditView()
    }
}
