//
//  ShelfViewController.swift
//  Marker
//
//  Created by Fernando de Lucas da Silva Gomes on 13/03/22.
//  Copyright © 2022 Marker. All rights reserved.
//

import UIKit

class ShelfViewController: UIViewController {

    typealias CustomView = ShelfView
    private let customView: CustomView
    private let coordinator: ShelfViewCoordinatorProtocol

    init(
        customView: CustomView,
        coordinator: ShelfViewCoordinatorProtocol
    ) {
        self.customView = customView
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
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.title = "Marker"
    }

    func addNavigationButton() {
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = .init(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonClicked)
        )
    }
    
    @objc func addButtonClicked() {
        self.coordinator.callAddScreen()
    }
    
    
}
