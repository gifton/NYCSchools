

import UIKit

// MARK: CGPoint helper methods
extension CGPoint {
    
    // Creates a point with unnamed arguments.
    public init(_ x: CGFloat, _ y: CGFloat) {
        self.init(x: x,  y: y)
    }
    
    // point from single value
    public init(_ value: CGFloat)  {
        self.init(x: value, y: value)
    }
    
    mutating func add(vector: CGVector) {
        self.x += vector.dx
        self.y += vector.dy
    }

    func adding(vector: CGVector) -> CGPoint {
        var copy = self
        copy.add(vector: vector)
        return copy
    }

    mutating func multiply(by value: CGFloat) {
        self.x *= value
        self.y *= value
    }
}
