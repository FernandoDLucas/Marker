import ProjectDescription
import ProjectDescriptionHelpers

let targets = [
    Target(
        name: "AnchorKit",
        platform: .iOS,
        product: .framework,
        bundleId: "com.Marker.AnchorKit",
        deploymentTarget: .iOS(targetVersion: "13.1", devices: [.iphone]),
        infoPlist: .extendingDefault(with: [:]),
        sources: ["Sources/**"],
        resources: [
        ],
        dependencies: [
        ]
    )
]

let project = Project(
    name: "AnchorKit",
    organizationName: "Marker",
    packages: [],
    targets: targets
)
