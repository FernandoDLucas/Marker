//
//  EditItemViewModel.swift
//  Marker
//
//  Created by Fernando de Lucas da Silva Gomes on 11/05/22.
//  Copyright © 2022 Marker. All rights reserved.
//

import NetworkingKit

public protocol EditItemViewModelProtocol {
    func saveItem(_ item: ComicDTO) throws
}

final class EditItemViewModel: EditItemViewModelProtocol{
    
    private let repository: NKComicRepositoryProtocol
    
    init(
        repository: NKComicRepositoryProtocol
    ) {
        self.repository = repository
    }
    
    func saveItem(_ item: ComicDTO) throws {
        let _ = try repository.create(item)
    }
}

enum EditItemViewModelError {
    case couldNotSave
}
