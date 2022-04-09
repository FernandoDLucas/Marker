import ProjectDescription
import ProjectDescriptionHelpers


let targets = [
    Target(
        name: "NetworkingKit",
        platform: .iOS,
        product: .framework,
        bundleId: "com.Marker.NetworkingKit",
        deploymentTarget: .iOS(targetVersion: "13.1", devices: [.iphone]),
        infoPlist: .extendingDefault(with: [:]),
        sources: ["Sources/**"],
        resources: [
            
        ],
        dependencies: [

        ],
        coreDataModels: [CoreDataModel(Path.relativeToManifest("Resources/Marker.xcdatamodeld"))]
    ),
    Target(
        name: "NetworkingKitTests",
        platform: .iOS,
        product: .unitTests,
        bundleId: "com.Marker.NetworkingKitTests",
        deploymentTarget: .iOS(targetVersion: "13.1", devices: [.iphone]),
        infoPlist: .extendingDefault(with: [:]),
        sources: ["Tests/**"],
        dependencies: [
            .target(name: "NetworkingKit")
        ]
    )
]

let project = Project(
    name: "NetworkingKit",
    organizationName: "Marker",
    packages: [],
    targets: targets
)
