//
//  Dependencies.swift
//  ProjectDescriptionHelpers
//
//  Created by Fernando de Lucas da Silva Gomes on 09/04/22.
//

import ProjectDescription

public enum Dependencies: String, CaseIterable {
    case Strategy
    case DesignKit
    case NetworkingKit
    case AnchorKit
    case Utils
    
    public var project: TargetDependency {
        return .project(target: self.rawValue, path: Path.relativeToRoot("Modules/\(self.rawValue)"))
    }
}

public struct DependenciesManager {
    public static var projectDependencies: [TargetDependency] {
        var dependencies = [TargetDependency]()
        Dependencies.allCases.forEach {
            dependencies.append($0.project)
        }
        return dependencies
    }
}
