// swift-tools-version:3.1.0

import PackageDescription

let package = Package(
    name: "PKAutoSerialization",
//  The Products and Targets section is for Version 4.0
//    products: [
//        .library(name: "PKAutoSerialization", targets: ["PKAutoSerialization"])
//    ],
//    targets: [
//        .target(name: "PKAutoSerialization", dependencies: ["BSON"], sources: "./Sources"),
//        .testTarget(name: "PKAutoSerializationTests", dependencies: ["PKAutoSerialization"], sources: "./Tests")
//    ],
    dependencies: [
        .Package(url: "https://github.com/OpenKitten/BSON.git", majorVersion: 5)
    ]
)
