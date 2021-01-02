
import CoreData
import CoreLocation

// MARK: DataManager protocol
// defines any object with conformance as able to access data
// any object that makes network or storage calls conforms to this protocol
// individual objects will have a protocol conforming that object to the methods required for access

protocol Viewmodel: Hashable, Identifiable {
    var uuid: UUID { get }
    var id: String { get }
}

extension Viewmodel {

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    func compare<T: Identifiable>(_ lhs: T, against rhs: T) -> Bool {
        return true
    }
    
}
