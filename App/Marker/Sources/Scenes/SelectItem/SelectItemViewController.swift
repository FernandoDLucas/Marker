//
//  SelectItemViewController.swift
//  Marker
//
//  Created by Fernando de Lucas da Silva Gomes on 14/05/22.
//  Copyright © 2022 Marker. All rights reserved.
//

import UIKit
import DesignKit

final class SelectItemViewController: UIViewController {
    
    typealias CustomView = SelectItemViewProtocol
    private let customView: CustomView
    private let coordinator: ShelfViewCoordinatorProtocol
    
    init(
        view: CustomView,
        coordinator: ShelfViewCoordinatorProtocol
    ) {
        self.customView = view
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        self.customView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = customView
    }
    
}

extension SelectItemViewController: SelectItemViewDelegate {
    func didSelectItem(
        _ item: Any?,
        identifier: SelectableField
    ) {
        coordinator.popSelectView(
            item: item,
            identifier: identifier
        )
    }
}
