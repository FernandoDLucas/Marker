import ProjectDescription
import ProjectDescriptionHelpers

let targets = [
    Target(
        name: "Utils",
        platform: .iOS,
        product: .framework,
        bundleId: "com.Marker.Utils",
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
    name: "Utils",
    organizationName: "Marker",
    packages: [],
    targets: targets
)
