import BSON

/// 想要支援自動序列化的型態必須支援的協定，
/// - Note:
/// 建議 `class` 或是 `struct` 採用
public protocol PKObjectReflectionSerializable: PKPrimitiveConvertible {
    func serialize() throws -> Primitive
}

/// The default implementation does not
public extension PKObjectReflectionSerializable {
    var typeIdentifier: Byte { return 0x03 }
    func serialize() throws -> Primitive {
        let mirror = Mirror(reflecting: self)
        if mirror.displayStyle == .class || mirror.displayStyle == .struct {
            var dictionary: [String: Primitive] = [:]
            for (key, value) in mirror.children.map({ ($0.label!, $0.value) }) where !key.hasPrefix("__") && !(key == "_id") {
                if case .some(.tuple) = Mirror(reflecting: value).displayStyle {
                    dictionary[key] = serializeTuple(value)
                } else if let value = value as? PKPrimitiveConvertible {
                    dictionary[key] = try! value.serialize()
                } else if let value = value as? Primitive {
                    dictionary[key] = value
                } else {
                    throw SerializationError.unsupportedValue
                }
            }
            return dictionary
        }
        
        throw SerializationError.unsupportedType
    }
    func convert<DT>(to type: DT.Type) -> DT.SupportedValue? where DT : DataType {
        fatalError()
    }
}
