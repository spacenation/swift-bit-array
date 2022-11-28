import Foundation

extension BitArray: Sequence {
    public func makeIterator() -> BitArrayIterator {
        BitArrayIterator(offset: 0, bitArray: self)
    }
}

public struct BitArrayIterator: IteratorProtocol {
    public internal(set) var offset: Int
    public let bitArray: BitArray
    
    public init(offset: Int, bitArray: BitArray) {
        self.offset = offset
        self.bitArray = bitArray
    }
    
    public mutating func next() -> Bool? {
        defer {
            offset += 1
        }
        return bitArray[safe: offset]
    }
}
