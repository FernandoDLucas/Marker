import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Project

// Creates our project using a helper function defined in ProjectDescriptionHelpers

let workspace = Workspace(
    name: "Marker",
    projects: [
        "App",
        "Modules/**"
    ]
)
