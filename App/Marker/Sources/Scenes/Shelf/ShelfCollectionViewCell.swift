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
import DesignKit

protocol ShelfCollectionViewCellProtocol: UICollectionViewCell {
    func presentEditMode()
    var isPresentingEditMode: Bool {get}
    func removeEditMode()
}

final class ShelfCollectionViewCell: UICollectionViewCell, ShelfCollectionViewCellProtocol {
    
    var isPresentingEditMode: Bool = false

    static let reuseIdentifier = String(describing: ShelfCollectionViewCell.self)
    
    private let animator: DSAnimationProtocol
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.center = self.center
        return imageView
    }()
    
    private lazy var deleteIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "minus.circle.fill")
        imageView.tintColor = .red
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 2
        imageView.center = self.center
        imageView.isHidden = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        self.animator = DSAnimationResolver().resolveAnimation(.shakingAnimation)
        super.init(frame: frame)
        self.animator.viewForAnimation(self)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with image: UIImage?) {
        imageView.image = image
    }
    
    func presentEditMode() {
        isPresentingEditMode = true
        deleteIcon.isHidden = false
        animator.animate()
    }
    
    func removeEditMode() {
        isPresentingEditMode = false 
        deleteIcon.isHidden = true
        animator.stop()
    }
}

extension ShelfCollectionViewCell: ViewCode {
    public func setupViewHierarchy() {
        addSubViews([
            imageView,
            deleteIcon
        ])
    }
    
    public func setupConstraints() {
        imageView.anchorToEdges(of: self)
        deleteIcon.anchorToTop(of: self)
        deleteIcon.anchorToLeading(of: self)
        deleteIcon.anchorHeight(basedOn: self, withSize: 0.2)
        deleteIcon.anchorWidth(basedOn: self, withSize: 0.2)
    }
}
