//
//  ShelfCollectionViewCell.swift
//  Marker
//
//  Created by Fernando de Lucas da Silva Gomes on 25/04/22.
//  Copyright © 2022 Marker. All rights reserved.
//

import UIKit
import AnchorKit
import Strategy

final class ShelfCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: ShelfCollectionViewCell.self)
    
    private lazy var imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.center = self.center
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with image: UIImage?) {
        imageView.image = image
    }
}

extension ShelfCollectionViewCell: ViewCode {
    public func setupViewHierarchy() {
        addSubViews([
            imageView
        ])
    }
    
    public func setupConstraints() {
        imageView.anchorToEdges(of: self)
    }
}
