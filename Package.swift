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
    targets: [
        .executableTarget(name: "GitFame"),
    ]
)
