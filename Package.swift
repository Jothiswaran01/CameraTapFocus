// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "Cameratapfocus",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "Cameratapfocus",
            targets: ["CameraFocusPlugin"])
    ],
    dependencies: [
        .package(url: "https://github.com/ionic-team/capacitor-swift-pm.git", from: "7.0.0")
    ],
    targets: [
        .target(
            name: "CameraFocusPlugin",
            dependencies: [
                .product(name: "Capacitor", package: "capacitor-swift-pm"),
                .product(name: "Cordova", package: "capacitor-swift-pm")
            ],
            path: "ios/Sources/CameraFocusPlugin"),
        .testTarget(
            name: "CameraFocusPluginTests",
            dependencies: ["CameraFocusPlugin"],
            path: "ios/Tests/CameraFocusPluginTests")
    ]
)