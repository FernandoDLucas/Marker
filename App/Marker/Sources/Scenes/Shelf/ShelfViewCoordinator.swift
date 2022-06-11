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
    func callEditScreen(object: Comic?)
    func callSelectItemScreen(
        itens: [Any?],
        identifier: SelectableField
    )
    func popEditView()
    func popSelectView(
        item: Any?,
        identifier: SelectableField
    )
}

public final class ShelfViewCoordinator: ShelfViewCoordinatorProtocol {
    
    weak var mainViewController: ShelfViewControllerProtocol?
    private weak var editViewController: EditItemViewControllerProtocol?
    private weak var selectViewController: UIViewController?

    init() {}

    func callEditScreen(object: Comic?) {
        let repository = NKLocalPersistenceResolver().createComicRepository()
        let viewModel = EditItemViewModel(repository: repository, comic: object)
        let view = EditItemView(viewModel: viewModel)
        let controller = EditItemViewController(view: view, coordinator: self)
        view.delegate = controller
        self.editViewController = controller
        mainViewController?.navigateTo(controller)
    }
    
    func callSelectItemScreen(
        itens: [Any?],
        identifier: SelectableField
    ) {
        let viewModel = SelectItemViewModel(itens: itens, identifier: identifier)
        let view = SelectItemView(viewModel: viewModel)
        let controller = SelectItemViewController(view: view, coordinator: self)
        self.selectViewController = controller
        editViewController?.navigateTo(controller)
    }
        
    func popEditView() {
        self.editViewController?.pop()
        self.mainViewController?.didFinishPresentEditScreen()
    }
    
    func popSelectView(
        item: Any?,
        identifier: SelectableField
    ) {
        self.editViewController?.updateField(item: item, identifier: identifier)
        self.selectViewController?.pop()
    }
}
