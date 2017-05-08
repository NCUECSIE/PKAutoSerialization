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
        if primitive is Null { // .none
            return .some(.none)
        } else { // .some
            if Wrapped.self is PKPrimitiveConvertible.Type {
                let WrappedConvertible = Wrapped.self as! PKPrimitiveConvertible.Type
                guard let wrappedConvertible = WrappedConvertible.deserialize(from: primitive) as? Wrapped else { return nil }
                return .some(.some(wrappedConvertible))
            }
            guard let wrapped = primitive as? Wrapped else { return nil }
            return .some(.some(wrapped))
        }
    }
    public func convert<DT>(to type: DT.Type) -> DT.SupportedValue? where DT : DataType {
        fatalError()
    }
}
