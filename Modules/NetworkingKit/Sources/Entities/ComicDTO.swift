//
//  ComicDTO.swift
//  NetworkingKit
//
//  Created by Fernando de Lucas da Silva Gomes on 10/04/22.
//  Copyright © 2022 Marker. All rights reserved.
//

import CoreData

public struct ComicDTO {
    public var currentProgress: Int
    public var author: String?
    public var total: Int
    public var cover: Data?
    public var title: String
    public var status: Int
    public var organizedBy: Int
    
    
    public init(
        currentProgress: Int,
        author: String? = nil,
        total: Int,
        cover: Data? = nil,
        title: String,
        status: Int,
        organizedBy: Int
    ) {
        self.currentProgress = currentProgress
        self.author = author
        self.total = total
        self.cover = cover
        self.title = title
        self.status = status
        self.organizedBy = organizedBy
    }
}

extension ComicDTO {
    public static func fixture(
        cover: Data? = nil
    ) -> Self{
        return .init(
            currentProgress: 12,
            author: "Teste",
            total: 15,
            cover: cover,
            title: "Teste",
            status: 1,
            organizedBy: 1
        )
    }
}
