import CoreData

final class NKLocalPersistenceService<T: NSManagedObject> {

    typealias SingleResultHandler = Result<T, NKLocalPersistenceServiceError>
    typealias MultiResultHandler = Result<[T], NKLocalPersistenceServiceError>

    private let persistentContainer: NSPersistentContainer
    private let context: NSManagedObjectContext
    
    init(container: NSPersistentContainer) {
        self.persistentContainer = container
        self.context = persistentContainer.viewContext
    }

    func createNewObject() -> SingleResultHandler {
        guard let entity = NSEntityDescription.entity(forEntityName: T.entityName, in: context)
        else { return .failure(NKLocalPersistenceServiceError(.inconsistenceOnContext)) }
        return .success(T(entity: entity, insertInto: context))
    }

    func deleteObject(_ object: T) -> SingleResultHandler {
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

    func retrive(_ keySearch: NKKeySearch) -> SingleResultHandler {
        let fetch = prepareForFetch(keySearch)
        do {
            guard let object = try context.fetch(fetch).first else {
                return .failure(NKLocalPersistenceServiceError(.failToFetch))
            }
            return .success(object)
        } catch let error {
            return .failure(NKLocalPersistenceServiceError(.failToFetch, underlyingError: error))
        }
    }
    
    private func prepareForFetch(_ keySearch: NKKeySearch) -> NSFetchRequest<T>{
        let request = NSFetchRequest<T>(entityName: T.entityName)
        request.sortDescriptors = [NSSortDescriptor(key: keySearch.descriptor, ascending: true)]
        request.predicate  = keySearch.predicate
        request.fetchLimit = keySearch.fetchLimit
        return request
    }
}

extension NSManagedObject {
    static var entityName: String {
        return String(describing: self)
    }
}
