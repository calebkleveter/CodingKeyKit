import Runtime

public struct CodingKeyExtractor {
    public let type: Decodable.Type
    public let keyType: CodingKey.Type

    internal var keyInfo: TypeInfo

    public init(type: Decodable.Type) {
        self.type = type

        let decoder = CodingKeyDecoder()
        do { _ = try type.init(from: decoder) }
        catch { }

        self.keyType = decoder.type
        self.keyInfo = try! typeInfo(of: decoder.type)
    }

    public func codingKeys() -> [CodingKey] {
        return self.keyInfo.cases.compactMap { self.keyType.init(stringValue: $0.name) }
    }

    public func codingKey(for string: String) -> CodingKey? {
        return self.keyType.init(stringValue: string)
    }

    public func codingKey(for int: Int) -> CodingKey? {
        return self.keyType.init(intValue: int)
    }
}

internal final class CodingKeyDecoder: Decoder {
    enum Exit: Error {
        case finish
    }
    
    var type: CodingKey.Type!

    func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> where Key : CodingKey {
        self.type = Key.self
        throw Exit.finish
    }

    // Required

    let codingPath: [CodingKey] = []
    let userInfo: [CodingUserInfoKey : Any] = [:]

    func unkeyedContainer() throws -> UnkeyedDecodingContainer {
        throw Exit.finish
    }

    func singleValueContainer() throws -> SingleValueDecodingContainer {
        throw Exit.finish
    }
}
