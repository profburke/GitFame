// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GitFame",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .executable(name: "gitfame", targets: ["GitFame"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.3.0"),
    ],
    targets: [
        .executableTarget(name: "GitFame",
                          dependencies: [
                            .product(name: "ArgumentParser", package: "swift-argument-parser")
                          ]),
    ]
)
