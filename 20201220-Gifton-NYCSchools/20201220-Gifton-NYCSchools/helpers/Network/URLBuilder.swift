


import Foundation


extension URL {
    struct Endpoints {
        static var allSchools: URL {
            return URL(string: rawEndpoint.allSchools.rawValue)!
        }
        static var testScores: URL {
            return URL(string: rawEndpoint.testScores.rawValue)!
        }
    }
    
    
    private enum rawEndpoint: String {
        case allSchools = "https://data.cityofnewyork.us/resource/s3k6-pzi2.json"
        case testScores = "https://data.cityofnewyork.us/resource/f9bf-2cp4.json"
    }
}
