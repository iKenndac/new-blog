import Foundation
import Markdown
import Crypto

// Helpers

extension MarkupChildren {
    var encryptableElements: [any EncryptableElement] {
        return compactMap({
            guard let encryptable = $0 as? EncryptableMarkdownElement else {
                print("WARNING: Encountered unsupported element for encrypting: \(type(of: $0))")
                return nil
            }
            return encryptable.asElement
        })
    }

    func nonEncryptableElements(with classes: [String]) -> [TopLevelElement] {
        return compactMap({ $0 as? NonEncryptableMarkdownElement })
            .map({ $0.asElement(with: classes) })
    }
}

// MARK: - Model: Encryptable

// An element that should be encrypted. Plain text, links, basic formatting, etc.
protocol EncryptableElement {
    func contentToEncrypt() -> String
}

// Plain 'ol text.
struct RawContentElement: EncryptableElement {
    let text: String

    func contentToEncrypt() -> String {
        // This is *extraordinarily* basic, and misses extended characters. HTML must be declared as utf-8.
        return text.replacingOccurrences(of: "&", with: "&amp;")
            .replacingOccurrences(of: "<", with: "&lt;")
            .replacingOccurrences(of: ">", with: "&gt;")
            .replacingOccurrences(of: "\"", with: "&quot;")
            .replacingOccurrences(of: "'", with: "&#39;")
    }
}

// Basic tagged content (<tag>content</tag>).
struct TaggedContentElement: EncryptableElement {
    let tag: String
    let children: [EncryptableElement]

    func contentToEncrypt() -> String {
        let childContent = children.map({ $0.contentToEncrypt() }).joined()
        return "<\(tag)>\(childContent)</\(tag)>"
    }
}

// A link.
struct LinkElement: EncryptableElement {
    let linkDestination: String
    let children: [EncryptableElement]

    func contentToEncrypt() -> String {
        let childContent = children.map({ $0.contentToEncrypt() }).joined()
        return "<a href=\"\(linkDestination)\">\(childContent)</a>"
    }
}

// MARK: - Model: Converting from Encryptable Markdown Objects

protocol EncryptableMarkdownElement {
    var asElement: any EncryptableElement { get }
}

extension Link: EncryptableMarkdownElement {
    var asElement: any EncryptableElement {
        return LinkElement(linkDestination: destination ?? "", children: children.encryptableElements)
    }
}

extension Text: EncryptableMarkdownElement {
    var asElement: any EncryptableElement {
        return RawContentElement(text: plainText)
    }
}

extension Emphasis: EncryptableMarkdownElement {
    var asElement: any EncryptableElement {
        return TaggedContentElement(tag: "em", children: children.encryptableElements)
    }
}

extension Strong: EncryptableMarkdownElement {
    var asElement: any EncryptableElement {
        return TaggedContentElement(tag: "strong", children: children.encryptableElements)
    }
}

// MARK: - Model: Non-Encryptable

protocol NonEncryptableMarkdownElement {
    func asElement(with classes: [String]) -> TopLevelElement
}

struct TopLevelElement {
    internal init(tag: String, classes: [String], children: [any EncryptableElement], unencryptedChildren: [TopLevelElement] = []) {
        self.tag = tag
        self.classes = classes
        self.children = children
        self.unencryptedChildren = unencryptedChildren
    }
    
    let tag: String // p, h2, etc
    let classes: [String] // CSS classes to apply to the tag
    let children: [EncryptableElement]
    let unencryptedChildren: [TopLevelElement]

    enum Encryption {
        case none
        case withKey(SymmetricKey)
    }

    func content(encryption: Encryption) throws -> String {
        if !unencryptedChildren.isEmpty {
            return try _nestedContent(encryption: encryption)
        }

        if children.isEmpty {
            return "<\(tag) />"
        }

        let openingTag: String
        if classes.isEmpty {
            openingTag = "<\(tag)>"
        } else {
            openingTag = "<\(tag) class=\"\(classes.joined(separator: " "))\">"
        }

        let closingTag = "</\(tag)>"

        let childContent = children.map({ $0.contentToEncrypt() }).joined()

        switch encryption {
        case .none:
            return "\(openingTag)\(childContent)\(closingTag)"

        case .withKey(let key):
            let data = Data(childContent.utf8)
            let result = try AES.GCM.seal(data, using: key)

            let hexResult = result.ciphertext.hexEncodedString()
            let hexTag = result.tag.hexEncodedString()
            let hexJSPayload = hexResult + hexTag // JS' crypto module wants the tag at the end of the result.

            let hexNonce = result.nonce.hexEncodedString()
            let finalOutput = hexNonce + hexJSPayload // Our own implementation puts the nonce/iv at the beginning
            return "\(openingTag)\(finalOutput)\(closingTag)"
        }
    }

    private func _nestedContent(encryption: Encryption) throws -> String {
        let openingTag = "<\(tag)>"
        let closingTag = "</\(tag)>"
        var lines: [String] = [openingTag]

        let childContent = try unencryptedChildren.map({ try $0.content(encryption: encryption) })
        lines.append(contentsOf: childContent)

        lines.append(closingTag)
        return lines.joined(separator: "\n")
    }
}


// MARK: - Model: Converting from Non-Encryptable Markdown Objects

extension Paragraph: NonEncryptableMarkdownElement {
    func asElement(with classes: [String]) -> TopLevelElement {
        return TopLevelElement(tag: "p", classes: classes, children: children.encryptableElements)
    }
}

extension ThematicBreak: NonEncryptableMarkdownElement {
    func asElement(with classes: [String]) -> TopLevelElement {
        return TopLevelElement(tag: "hr", classes: [], children: [])
    }
}

extension Heading: NonEncryptableMarkdownElement {
    func asElement(with classes: [String]) -> TopLevelElement {
        let tagName = "h\(level)"
        return TopLevelElement(tag: tagName, classes: classes, children: children.encryptableElements)
    }
}

extension BlockQuote: NonEncryptableMarkdownElement {
    func asElement(with classes: [String]) -> TopLevelElement {
        // This one is a bit odd in that it'll have paragraphs etc as children.
        // We might be better with a different type.
        let nonEncryptedChildren = children.nonEncryptableElements(with: classes)
        return TopLevelElement(tag: "blockquote", classes: [], children: [], unencryptedChildren: nonEncryptedChildren)
    }
}

extension ListItem: NonEncryptableMarkdownElement {
    func asElement(with classes: [String]) -> TopLevelElement {
        // li ends up being triple-unencrypted since it seems to have paragraph elements.
        return TopLevelElement(tag: "li", classes: classes, children: [],
                               unencryptedChildren: children.nonEncryptableElements(with: classes))
    }
}

extension UnorderedList: NonEncryptableMarkdownElement {
    // This one is a bit odd in that it'll have list items as children.
    // We might be better with a different type.
    func asElement(with classes: [String]) -> TopLevelElement {
        return TopLevelElement(tag: "ul", classes: [], children: [],
                               unencryptedChildren: children.nonEncryptableElements(with: classes))
    }
}

extension OrderedList: NonEncryptableMarkdownElement {
    // This one is a bit odd in that it'll have list items as children.
    // We might be better with a different type.
    func asElement(with classes: [String]) -> TopLevelElement {
        let nonEncryptedChildren = children.nonEncryptableElements(with: classes)
        return TopLevelElement(tag: "ol", classes: [], children: [], unencryptedChildren: nonEncryptedChildren)
    }
}
