//
//  DKSelectorField.swift
//  DesignKit
//
//  Created by Fernando de Lucas da Silva Gomes on 10/05/22.
//  Copyright © 2022 Marker. All rights reserved.
//

import Foundation
import UIKit
import Strategy
import AnchorKit

public protocol DKSelectorFieldDelegate {
    func didSelectField()
}
public final class DKSelectorField: UIView {
    
    public struct ViewModel {
        let title: String
        let value: String
        let imageAcessory: UIImage?
        
        public init(
            title: String,
            value: String,
            imageAcessory: UIImage? = UIImage(systemName: "chevron.right")
        ) {
            self.title = title
            self.value = value
            self.imageAcessory = imageAcessory
        }
    }
    
    public var delegate: DKSelectorFieldDelegate?

    private lazy var identifierLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var valueLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .right
        return label
    }()
    
    private lazy var imageAcessory: UIImageView = {
       let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.tintColor = .gray
        return image
    }()

    public init(viewModel: ViewModel) {
        super.init(frame: .zero)
        self.backgroundColor = .systemBackground
        setupView()
        setupActions()
        configure(with: viewModel)
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: ViewModel) {
        self.identifierLabel.text = viewModel.title
        self.valueLabel.text = viewModel.value
        self.imageAcessory.image = viewModel.imageAcessory
    }
}

extension DKSelectorField: ViewCode {
    public func setupViewHierarchy() {
        addSubViews([
            identifierLabel,
            valueLabel,
            imageAcessory
        ])
        self.addBottomBorder(of: 1)
    }
    
    public func setupConstraints() {
        setupIdentifier()
        setupImage()
        setupValue()
    }
    
    func setupActions() {
        self.addTapAction(
            on: self,
            execute: #selector(didSelect)
        )
    }
    
    private func setupIdentifier() {
        identifierLabel.anchorToVerticalEdges(of: self)
        identifierLabel.anchorToLeading(of: self)
        identifierLabel.anchorWidth(basedOn: self, withSize: 0.5)
    }
    
    private func setupImage() {
        imageAcessory.anchorToVerticalEdges(of: self, withSpace: 8)
        imageAcessory.anchorToTrailing(of: self)
        imageAcessory.anchorWidth(basedOn: self, withSize: 0.15)
    }
    
    
    private func setupValue() {
        valueLabel.anchorToVerticalEdges(of: self)
        valueLabel.anchorTrailingToLeading(of: imageAcessory)
        valueLabel.anchorWidth(basedOn: self, withSize: 0.35)
    }
    
    @objc
    func didSelect() {
        delegate?.didSelectField()
    }
}
