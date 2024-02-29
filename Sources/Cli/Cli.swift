import Foundation
import Hextension

let newline = "\n".data(using: .ascii)!

func log(_ msg: String) {
    if let data = msg.data(using: .ascii) {
        FileHandle.standardError.write(data)
        FileHandle.standardError.write(newline)
    }
}

func run() throws {
    while true {
        guard let line = readLine() else {
            return
        }
        print(try Data(hex: line).hex)
    }
}

do {
    try run()
} catch DataHexError.invalidLength {
    log("Error: Invalid length.")
    _exit(1)
} catch let DataHexError.invalidCharacter(c, index) {
    log("Error: Invalid character '\(c)' at index \(index).")
    _exit(2)
}
