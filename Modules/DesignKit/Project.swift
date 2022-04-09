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
        name: "DesignKit",
        platform: .iOS,
        product: .framework,
        bundleId: "com.Marker.DesignKit",
        deploymentTarget: .iOS(targetVersion: "13.1", devices: [.iphone]),
        infoPlist: .extendingDefault(with: [:]),
        sources: ["Sources/**"],
        resources: [
            "Resources/**"
        ],
        dependencies: [
        ]
    )
]

let project = Project(
    name: "Marker",
    organizationName: "Marker",
    packages: [],
    targets: targets
)
