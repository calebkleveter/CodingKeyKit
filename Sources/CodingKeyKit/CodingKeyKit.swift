import Runtime

public struct CodingKeyExtractor {
    public let type: Decodable.Type

    public init(type: Decodable.Type) {
        self.type = type
    }

    public func codingKeys() -> [CodingKey] {
        let decoder = CodingKeyDecoder()

        do { _ = try type.init(from: decoder) }
        catch {}

        return decoder.cases
    }
}

internal final class CodingKeyDecoder: Decoder {
    enum Exit: Error {
        case finish
    }

    let codingPath: [CodingKey] = []
    let userInfo: [CodingUserInfoKey : Any] = [:]
    var cases: [CodingKey] = []

    func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> where Key : CodingKey {
        let enumType = try typeInfo(of: Key.self)
        self.cases = enumType.cases.compactMap { Key(stringValue: $0.name) }
        throw Exit.finish
    }

    func unkeyedContainer() throws -> UnkeyedDecodingContainer {
        throw Exit.finish
    }

    func singleValueContainer() throws -> SingleValueDecodingContainer {
        throw Exit.finish
    }
}
