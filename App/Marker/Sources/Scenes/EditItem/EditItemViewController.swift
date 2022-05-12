//
//  AddItemViewController.swift
//  Marker
//
//  Created by Fernando de Lucas da Silva Gomes on 24/04/22.
//  Copyright © 2022 Marker. All rights reserved.
//

import Foundation
import UIKit
import DesignKit

final class EditItemViewController: UIViewController {
    
    typealias CustomView = EditItemViewProtocol
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
    
    override func viewDidLoad() {
        customView.navigationItem = self.navigationItem
        customView.configure()
        let child = DKImagePicker()
        child.delegate = customView
        addChild(child)
        view.addSubview(child.view)
        child.view.anchorToHorizontalEdges(of: self.view, withSpace: 17)
        child.view.anchorToTop(of: self.view)
        child.view.anchorHeight(basedOn: self.view, withSize: 0.18)
        child.willMove(toParent: self)
    }
}
