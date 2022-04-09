import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Project

// Creates our project using a helper function defined in ProjectDescriptionHelpers

let infoPlist: [String: InfoPlist.Value] = [
    "UILaunchScreen": [:],
    "CFBundleShortVersionString": "1.3",
    "CFBundleVersion": "1.0"
]

let targets = [
    Target(
        name: "Marker",
        platform: .iOS,
        product: .app,
        bundleId: "com.Marker.Marker",
        deploymentTarget: .iOS(targetVersion: "13.1", devices: [.iphone]),
        infoPlist: .extendingDefault(with: infoPlist),
        sources: ["Marker/Sources/**"],
        resources: [
            "Marker/Resources/**",
        ],
        actions: [.post(script: "scripts/swiftlint.sh", name: "SwiftLint")],
        dependencies: [
        ]
    ),
    Target(
        name: "MarkerTests",
        platform: .iOS,
        product: .unitTests,
        bundleId: "com.Marker.MarkerTests",
        deploymentTarget: .iOS(targetVersion: "13.1", devices: [.iphone]),
        infoPlist: .extendingDefault(with: [:]),
        sources: ["Marker/Tests/**"],
        dependencies: [
            .target(name: "Marker")
        ]
    )
]

let project = Project(
    name: "Marker",
    organizationName: "Marker",
    packages: [],
    targets: targets
)
