import ArgumentParser
import Crypto
import Foundation
import Markdown

// This is a very simple tool that takes a Markdown file, parses it, then constructs encrypted HTML output
// that'll work on my blog. The idea is that overall structure survives - paragraphs, headers, etc will be output
// as <p>…</p> (etc) with encrypted content, but detailed structure (em, strong, etc) will be directly encrypted
// so as to not unnecessarily lengthen the encrypted output.

@main
struct Encrypter: ParsableCommand {

    @Option(name: .customLong("input"), help: "The Markdown file to parse.")
    var inputFilePath: String

    @Option(name: .customLong("key"), help: "The encryption key to encrypt the output with. If none is provided, one will be generated (and output to STDOUT).")
    var existingKey: String?

    @Option(name: [.customLong("class")], help: "CSS classes to apply to the decryptable elements.")
    var classes: [String] = []

    @Option(name: .customLong("output"), help: "Where to output the HTML.")
    var outputFilePath: String

    @Option(name: .customLong("plain-output"), help: "Where to output the HTML.")
    var unencryptedOutputFilePath: String?

    mutating func run() throws {

        let document = try Document(parsing: URL(fileURLWithPath: inputFilePath))

        var topLevelElements: [TopLevelElement] = []

        for element in document.children {
            if let topLevel = element as? NonEncryptableMarkdownElement {
                let html = topLevel.asElement(with: classes)
                topLevelElements.append(html)
            } else {
                print("WARNING: Encountered unsupported top-level element: \(type(of: element))")
            }
        }

        let key: SymmetricKey
        if let existingKey {
            guard existingKey.count == 64 else {
                print("ERROR: Invalid key (must be 64 chars)!")
                throw ExitCode(-1)
            }

            guard let keyData = Data(hex: existingKey) else {
                print("Error: Invalid key!")
                throw ExitCode(-1)
            }

            key = SymmetricKey(data: keyData)
            print("Encrypting with existing key: \(existingKey)")
        } else {
            key = SymmetricKey(size: .bits256)
            let keyHex = key.withUnsafeBytes { buffer in
                return buffer.hexEncodedString()
            }
            print("Encrypting with newly-generated key: \(keyHex)")
        }

        let lines: [String] = try topLevelElements.map({ element in
            return try element.content(encryption: .withKey(key))
        })

        let output = lines.joined(separator: "\n\n")
        let data = Data(output.utf8)
        try data.write(to: URL(fileURLWithPath: outputFilePath))

        if let unencryptedOutputFilePath {
            let lines: [String] = try topLevelElements.map({ element in
                return try element.content(encryption: .none)
            })

            let output = lines.joined(separator: "\n\n")
            let data = Data(output.utf8)
            try data.write(to: URL(fileURLWithPath: unencryptedOutputFilePath))
        }
    }
}

extension Sequence where Element == UInt8 {
    func hexEncodedString() -> String {
        return map { String(format: "%02hhx", $0) }.joined()
    }
}

extension Data {
    init?(hex: String) {
        guard hex.count.isMultiple(of: 2) else { return nil }

        let chars = hex.map({ $0 })
        let bytes = stride(from: 0, to: chars.count, by: 2)
            .map { String(chars[$0]) + String(chars[$0 + 1]) }
            .compactMap { UInt8($0, radix: 16) }

        guard hex.count / bytes.count == 2 else { return nil }
        self.init(bytes)
    }
}
