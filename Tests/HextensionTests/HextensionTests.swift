import XCTest
@testable import Hextension

final class HextensionTests: XCTestCase {
    func testValid() {
        func assertRoundtrip(_ hex: String) {
            let data = try! Data(hex: hex)
            XCTAssertEqual(hex, data.hex)
        }

        assertRoundtrip("")
        assertRoundtrip("00")
        assertRoundtrip("0000")
        assertRoundtrip("000000")
        assertRoundtrip("ff")
        assertRoundtrip("ff")
        assertRoundtrip("ffff")
        assertRoundtrip("ffffff")
        assertRoundtrip("123456789abcde")
        assertRoundtrip("21436587a9cbed")
        assertRoundtrip("0123456789abcdef")
    }

    func testValidUppercase() {
        let data = try! Data(hex: "0123456789ABCDEF")
        XCTAssertEqual("0123456789abcdef", data.hex)
    }

    func testInvalidCharacter() {
        func assertHasInvalidCharacter(_ hex: String, at index: Int) {
            XCTAssertThrowsError(try Data(hex: hex), "input='\(hex)'") { err in
                let c = hex[hex.index(hex.startIndex, offsetBy: index)]
                XCTAssertEqual(err as! DataHexError, DataHexError.invalidCharacter(c, index: index))
            }
        }
        assertHasInvalidCharacter("x0", at: 0)
        assertHasInvalidCharacter("0x", at: 1)
        assertHasInvalidCharacter("xx", at: 0)
        assertHasInvalidCharacter("aa0x", at: 3)
        assertHasInvalidCharacter("0xaa", at: 1)
        assertHasInvalidCharacter("aa0xaa", at: 3)
        assertHasInvalidCharacter("aaxxaa", at: 2)
    }

    func testInvalidLength() {
        func assertHasInvalidLength(_ hex: String) {
            XCTAssertThrowsError(try Data(hex: hex)) { err in
                XCTAssertEqual(err as! DataHexError, DataHexError.invalidLength)
            }
        }
        assertHasInvalidLength("a")
        assertHasInvalidLength("aaa")
        assertHasInvalidLength("aaaaa")
    }

    func testInvalid() {
        // A single invalid character also has invalid length
        // Throwing error for either issue is valid so we only test that some is thrown.
        XCTAssertThrowsError(try Data(hex: "x")) { err in
            let _ = err as! DataHexError
        }
    }
}
