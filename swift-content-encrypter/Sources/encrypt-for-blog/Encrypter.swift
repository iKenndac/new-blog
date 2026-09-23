import ArgumentParser
import Crypto
import Foundation

@main
struct Encrypter: ParsableCommand {
    mutating func run() throws {

        let data: Data = Data("Hello from Swift".utf8)

        let key = SymmetricKey(size: .bits256)
        let result = try AES.GCM.seal(data, using: key)

        let hexResult = result.ciphertext.hexEncodedString()
        let hexTag = result.tag.hexEncodedString()
        let hexJSPayload = hexResult + hexTag // JS' crypto module wants the tag at the end of the result.

        let hexNonce = result.nonce.hexEncodedString()
        let total = hexNonce + hexJSPayload // Our own implementation puts the nonce/iv at the beginning

        let keyHex = key.withUnsafeBytes { buffer in
            return buffer.hexEncodedString()
        }

        print("Key:", keyHex)
        print("Output:", total)
    }
}

extension Sequence where Element == UInt8 {

    func hexEncodedString() -> String {
        return map { String(format: "%02hhx", $0) }.joined()
    }
}
