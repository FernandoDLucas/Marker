//
//  NKLocalPersistenceResolver.swift
//  NetworkingKit
//
//  Created by Fernando de Lucas da Silva Gomes on 03/03/22.
//  Copyright © 2022 Marker. All rights reserved.
//

import CoreData

public final class NKLocalPersistenceResolver{
    
    private let container: NSPersistentContainer
    
    public static let shared = NKLocalPersistenceResolver()

    public init() {
        container = CoreDataStack().persistentContainer
    }

    public func execute() -> NKComicRepository{
        let service = NKLocalPersistenceService<Comic>(container: container)
        return .init(service: service)
    }
}
