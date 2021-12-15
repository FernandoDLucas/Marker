//
//  MainCoordinator.swift
//  Marker
//
//  Created by Fernando de Lucas da Silva Gomes on 13/12/21.
//  Copyright © 2021 Marker. All rights reserved.
//

import UIKit

protocol Coordinator {
    func start(window: UIWindow?)
}

final class MainCoordinator: Coordinator {

    var initialController: ShelfViewController

    init() {
        self.initialController = ShelfViewController()
    }

    func start(window: UIWindow?) {
        let navigationController = UINavigationController(rootViewController: initialController)
        navigationController.view.backgroundColor = .white
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
