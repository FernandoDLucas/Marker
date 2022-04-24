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

class ShelfCollectionView: UICollectionView {
    
    init(
        with layout: UICollectionViewFlowLayout = DKComicCollectionViewLayout()
    ) {
        layout.scrollDirection = .vertical
        super.init(frame: .zero, collectionViewLayout: layout)
        self.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        self.backgroundColor = .clear
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
