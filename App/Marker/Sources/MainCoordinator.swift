//
//  MainCoordinator.swift
//  Marker
//
//  Created by Fernando de Lucas da Silva Gomes on 13/03/22.
//  Copyright © 2022 Marker. All rights reserved.
//

import UIKit
import CoreData

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
