//
//  ShelfViewCoordinator.swift
//  Marker
//
//  Created by Fernando de Lucas da Silva Gomes on 23/04/22.
//  Copyright © 2022 Marker. All rights reserved.
//

import Strategy
import UIKit

protocol ShelfViewCoordinatorProtocol{
    func callAddScreen()
}

public final class ShelfViewCoordinator: Navigator, ShelfViewCoordinatorProtocol {
    
    public weak var viewController: UIViewController? = nil

    init() {}

    func callAddScreen(){
        let view = EditItemView()
        let controller = EditItemViewController(view: view)
        viewController?.navigationController?.pushViewController(controller, animated: true)
    }

}
