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
    
    
    public static func fixture() -> Self{
        return .init(
            currentProgress: 12,
            author: "Teste",
            total: 15,
            cover: nil,
            title: "Teste",
            status: 1,
            organizedBy: 1
        )
    }
}
