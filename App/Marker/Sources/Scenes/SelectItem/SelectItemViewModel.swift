//
//  SelectItemViewModel.swift
//  Marker
//
//  Created by Fernando de Lucas da Silva Gomes on 14/05/22.
//  Copyright © 2022 Marker. All rights reserved.
//

import Strategy
import UIKit

protocol SelectItemViewModelProtocol: TableViewModelProtocol {}

protocol SelectItemViewDelegate: AnyObject {
    func didSelectItem(_ item: Any?, identifier: SelectableField)
}

final class SelectItemViewModel: NSObject, SelectItemViewModelProtocol {
    
    private let itens: [Any?]
    private let identifier: SelectableField
    weak var delegate: SelectItemViewDelegate?

    init(
        itens: [Any?],
        identifier: SelectableField
    ) {
        self.itens = itens
        self.identifier = identifier
    }
}

extension SelectItemViewModel: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itens.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SelectItemTableViewCell.reuseIdentifier) as? SelectItemTableViewCell else {
            fatalError("Cell must be setup")
        }
        let text = itens[indexPath.row] as? String
        cell.fill(with: text)
        cell.selectionStyle = .none
        cell.separatorInset = .zero
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        delegate?.didSelectItem(itens[indexPath.row], identifier: identifier)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
}
