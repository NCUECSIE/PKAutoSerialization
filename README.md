# PKAutoSerialization

The core of the serialization is `PKPrimitiveConvertible`, which is a protocol that bridges your custom type into `Primitive`. we provide two generic implementation as protocols `PKObjectReflectionSerializable` and `PKEnumReflectionSerializable`. 

> It should be noted that `PKObjectReflectionSerializable` does not serialize members with `__` prefix, nor does it serialize `_id` field.

When you call `serialize()`, you will get a serialized view of the value, that is compatible with JSON. 

Since tuples are not extensible, you must call `serialize()` yourself, or at least put it in a custom data type that supports `PKPrimitiveConvertible` so we all `serialize()` on the tuple for you.

To support deserialization, you must deserialize member tuples yourselves in your `deserialize()` function. You must define `deserialize()` function for structures and enums that are not `RawRepresentable`. 

Please note that while most data types can now conform to `Primitive` in some way, do remember they are not in native `BSON` data types, so they need to be converted with `makeBinary()` or `serialize()` call in some way. While they sound like the same thing, `makeBinary()` should be much safer since `makeBinary()` implementations on `Array` and `Dictionary` would also call `makeBinary()` on its elements. 

In most cases, you would only need to use `Document.init(_: PKPrimitiveConvertible)`, which would call `makeBinary()` for you automatically.
