import XCTest
import CodingKeyKit

final class CodingKeyKitTests: XCTestCase {
    func testUniverseWorks() {
        XCTAssert(true)
    }

    func testExtractor() throws {
        let extractor = CodingKeyExtractor(type: User.self)
        let keys = extractor.codingKeys()

        let stringValues = keys.map { $0.stringValue }
        XCTAssertEqual(stringValues, ["age", "name", "password", "registered"])
    }

    func testExtractorPerformance() throws {
        let extractor = CodingKeyExtractor(type: User.self)

        measure {
            _ = extractor.codingKeys()
        }
    }

    func testCreateFromString() throws {
        let extractor = CodingKeyExtractor(type: User.self)
        let key = extractor.codingKey(for: "password")

        XCTAssertEqual(key?.stringValue, "password")
    }

    // FAILING
    func testCustomKeys() throws {
        let extractor = CodingKeyExtractor(type: User.self)

        XCTAssertEqual(extractor.codingKeys() as? [ModifiedKeys.CodingKeys], [.foo, .baz])
    }
}

struct User: Codable {
    let age: Int
    let name: String
    let password: String
    let registered: Bool
}

struct ModifiedKeys: Codable {
    var foo: Int
    var baz: Int

    enum CodingKeys: String, CodingKey {
        case foo = "foo_bar"
        case baz = "baz_biz"
    }
}
