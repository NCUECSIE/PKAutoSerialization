import BSON

extension Optional: PKPrimitiveConvertible {
    public func serialize() throws -> Primitive {
        switch self {
        case .none:
            return Null()
        case .some(let x) where x is Primitive:
            return x as! Primitive
        default:
            fatalError("Optional value being serialized does not wrap a primitive.")
        }
    }
    public static func deserialize(from primitive: Primitive) -> Optional<Wrapped>? {
        fatalError("To deserialize Optionals<T>, your type must conform to Primitive.")
    }
    public func convert<DT>(to type: DT.Type) -> DT.SupportedValue? where DT : DataType {
        fatalError()
    }
}

extension Optional where Wrapped: Primitive {
    public static func deserialize(from primitive: Primitive) -> Optional<Wrapped>? {
        if primitive is Null {
            return .some(.none)
        } else {
            guard let wrapped = primitive as? Wrapped else {
                return nil
            }
            return .some(.some(wrapped))
        }
    }
}
extension Optional where Wrapped: PKPrimitiveConvertible {
    public static func deserialize(from primitive: Primitive) -> Optional<Wrapped>? {
        if primitive is Null {
            return .some(.none)
        } else {
            guard let wrappedConvertible = Wrapped.deserialize(from: primitive) else {
                return nil
            }
            return .some(.some(wrappedConvertible))
        }
    }
}

