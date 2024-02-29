import Foundation

public enum DataHexError: Error, Equatable {
    case invalidCharacter(Character, index: Int)
    case invalidLength
}

let characters: [Character] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f"]

extension Data {
    /// Initialize a `Data` from a hexadecimal/base-16 encoded String.
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
        var idx = -1
        for cur in hex {
            if let p = prev {
                idx += 2
                guard let high = p.hexDigitValue else {
                    throw DataHexError.invalidCharacter(p, index: idx-1)
                }
                guard let low = cur.hexDigitValue else {
                    throw DataHexError.invalidCharacter(cur, index: idx)
                }
                append(UInt8(16*high + low))
                prev = nil
            } else {
                prev = cur
            }
        }
        assert(prev == nil)
    }

    /// The data contents as a hexadecimal/base-16 encoded string.
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
}
