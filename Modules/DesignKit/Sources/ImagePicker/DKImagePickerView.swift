//
//  DKImagePicker.swift
//  DesignKit
//
//  Created by Fernando de Lucas da Silva Gomes on 10/05/22.
//  Copyright © 2022 Marker. All rights reserved.
//

import AnchorKit
import UIKit
import Strategy

protocol DKImagePickerViewProtocol: UIView {
    var delegate: DKImagePickerViewDelegate? { get set }
    func updateImage(_ image: UIImage?)
}

protocol DKImagePickerViewDelegate {
    func didSelectPickerView()
}

public final class DKImagePickerView: UIView {

    var delegate: DKImagePickerViewDelegate?

    private lazy var pickerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo.on.rectangle.angled")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
        return imageView
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
        setupActions()
        self.backgroundColor = UIColor(hex: "#EFEDED")
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DKImagePickerView: ViewCode {
    public func setupViewHierarchy() {
        addSubViews([
            pickerImageView,
            iconImageView
        ])
    }
    
    public func setupConstraints() {
        setupPicker()
        setupIcon()
    }
    
    private func setupPicker() {
        pickerImageView.anchorToEdges(of: self)
    }
    
    private func setupIcon() {
        iconImageView.anchorToTrailing(of: self)
        iconImageView.anchorToBottom(of: self)
        iconImageView.anchorHeight(withSize: 50)
        iconImageView.anchorWidth(withSize: 50)
    }
    
    private func setupActions() {
        self.addTapAction(
            on: self,
            execute: #selector(didSelectPickerView)
        )
    }
    
    @objc
    func didSelectPickerView() {
        delegate?.didSelectPickerView()
    }
}

extension DKImagePickerView: DKImagePickerViewProtocol {
    func updateImage(_ image: UIImage?) {
        self.pickerImageView.image = image
    }
}
