
import UIKit


extension Array where Element == UIColor {
    var cgColor: [CGColor] {
        return map {
            return $0.cgColor
        }
    }
}
