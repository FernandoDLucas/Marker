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

protocol EditItemViewProtocol: UIView, DKImagePickerDelegate, SelectItemViewDelegate {
    var navigationItem: UINavigationItem? { get set }
    func configure()
}

protocol EditItemViewDelegate: AnyObject {
    func didSelectOptionsField(
        itens: [Any?],
        identifier: SelectableField
    )
}

final class EditItemView: UIView, EditItemViewProtocol {
    
    var navigationItem: UINavigationItem?
    
    var coverImage: UIImage?
    
    weak var delegate: EditItemViewDelegate?
    
    private let viewModel: EditItemViewModel
    
    private lazy var nameTextField = DKTextField(viewModel: .init(title: "Nome"))
    
    private lazy var stepperField = DKStepperField(title: "Volumes")
    
    private lazy var finalNumberTextField = DKTextField(viewModel: .init(title: "VolumeFinal"))
    
    private lazy var typeField = DKSelectorField(
        viewModel: .init(
            title: "Tipo",
            value: "Quadrinho"
        )
    )
    
    private lazy var organizedByField = DKSelectorField(
        viewModel: .init(
            title: "Organizar por",
            value: "Volume"
        )
    )
    
    private lazy var statusField = DKSelectorField(
        viewModel: .init(
            title: "Status",
            value: "Quero ler"
        )
    )
    
    init(
        viewModel: EditItemViewModel
    ) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupView()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        self.navigationItem?.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save,
            target: self,
            action: #selector(didTapSave)
        )
        
        self.navigationItem?.title = "Adicionar"
    }
}

extension EditItemView: ViewCode {
    public func setupViewHierarchy() {
        addSubViews([
            nameTextField,
            stepperField,
            finalNumberTextField,
            typeField,
            organizedByField,
            statusField
        ])
    }
    
    public func setupConstraints() {
        setupTextField()
        setupStepper()
        setupFinalNumberTextField()
        setupTypeField()
        setupOrganizedField()
        setupStatusField()
    }
    
    private func setupActions() {
        typeField.addTapAction(
            on: self,
            execute: #selector(didTapTypeField)
        )
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
    
    private func setupTypeField() {
        typeField.anchorToHorizontalEdges(of: self, withSpace: 17)
        typeField.anchorTopToBottom(of: self.finalNumberTextField)
        typeField.anchorHeight(basedOn: self, withSize: 0.05)
    }
    
    private func setupOrganizedField() {
        organizedByField.anchorToHorizontalEdges(of: self, withSpace: 17)
        organizedByField.anchorTopToBottom(of: self.typeField)
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
            status: ComicStatusInteraction.getIndexFor(statusField.value),
            organizedBy: 1)
        )
    }
    
    @objc
    func didTapTypeField() {
        delegate?.didSelectOptionsField(
            itens: SelectableField.type.options,
            identifier: .type
        )
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
    
    func didSelectItem(_ item: Any?, identifier: SelectableField) {
        switch identifier {
        case .organized:
            self.organizedByField.update(with: item as? String)
        case .status:
            self.statusField.update(with: item as? String)
        case .type:
            self.typeField.update(with: item as? String)
        }
    }
}

extension Optional where Wrapped == String {
    public var safeUnwrap: String {
        return self ?? " "
    }
}


enum SelectableField: String {
    case organized, status, type
    
    var options: [String] {
        switch self {
        case .organized:
            return ["Volume", "Páginas"]
        case .status:
            return  ["Lendo", "Lido", "Quero ler"]
        case .type:
            return ["Quadrinho", "Livro", "Mangá"]
        }
    }
}
