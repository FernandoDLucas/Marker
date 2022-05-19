//
//  Navigator.swift
//  Strategy
//
//  Created by Fernando de Lucas da Silva Gomes on 23/04/22.
//  Copyright © 2022 Marker. All rights reserved.
//

import UIKit


public protocol Navigator {
    func navigateTo(_ controller: UIViewController)
    func pop()
}

extension UIViewController: Navigator {
    public func navigateTo(_ controller: UIViewController) {
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    public func pop() {
        self.navigationController?.popViewController(animated: true)
    }
}
