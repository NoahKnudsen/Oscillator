// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "Oscillator",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: "Oscillator",
            targets: ["Oscillator"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Oscillator",
            dependencies: []),
        .testTarget(
            name: "OscillatorTests",
            dependencies: ["Oscillator"]),
    ]
)
