//
//  NKLocalPersistenceResolver.swift
//  NetworkingKit
//
//  Created by Fernando de Lucas da Silva Gomes on 03/03/22.
//  Copyright © 2022 Marker. All rights reserved.
//

import CoreData

public final class NKLocalPersistenceConfigurator{
    
    private let container = NSPersistentContainer(name: "Marker")

    public init() {}

    public func execute() -> NKComicRepository{
        let service = NKLocalPersistenceService<Comic>(container: container)
        return .init(service: service)
    }
}
