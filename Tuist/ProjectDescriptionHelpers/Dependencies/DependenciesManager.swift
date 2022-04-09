//
//  Dependencies.swift
//  ProjectDescriptionHelpers
//
//  Created by Fernando de Lucas da Silva Gomes on 09/04/22.
//

import ProjectDescription

public struct DependenciesManager {
    
    enum Dependencies: String, CaseIterable {
        case Strategy
        case DesignKit
        case NetworkingKit
        case AnchorKit
    }
    
    public static var projectDependencies: [TargetDependency] {
        var dependencies = [TargetDependency]()
        Dependencies.allCases.forEach {
            dependencies.append(.project(target: $0.rawValue, path: "../Modules/\($0)"))
        }
        return dependencies
    }
}
