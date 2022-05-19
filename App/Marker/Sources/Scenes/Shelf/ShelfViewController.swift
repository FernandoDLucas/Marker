//
//  ShelfViewController.swift
//  Marker
//
//  Created by Fernando de Lucas da Silva Gomes on 13/03/22.
//  Copyright © 2022 Marker. All rights reserved.
//

import UIKit

protocol ShelfViewControllerProtocol: UIViewController {
    func didFinishPresentEditScreen()
}

class ShelfViewController: UIViewController,ShelfViewControllerProtocol {

    typealias CustomView = ShelfViewProtocol
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
        self.title = "Sua Coleção"
        self.setupNavigationBar(navColor: .clear, barColor: .black)
        self.navigationItem.rightBarButtonItem = .init(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(callAdd)
        )
        customView.update()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @objc
    func callAdd() {
        coordinator.callAddScreen()
    }
    
    func didFinishPresentEditScreen() {
        customView.update()
    }

}
