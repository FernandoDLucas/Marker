import CoreData

final class NKLocalPersistenceService<T: NSManagedObject> {


    private let persistentContainer: NSPersistentContainer
    private let context: NSManagedObjectContext
    
    init(container: NSPersistentContainer) {
        self.persistentContainer = container
        self.context = container.viewContext
    }

    func createNewObject() throws -> T{
        guard let entity = NSEntityDescription.entity(
            forEntityName: T.entityName,
            in: context
        )
        else { throw NKLocalPersistenceServiceError(.inconsistenceOnContext) }
        return T(entity: entity, insertInto: context)
    }

    func deleteObject(_ object: T) throws -> T {
        context.delete(object)
        do {
            try context.save()
            return object
        } catch let error {
            throw NKLocalPersistenceServiceError(.failToFetch, underlyingError: error)
        }
    }

    func reset() {
        context.reset()
    }
    
    func save() throws {
        try context.save()
    }

    func retriveAll() throws -> [T] {
        let fetch = NSFetchRequest<T>(entityName: T.entityName)
        do {
            let objects = try context.fetch(fetch)
            return objects
        } catch let error {
            throw NKLocalPersistenceServiceError(.failToFetch, underlyingError: error)
        }
    }

    func retrive(_ keySearch: NKKeySearch) throws -> T {
        let fetch = prepareForFetch(keySearch)
        do {
            guard let object = try context.fetch(fetch).first else {
                throw NKLocalPersistenceServiceError(.failToFetch)
            }
            return object
        } catch let error {
            throw NKLocalPersistenceServiceError(.failToFetch, underlyingError: error)
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
