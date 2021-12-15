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
        sources: ["Targets/Marker/Sources/**"],
        resources: [
            "Targets/Marker/Resources/**",
            "Targets/Marker/Assets.xcassets/**"
        ],
        actions: [.post(script: "scripts/swiftlint.sh", name: "SwiftLint")],
        dependencies: [
            .target(name: "NetworkingKit"),
            .target(name: "DesignKit")
        ]
    ),
    Target(
        name: "MarkerTests",
        platform: .iOS,
        product: .unitTests,
        bundleId: "com.Marker.MarkerTests",
        deploymentTarget: .iOS(targetVersion: "13.1", devices: [.iphone]),
        infoPlist: .extendingDefault(with: [:]),
        sources: ["Targets/Marker/Tests/**"],
        dependencies: [
            .target(name: "Marker")
        ]
    ),
    Target(
        name: "NetworkingKit",
        platform: .iOS,
        product: .framework,
        bundleId: "com.Marker.NetworkingKit",
        deploymentTarget: .iOS(targetVersion: "13.1", devices: [.iphone]),
        infoPlist: .extendingDefault(with: [:]),
        sources: ["Targets/NetworkingKit/Sources/**"],
        resources: [
            "Targets/NetworkingKit/Resources/**"
        ],
        dependencies: [

        ]
    ),
    Target(
        name: "NetworkingKitTests",
        platform: .iOS,
        product: .unitTests,
        bundleId: "com.Marker.NetworkingKitTests",
        deploymentTarget: .iOS(targetVersion: "13.1", devices: [.iphone]),
        infoPlist: .extendingDefault(with: [:]),
        sources: ["Targets/NetworkingKit/Tests/**"],
        dependencies: [
            .target(name: "Marker")
        ]
    ),
    Target(
        name: "DesignKit",
        platform: .iOS,
        product: .framework,
        bundleId: "com.Marker.DesignKit",
        deploymentTarget: .iOS(targetVersion: "13.1", devices: [.iphone]),
        infoPlist: .extendingDefault(with: [:]),
        sources: ["Targets/DesignKit/**"],
        resources: [
            "Targets/DesignKit/Resources/Assets.xcassets/**",
            "Targets/DesignKit/Resources/**"
        ],
        dependencies: [
        ]
    ),
    Target(
        name: "AnchorKit",
        platform: .iOS,
        product: .framework,
        bundleId: "com.Marker.AnchorKit",
        deploymentTarget: .iOS(targetVersion: "13.1", devices: [.iphone]),
        infoPlist: .extendingDefault(with: [:]),
        sources: ["Targets/AnchorKit/**"],
        resources: [
            "Targets/DesignKit/Resources/**"
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
