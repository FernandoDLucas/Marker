//
//  AddItemView.swift
//  Marker
//
//  Created by Fernando de Lucas da Silva Gomes on 24/04/22.
//  Copyright © 2022 Marker. All rights reserved.
//

import DesignKit
import UIKit
import Strategy
import NetworkingKit
import Utils

protocol EditItemViewProtocol: UIView, DKImagePickerDelegate {
    var navigationItem: UINavigationItem? { get set }
    var imagePicker: DKImagePicker { get }
    func configureNavigation()
    func updateField(
        item: Any?,
        identifier: SelectableField
    )
}

protocol EditItemViewDelegate: AnyObject {
    func didSelectOptionsField(
        itens: [Any?],
        identifier: SelectableField
    )
    func didSavedItem()
}

final class EditItemView: UIView, EditItemViewProtocol {
    
    var navigationItem: UINavigationItem?
    
    var coverImage: UIImage?
    
    var imagePicker = DKImagePicker()
    
    weak var delegate: EditItemViewDelegate?
    
    private let viewModel: EditItemViewModel
    
    private lazy var nameTextField = DKTextField(title: "Nome")
    
    private lazy var stepperField = DKStepperField(title: "Volumes")
    
    private lazy var finalNumberTextField = DKTextField(title: "Volume Final")
    
    private lazy var organizedByField = DKSelectorField(
        viewModel: .init(
            title: "Organizar por",
            value: "Volume"
        )
    )
    
    private lazy var statusField = DKSelectorField(
        viewModel: .init(
            title: "Status",
            value: "Quero Ler"
        )
    )
    
    init(
        viewModel: EditItemViewModel
    ) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        imagePicker.delegate = self
        setupView()
        setupActions()
        updateWithObject()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureNavigation() {
        self.navigationItem?.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save,
            target: self,
            action: #selector(didTapSave)
        )
        
        self.navigationItem?.title = "Adicionar"
    }
    
    func updateWithObject() {
        if let comic = viewModel.retrieveObject() {
            if let data = comic.cover {
                let image = UIImage(data: data)
                self.imagePicker.updateImage(image)
            }
            self.nameTextField.configure(with: comic.title)
        }
    }
}

extension EditItemView: ViewCode {
    public func setupViewHierarchy() {
        addSubViews([
            nameTextField,
            stepperField,
            finalNumberTextField,
            organizedByField,
            statusField
        ])
    }
    
    public func setupConstraints() {
        setupTextField()
        setupStepper()
        setupFinalNumberTextField()
        setupOrganizedField()
        setupStatusField()
    }
    
    private func setupActions() {
        organizedByField.addTapAction(
            on: self,
            execute: #selector(didTapOrganizedField)
        )
        statusField.addTapAction(
            on: self,
            execute: #selector(didTapStatusField)
        )
    }

    private func setupTextField() {
        nameTextField.anchorToHorizontalEdges(of: self, withSpace: 17)
        nameTextField.anchorToTop(of: self, constant: 0.22)
        nameTextField.anchorHeight(basedOn: self, withSize: 0.05)
    }
    
    private func setupStepper() {
        stepperField.anchorToHorizontalEdges(of: self, withSpace: 17)
        stepperField.anchorTopToBottom(of: self.nameTextField)
        stepperField.anchorHeight(basedOn: self, withSize: 0.05)
    }
    
    private func setupFinalNumberTextField() {
        finalNumberTextField.anchorToHorizontalEdges(of: self, withSpace: 17)
        finalNumberTextField.anchorTopToBottom(of: self.stepperField)
        finalNumberTextField.anchorHeight(basedOn: self, withSize: 0.05)
    }
    
    private func setupOrganizedField() {
        organizedByField.anchorToHorizontalEdges(of: self, withSpace: 17)
        organizedByField.anchorTopToBottom(of: self.finalNumberTextField)
        organizedByField.anchorHeight(basedOn: self, withSize: 0.05)
    }
    
    private func setupStatusField() {
        statusField.anchorToHorizontalEdges(of: self, withSpace: 17)
        statusField.anchorTopToBottom(of: self.organizedByField)
        statusField.anchorHeight(basedOn: self, withSize: 0.05)
    }
    
    @objc
    func didTapSave() {
        try? viewModel.saveItem(.init(
            currentProgress: stepperField.value,
            author: nil,
            total: finalNumberTextField.value,
            cover: coverImage?.pngData(),
            title: nameTextField.text.safeUnwrap,
            status: ComicStatus.getIndexFor(statusField.value),
            organizedBy: ComicOrganizedBy.getIndexFor(organizedByField.value)
        )
    )

        delegate?.didSavedItem()
    }
    
    @objc
    func didTapOrganizedField() {
        delegate?.didSelectOptionsField(
            itens: SelectableField.organized.options,
            identifier: .organized
        )
    }
    
    @objc
    func didTapStatusField() {
        delegate?.didSelectOptionsField(
            itens: SelectableField.status.options,
            identifier: .status
        )
    }
}

extension EditItemView {
    func didSelectImage(_ image: UIImage) {
        self.coverImage = image
    }
    
    func updateField(
        item: Any?,
        identifier: SelectableField
    ) {
        switch identifier {
        case .organized:
            self.organizedByField.update(with: item as? String)
        case .status:
            self.statusField.update(with: item as? String)
        }
    }
}

extension Optional where Wrapped == String {
    public var safeUnwrap: String {
        return self ?? " "
    }
}


enum SelectableField: String {
    case organized, status
    
    var options: [String] {
        switch self {
        case .organized:
            return ComicOrganizedBy.allValues
        case .status:
            return  ComicStatus.allValues
        }
    }
}
