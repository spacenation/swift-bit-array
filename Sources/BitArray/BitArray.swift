
public struct BitArray {
    
    public static let empty = BitArray()
    
    public internal(set) var length: Int
    public internal(set) var bytes: [UInt8]
   

    public init() {
        length = 0
        bytes = []
    }
    
    public init(bytes: [UInt8], length: Int) {
        self.length = length
        self.bytes = bytes
    }

    public init(bytes: [UInt8]) {
        length = bytes.count * 8
        self.bytes = bytes
    }
    
    public init(byte: UInt8) {
        length = 8
        self.bytes = [byte]
    }
    
    public init(byte: UInt8, length: Int) {
        self.length = length
        self.bytes = [byte]
    }
    
    public init(bool: Bool) {
        length = 1
        switch bool {
        case true:
            self.bytes = [0b10000000]
        case false:
            self.bytes = [0]
        }
    }
    
    public init(bools: [Bool]) {
        self = bools.reduce(.empty, +)
    }
    
    public var asUInt8: UInt8 {
        bytes.first!
    }
    
    public subscript(safe index: Int) -> Bool? {
        guard index >= 0, index < length else { return nil }
        let bitIndex = index % 8
        let byteIndex = index / 8
        let byte = bytes[byteIndex]
        let int = byte >> (8 - (bitIndex + 1)) & 0x0001
        return int == 0 ? false : true
    }
}

extension BitArray : Hashable {}
extension BitArray : Equatable {}

extension BitArray: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Bool...) {
        self.init(bools: elements)
    }
}


extension BitArray: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: UInt8) {
        self.init(byte: value)
    }
}

func boolsToBytes(bools: [Bool]) -> [UInt8] {
    let paddedBools = Array(repeating: false, count: max(8 - bools.count, 0)) + bools
    let numBits = paddedBools.count
    let numBytes = (numBits + 7)/8
    var bytes = Array<UInt8>.init(repeating: 0, count: numBytes)

    for (index, bit) in paddedBools.enumerated() {
        if bit {
            bytes[index / 8] += 1 << (7 - index % 8)
        }
    }

    return bytes
}

public extension BitArray {
    init(uInt8: UInt8, length: Int = 8) {
        self.init(byte: uInt8, length: length)
    }
    
    init(uInt16: UInt16, length: Int = 16) {
        self.init(bytes: [UInt8(uInt16 & 0xff), UInt8(uInt16 >> 8)], length: length)
    }
    
    init(uInt32: UInt32, length: Int = 32) {
        self.init(bytes: [UInt8(uInt32 & 0x000000FF), UInt8((uInt32 & 0x0000FF00) >> 8), UInt8((uInt32 & 0x00FF0000) >> 16), UInt8((uInt32 & 0xFF000000) >> 24)], length: length)
    }
    
    init(uInt64: UInt64, length: Int = 64) {
        self.init(
            bytes: [
                UInt8(uInt64 & 0x00000000000000FF),
                UInt8((uInt64 & 0x000000000000FF00) >> 8),
                UInt8((uInt64 & 0x0000000000FF0000) >> 16),
                UInt8((uInt64 & 0x00000000FF000000) >> 24),
                UInt8((uInt64 & 0x000000FF00000000) >> 32),
                UInt8((uInt64 & 0x0000FF0000000000) >> 40),
                UInt8((uInt64 & 0x00FF000000000000) >> 48),
                UInt8((uInt64 & 0xFF00000000000000) >> 56),
            ],
            length: length
        )
    }
}
