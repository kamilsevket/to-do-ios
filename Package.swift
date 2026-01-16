// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "ToDoiOS",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "ToDoiOS",
            targets: ["ToDoiOS"]
        )
    ],
    targets: [
        .target(
            name: "ToDoiOS",
            path: "ToDoiOS",
            exclude: ["Resources/Assets.xcassets"],
            sources: [
                "App",
                "Features",
                "Core"
            ]
        ),
        .testTarget(
            name: "ToDoiOSTests",
            dependencies: ["ToDoiOS"],
            path: "ToDoiOS/Tests/UnitTests"
        )
    ]
)
