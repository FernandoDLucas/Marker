//
//  SelectItemTableViewCell.swift
//  Marker
//
//  Created by Fernando de Lucas da Silva Gomes on 14/05/22.
//  Copyright © 2022 Marker. All rights reserved.
//

import AnchorKit
import UIKit
import Strategy

final class SelectItemTableViewCell: UITableViewCell {

    static let reuseIdentifier = String(describing: ShelfCollectionViewCell.self)

    private lazy var label: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    func fill(with text: String?) {
        setupView()
        label.text = text
    }
}

extension SelectItemTableViewCell: ViewCode {
    func setupViewHierarchy() {
        addSubview(label)
    }
    
    func setupConstraints() {
        label.anchorToVerticalEdges(of: self, withSpace: 3)
        label.anchorToLeading(of: self, constant: 17)
    }
    
}
