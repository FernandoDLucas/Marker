//
//  NKLocalPersistentenceService.swift
//  NetworkingKit
//
//  Created by Fernando de Lucas da Silva Gomes on 14/12/21.
//  Copyright © 2021 Marker. All rights reserved.
//

import CoreData

class NKLocalPersistenceService<T: NSManagedObject> {

    typealias SingleResultHandler = Result<T, NKLocalPersistenceServiceError>
    typealias MultiResultHandler = Result<[T], NKLocalPersistenceServiceError>

    init(container: NSPersistentContainer) {
        self.persistentContainer = container
        self.context = persistentContainer.viewContext
    }

    let persistentContainer: NSPersistentContainer

    let context: NSManagedObjectContext

    func newObject() -> SingleResultHandler {
        guard let entity = NSEntityDescription.entity(forEntityName: T.entityName, in: context)
        else { return .failure(NKLocalPersistenceServiceError(.inconsistenceOnContext)) }
        return .success(T(entity: entity, insertInto: context))
    }

    func delete(object: T) -> SingleResultHandler {
        context.delete(object)
        do {
            try context.save()
            return .success(object)
        } catch let error {
            return .failure(NKLocalPersistenceServiceError(.failToFetch, underlyingError: error))
        }
    }

    func reset() {
        context.reset()
    }

    func retriveAll() -> MultiResultHandler {
        let fetch = NSFetchRequest<T>(entityName: T.entityName)
        do {
            let objects = try context.fetch(fetch)
            return .success(objects)
        } catch let error {
            return .failure(NKLocalPersistenceServiceError(.failToFetch, underlyingError: error))
        }
    }

    func retrive(predicate: NSPredicate, keyForDescriptor: String) -> SingleResultHandler {
        let fetch = NSFetchRequest<T>(entityName: T.entityName)
        fetch.sortDescriptors = [NSSortDescriptor(key: keyForDescriptor, ascending: true)]
        fetch.predicate  = predicate
        fetch.fetchLimit = 1
        do {
            guard let object = try context.fetch(fetch).first else {
                return .failure(NKLocalPersistenceServiceError(.failToFetch))
            }
            return .success(object)
        } catch let error {
            return .failure(NKLocalPersistenceServiceError(.failToFetch, underlyingError: error))
        }
    }
}

public struct NKLocalPersistenceServiceError: Error {

    let errorType: ErrorType
    let underlyingError: Error?

    init(_ errorType: ErrorType, underlyingError: Error? = nil) {
        self.errorType = errorType
        self.underlyingError = underlyingError
    }

    enum ErrorType {
        case inconsistenceOnContext
        case failToSaveContext
        case failToFetch
    }
}

extension NSManagedObject {
    static var entityName: String {
        return String(describing: self)
    }
}
