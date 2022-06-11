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
    func retrieveObject() -> Comic?
}

final class EditItemViewModel: EditItemViewModelProtocol{
    
    private let repository: NKComicRepositoryProtocol
    private let comic: Comic?
    
    init(
        repository: NKComicRepositoryProtocol,
        comic: Comic? = nil 
    ) {
        self.repository = repository
        self.comic = comic
    }
    
    func saveItem(_ item: ComicDTO) throws {
        let _ = try repository.create(item)
    }
    
    func retrieveObject() -> Comic? {
        self.comic
    }
}

enum EditItemViewModelError {
    case couldNotSave
}
