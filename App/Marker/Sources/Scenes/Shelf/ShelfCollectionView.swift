//
//  ShelfCollectionView.swift
//  Marker
//
//  Created by Fernando de Lucas da Silva Gomes on 23/04/22.
//  Copyright © 2022 Marker. All rights reserved.
//

import Foundation
import UIKit
import DesignKit

protocol ShelfCollectionViewProtocol: UICollectionView {
    func presentEditMode()
    func removeEditMode()
}
class ShelfCollectionView: UICollectionView, ShelfCollectionViewProtocol {
    
    init(
        with layout: UICollectionViewFlowLayout = DKComicCollectionViewLayout()
    ) {
        layout.scrollDirection = .vertical
        super.init(frame: .zero, collectionViewLayout: layout)
        self.register(ShelfCollectionViewCell.self, forCellWithReuseIdentifier: ShelfCollectionViewCell.reuseIdentifier)
        self.backgroundColor = .clear
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func presentEditMode() {
        self.visibleCells.forEach {
            guard let cell = $0 as? ShelfCollectionViewCellProtocol else { return }
            cell.presentEditMode()
        }
    }
    
    func removeEditMode() {
        self.visibleCells.forEach {
            guard let cell = $0 as? ShelfCollectionViewCellProtocol else { return }
            cell.removeEditMode()
        }
    }
}
