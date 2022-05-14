//
//  SelectItemView.swift
//  Marker
//
//  Created by Fernando de Lucas da Silva Gomes on 14/05/22.
//  Copyright © 2022 Marker. All rights reserved.
//

import AnchorKit
import UIKit
import Strategy

final class SelectItemView: UIView {
        
    private let viewModel: SelectItemViewModelProtocol

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .singleLine
        tableView.allowsMultipleSelection = false
        tableView.register(
            SelectItemTableViewCell.self,
            forCellReuseIdentifier: SelectItemTableViewCell.reuseIdentifier
        )
        return tableView
    }()
    
    init(
        viewModel: SelectItemViewModelProtocol
    ) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        tableView.delegate = self.viewModel
        tableView.dataSource = self.viewModel
        setupView()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SelectItemView: ViewCode {
    func setupViewHierarchy() {
        addSubViews([tableView])
    }
    
    func setupConstraints() {
        tableView.anchorToEdges(of: self)
    }
    
}
