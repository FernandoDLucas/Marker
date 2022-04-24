//
//  Navigator.swift
//  Strategy
//
//  Created by Fernando de Lucas da Silva Gomes on 23/04/22.
//  Copyright © 2022 Marker. All rights reserved.
//

import UIKit


public protocol Navigator {
    var viewController: UIViewController? { get }
}

extension Navigator {
    func navigateTo(_ controller: UIViewController) {
        self.viewController?.navigationController?.pushViewController(controller, animated: true)
    }
}
