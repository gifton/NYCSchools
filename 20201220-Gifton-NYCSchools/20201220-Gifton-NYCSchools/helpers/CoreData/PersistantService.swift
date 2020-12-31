

import CoreData

// container for loading application into Core data context
func createSchoolsContainer(completion: @escaping (NSPersistentContainer) -> Void) {
    let container = NSPersistentContainer(name: "SchoolDB")
    container.loadPersistentStores { (_, error) in
        guard error == nil else { fatalError("failed to load store: \(error!)")}
        DispatchQueue.main.async {
            completion(container)
        }
    }
}

class PersistantContainer {
    
    static var store: NSPersistentContainer?
    static func createSchoolsContainer(completion: @escaping (NSPersistentContainer) -> Void) {
        if store != nil {
            completion(store!)
        } else {
            let container = NSPersistentContainer(name: "SchoolDB")
            container.loadPersistentStores { (_, error) in
                guard error == nil else { fatalError("failed to load store: \(error!)")}
                DispatchQueue.main.async {
                    completion(container)
                }
                store = container
            }
        }
        
    }
}

protocol PersistedObject: NSManagedObject {
    var typeTitle: String { get }
}

extension PersistedObject {
    var computedType: PersistedObjectType? {
        return PersistedObjectType(rawValue: typeTitle)
    }
} 

enum PersistedObjectType: String {
    case school = "Thought"
    case testScore = "Canvas Block"
}
