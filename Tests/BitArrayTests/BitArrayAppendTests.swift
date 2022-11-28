import XCTest
import BitArray

final class BitArrayAppendTests: XCTestCase {
    
    func testAppendBytes() throws {
        let lhs = BitArray(byte: 8)
        let rhs = BitArray(byte: 9)
        
        XCTAssertEqual(lhs.append(rhs), BitArray(bytes: [8, 9], length: 16))
    }
    
    func testAppendSameByte() throws {
        let lhs = BitArray(bool: false)
        let rhs = BitArray(bool: true)
        
        XCTAssertEqual(lhs + rhs, BitArray(byte: 0b01000000, length: 2))
    }
    
    func testAppendWithSizeChange() throws {
        let lhs = BitArray(bool: false)
        let rhs = BitArray(bytes: [0b11111111, 0b00000001])
        
        XCTAssertEqual(lhs.append(rhs), BitArray(bytes: [0b01111111, 0b10000000, 0b10000000], length: 17))
    }
    
    func testAppendWithLengths() throws {
        let lhs = BitArray(byte: 0b11111000, length: 5)
        let rhs = BitArray(byte: 0b00110000, length: 4)
        
        XCTAssertEqual(lhs.append(rhs), BitArray(bytes: [0b11111001, 0b10000000], length: 9))
    }
}
