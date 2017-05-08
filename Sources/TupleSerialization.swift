import BSON

/// 用映射 API 將 Tuple 序列化
public func serializeTuple(_ tuple: Any) -> [Primitive] {
    if let tuple = tuple as? Primitive {
        return [tuple]
    }
    
    var elements: [Primitive] = []
    
    let mirror = Mirror(reflecting: tuple)
    switch mirror.displayStyle {
    case .some(.tuple):
        for (_, value) in mirror.children {
            if case .some(.tuple) = Mirror(reflecting: value).displayStyle {
                elements.append(serializeTuple(value))
            } else if let value = value as? PKPrimitiveConvertible {
                elements.append(try! value.serialize())
            } else if let value = value as? Primitive {
                elements.append(value)
            } else {
                fatalError("Tuple includes a non-Primitive value")
            }
        }
    default:
        fatalError("Argument not a tuple")
    }
    
    return elements
}
