// swift-tools-version: 5.4

import PackageDescription

let package = Package(
    name: "Hextension",
    products: [.library(name: "Hextension", targets: ["Hextension"])],
    targets: [
        .target(name: "Hextension"),
        .testTarget(name: "HextensionTests", dependencies: ["Hextension"]),
        .executableTarget(name: "Cli", dependencies: ["Hextension"]),
    ]
)
