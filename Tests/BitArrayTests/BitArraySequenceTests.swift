import XCTest
import BitArray

final class BitArraySequenceTests: XCTestCase {
    
    func testSequenceIterator() throws {
        for bit in BitArray(byte: 0b11111111) {
            XCTAssertTrue(bit)
        }
        
        XCTAssertFalse(BitArray(byte: 0b11111111).contains(false))
        XCTAssertTrue(BitArray(byte: 0b11111111).contains(true))
    }

}
