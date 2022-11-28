import Foundation

extension BitArray: Collection {
    public typealias Index = Int
    
    public var startIndex: Int {
        0
    }
    
    public var endIndex: Int {
        length - 1
    }
    
    public subscript(position: Int) -> Bool {
        self[safe: position]!
    }
    
    public func index(after i: Int) -> Int {
        i + 1
    }
}
