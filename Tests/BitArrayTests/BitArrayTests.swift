import XCTest
@testable import BitArray

final class BitArrayTests: XCTestCase {
    func testInitWithBools() throws {
        XCTAssertEqual(BitArray(bools: [true, false, true]), BitArray(byte: 0b10100000, length: 3))
    }
    
    func testSafeSubscript() throws {
        let bitArray = BitArray(bools: [true, false, true])
        XCTAssertEqual(bitArray[safe: 0], true)
        XCTAssertEqual(bitArray[safe: 1], false)
        XCTAssertEqual(bitArray[safe: 2], true)
        XCTAssertEqual(bitArray[safe: 3], .none)
        XCTAssertEqual(bitArray[safe: -1], .none)
        
        let bitArray2 = BitArray(bytes: [0b10100000, 0b11111000], length: 14)
        XCTAssertEqual(bitArray2[safe: 12], true)
        XCTAssertEqual(bitArray2[safe: 13], false)
    }
}
