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
}

struct User: Codable {
    let age: Int
    let name: String
    let password: String
    let registered: Bool
}
