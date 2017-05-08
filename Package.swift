// swift-tools-version:3.1.0

import PackageDescription

let package = Package(
    name: "PKAutoSerialization",
    dependencies: [
        .Package(url: "https://github.com/OpenKitten/BSON.git", majorVersion: 5),
    ]
)
