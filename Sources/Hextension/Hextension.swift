import Foundation

public enum DataHexError: Error, Equatable {
    case invalidCharacter(Character, index: Int)
    case invalidLength
}

let characters: [Character] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f"]

extension Data {
    /// Initialize a `Data` from a hex encoded String.
    ///
    /// Supports both upper- and lower-case letters.
    ///
    /// - Parameter hex: The string to parse.
    /// - Throws: An instance of `DataHexError` if the input is invalid.
    public init(hex: String) throws {
        let length = hex.count
        if length % 2 != 0 {
            throw DataHexError.invalidLength
        }
        self.init(capacity: length / 2)

        var prev: Character?
        for cur in hex {
            if let p = prev {
                guard let high = p.hexDigitValue else {
                    throw DataHexError.invalidCharacter(p, index: 2*count)
                }
                guard let low = cur.hexDigitValue else {
                    throw DataHexError.invalidCharacter(cur, index: 2*count + 1)
                }
                append(UInt8(16*high + low))
                prev = nil
            } else {
                prev = cur
            }
        }
        assert(prev == nil)
    }

    /// Initialize a `Data` from a Base-16 encoded String.
    ///
    /// This initializer is included for consistency with the one for Base-64.
    /// It simply delegates to `Data(hex:)`.
    /// Unlike that initializer, this one returns `nil` instead of throwing an error
    /// when the input is not recognized as valid Base-16.
    /// - Parameter base16String: The string to parse.
    public init?(base16Encoded base16String: String) {
        try? self.init(hex: base16String)
    }

    /// The data contents as a hexadecimal encoded string.
    public var hex: String {
        let length = 2 * count
        var res = String()
        res.reserveCapacity(length)
        for byte in self {
            let high = Int(byte / 16)
            let low = Int(byte % 16)
            res.append(characters[high])
            res.append(characters[low])
        }
        return res
    }

    /// Returns the data contents as a Base-16/hex encoded string.
    ///
    /// This function is included for consistency with the Base-64 method and simply delegates to the `hex` property.
    /// - Returns: The data in Base-16 encoding.
    public func base16EncodedString() -> String {
        hex
    }
}
