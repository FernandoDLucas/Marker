import ProjectDescription
import ProjectDescriptionHelpers

let targets = [
    Target(
        name: "Strategy",
        platform: .iOS,
        product: .framework,
        bundleId: "com.Marker.Strategy",
        deploymentTarget: .iOS(targetVersion: "13.1", devices: [.iphone]),
        infoPlist: .extendingDefault(with: [:]),
        sources: ["Sources/**"],
        resources: [
        ],
        dependencies: [
            Dependencies.Utils.project
        ]
    )
]

let project = Project(
    name: "Strategy",
    organizationName: "Marker",
    packages: [],
    targets: targets
)
