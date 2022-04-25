//
//  AddItemViewController.swift
//  Marker
//
//  Created by Fernando de Lucas da Silva Gomes on 24/04/22.
//  Copyright © 2022 Marker. All rights reserved.
//

import Foundation
import UIKit

final class EditItemViewController: UIViewController {
    
    typealias CustomView = EditItemView
    private let customView: CustomView
    
    init(
        view: CustomView
    ) {
        self.customView = view
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = customView
    }
}
