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
    
    typealias CustomView = SelectItemView
    private let customView: SelectItemView
    
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
    
    override func viewDidLoad() {
        customView.tableView.reloadData()
    }
}
