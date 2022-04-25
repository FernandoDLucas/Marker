//
//  NKLocalPersistenceService.swift
//  NetworkingKit
//
//  Created by Fernando de Lucas da Silva Gomes on 03/03/22.
//  Copyright © 2022 Marker. All rights reserved.
//

import Foundation
import CoreData

public protocol NKComicRepositoryProtocol {
    func retrieveAll() throws -> [Comic]
    func create(
        _ comicDTO: ComicDTO
    ) throws -> Comic
}

public final class NKComicRepository: NKComicRepositoryProtocol{
    
    private let service: NKLocalPersistenceService<Comic>

    init(
        service: NKLocalPersistenceService<Comic>
    ) {
        self.service = service
    }
    
    public func retrieveAll() throws -> [Comic] {
        let comics = try service.retriveAll()
        return comics
    }
    
    public func create(
        _ comicDTO: ComicDTO
    ) throws -> Comic {
        let newComic = try service.createNewObject()
        updateAttributes(newComic, basedOn: comicDTO)
        try service.save()
        return newComic
    }
    
    private func updateAttributes(
        _ comic: Comic,
        basedOn DTO: ComicDTO
    ) {
        comic.author = DTO.author
        comic.cover = DTO.cover
        comic.currentProgress = Int32(DTO.currentProgress)
        comic.organizedBy = Int16(DTO.organizedBy)
        comic.status = Int16(DTO.status)
        comic.title = DTO.title
        comic.total = Int32(DTO.total)
    }
}
