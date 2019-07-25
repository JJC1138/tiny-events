// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "TinyEvents",
    products: [.library(name: "TinyEvents", targets: ["TinyEvents"])],
    targets: [
        .target(name: "TinyEvents"),
        .testTarget(name: "TinyEventsTests", dependencies: ["TinyEvents"]),
    ]
)
