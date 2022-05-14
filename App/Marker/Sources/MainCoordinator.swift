//
//  MainCoordinator.swift
//  Marker
//
//  Created by Fernando de Lucas da Silva Gomes on 13/03/22.
//  Copyright © 2022 Marker. All rights reserved.
//

import UIKit
import CoreData
import NetworkingKit

protocol Coordinator {
    func start(window: UIWindow?)
}

final class MainCoordinator: Coordinator {

    typealias InitialController = ShelfViewController

    init() {}

    func start(window: UIWindow?) {
        let initialController = resolveInitialController()
        let navigationController = UINavigationController(rootViewController: initialController)
        navigationController.view.backgroundColor = .white
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func resolveInitialController() -> InitialController {
        let repository = NKLocalPersistenceResolver().createComicRepository()
        let viewModel = ShelfCollectionViewModel(repository: repository)
        let view = ShelfView(ViewModel: viewModel)
        let coordinator = ShelfViewCoordinator()
        let controller = ShelfViewController(customView: view, coordinator: coordinator)
        view.navigationItem = controller.navigationItem
        coordinator.mainViewController = controller
        return controller
    }
}
