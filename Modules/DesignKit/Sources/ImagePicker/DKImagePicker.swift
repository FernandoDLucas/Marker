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
import Utils

typealias PickerDelegate = UIImagePickerControllerDelegate & UINavigationControllerDelegate

public protocol DKImagePickerDelegate: AnyObject {
    func didSelectImage(_ image: UIImage)
}

public final class DKImagePicker: UIViewController {
    
    let customView: DKImagePickerViewProtocol

    let imagePicker = UIImagePickerController()
    
    public var delegate: DKImagePickerDelegate?

    override public func loadView() {
        view = customView
    }
    
    public init() {
        self.customView = DKImagePickerView()
        super.init(nibName: nil, bundle: nil)
        imagePicker.delegate = self
        customView.delegate = self
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func updateImage(_ image: UIImage?) {
        self.customView.updateImage(image)
    }
}

extension DKImagePicker: PickerDelegate {
    public func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        
        guard let imageInfo = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        let image = imageInfo.fixedOrientation
        customView.updateImage(image)
        delegate?.didSelectImage(image)
        dismiss(animated: true, completion: nil)
    }
}

extension DKImagePicker: DKImagePickerViewDelegate {
    func didSelectPickerView() {
        self.imagePicker.allowsEditing = false
        self.imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
}
