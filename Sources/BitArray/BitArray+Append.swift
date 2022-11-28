import Foundation

public extension BitArray {
    static func +(lhs: BitArray, rhs: BitArray) -> BitArray {
        lhs.append(rhs)
    }
    
    static func +(lhs: Bool, rhs: BitArray) -> BitArray {
        BitArray(bool: lhs).append(rhs)
    }
    
    static func +(lhs: BitArray, rhs: Bool) -> BitArray {
        lhs.append(BitArray(bool: rhs))
    }
    
    func append(byte: UInt8) -> BitArray {
        self.append(BitArray(byte: byte))
    }
    
    func append(_ other: BitArray) -> BitArray {
        guard let lastByte = self.bytes.last else { return other }
        guard let nextByte = other.bytes.first else { return self }
        
        let bitsInLastByte = length % 8
        let lengthRemainingInNextByte = Swift.min(8, other.length)
    
        switch bitsInLastByte {
        /// Aligned append
        case 0:
            return BitArray(bytes: self.bytes + other.bytes, length: self.length + other.length)
        /// New length fits into existing byte
        case _ where bitsInLastByte + lengthRemainingInNextByte <= 8:
            let modifiedLastByte: UInt8 = lastByte | (nextByte >> UInt8(bitsInLastByte))
            let newBytes: [UInt8] = self.bytes.dropLast() + [modifiedLastByte]
            return BitArray(bytes: newBytes, length: self.length + other.length)
        /// New byte size required
        default:
            let modifiedLastByte: UInt8 = lastByte | (nextByte >> UInt8(bitsInLastByte))
            let newByte: UInt8 = nextByte << (8 - UInt8(bitsInLastByte))
            let newBytes: [UInt8] = self.bytes.dropLast() + [modifiedLastByte, newByte]
            
            return BitArray(bytes: newBytes, length: self.length + lengthRemainingInNextByte)
                .append(BitArray(bytes: Array(other.bytes.dropFirst()), length: other.length - lengthRemainingInNextByte))
        }
    }
}
