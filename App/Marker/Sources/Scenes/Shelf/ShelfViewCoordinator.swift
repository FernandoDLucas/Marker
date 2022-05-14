//
//  ShelfViewCoordinator.swift
//  Marker
//
//  Created by Fernando de Lucas da Silva Gomes on 23/04/22.
//  Copyright © 2022 Marker. All rights reserved.
//

import Strategy
import UIKit
import NetworkingKit

protocol ShelfViewCoordinatorProtocol{
    func callAddScreen()
    func callSelectItemScreen(
        itens: [Any?],
        identifier: SelectableField,
        delegate: SelectItemViewDelegate?
    )
}

public final class ShelfViewCoordinator: ShelfViewCoordinatorProtocol {
    
    public weak var mainViewController: UIViewController?
    private weak var editViewController: UIViewController?

    init() {}

    func callAddScreen() {
        let repository = NKLocalPersistenceResolver().createComicRepository()
        let viewModel = EditItemViewModel(repository: repository)
        let view = EditItemView(viewModel: viewModel)
        let controller = EditItemViewController(view: view, coordinator: self)
        view.delegate = controller
        self.editViewController = controller
        mainViewController?.navigateTo(controller)
    }
    
    func callSelectItemScreen(
        itens: [Any?],
        identifier: SelectableField,
        delegate: SelectItemViewDelegate?
    ) {
        let viewModel = SelectItemViewModel(itens: itens, identifier: identifier)
        let view = SelectItemView(viewModel: viewModel)
        let controller = SelectItemViewController(view: view)
        viewModel.delegate = delegate
        editViewController?.navigateTo(controller)
    }
}
