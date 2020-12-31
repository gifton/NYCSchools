
import Foundation


extension URLSession {
    
    
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }
    

    func testScoresTask(with url: URL, completionHandler: @escaping (TestScores?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
    
    func schoolTask(with url: URL, completionHandler: @escaping (School?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            return self.codableTask(with: url, completionHandler: completionHandler)
        }
}
