
import Foundation



import CoreData
import CoreLocation

// MARK: DataManager protocol
// defines any object with conformance as able to access data
// any object that makes network or storage calls conforms to this protocol
// individual objects will have a protocol conforming that object to the methods required for access


protocol Viewmodel: AnyObject {
    
    func refresh(completion: () -> ())
    
}



