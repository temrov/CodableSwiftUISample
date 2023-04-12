// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ServerSideSwiftUI",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "ServerSideSwiftUI",
            targets: ["ServerSideSwiftUI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/SDWebImage/SDWebImageSwiftUI.git", from: "2.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "ServerSideSwiftUI",
            dependencies: ["SDWebImageSwiftUI"],
            path: "Sources"),
        .testTarget(
            name: "ServerSideSwiftUITests",
            dependencies: ["ServerSideSwiftUI"]
            ),
    ]
)