
import Foundation


// MARK: - Network Gateway class
/// Makes all network calls

final class NetworkGateway {
    
    
    
    
    static func downloadSchools(completion: (Error?, Schools?) -> () ) {
        completion(nil, [])
    }
    
    static func downloadScores(completion: (Error?, [TestScores]?) -> () ) {
        completion(nil, [])
    }
    
    
}
