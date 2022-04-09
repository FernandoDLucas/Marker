import ProjectDescription
import ProjectDescriptionHelpers

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
            .project(target: "Strategy", path: "../Strategy")
        ]
    )
]

let project = Project(
    name: "DesignKit",
    organizationName: "Marker",
    packages: [],
    targets: targets
)
