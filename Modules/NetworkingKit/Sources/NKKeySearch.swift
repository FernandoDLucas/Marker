//
//  NKKeySearch.swift
//  Marker
//
//  Created by Fernando de Lucas da Silva Gomes on 15/03/22.
//  Copyright © 2022 Marker. All rights reserved.
//

import Foundation

public protocol NKKeySearch {
    var predicate: NSPredicate { get set }
    var descriptor: [NSSortDescriptor] { get }
    var fetchLimit: Int { get }
}

public struct SearchByStatus: NKKeySearch {
    public var predicate: NSPredicate
    
    public var descriptor: [NSSortDescriptor] {
        [NSSortDescriptor(key: "creationDate", ascending: true)]
    }
    
    public var fetchLimit: Int {
        1
    }
    
    public init(
        status: ComicStatus
    ) {
        self.predicate = NSPredicate(format: "status = %d", status.rawValue)
    }
}

public enum ComicStatus: Int {
    case reading, read, wantToRead
}

public struct ComicStatusInteraction {
    
    public static func getIndexFor(_ value: String) -> Int {
        switch value {
        case "Lido":
            return 0
        case "Lendo":
            return 1
        case "Quero Ler":
            return 2
        default:
            return 0
        }
    }
}

enum Schema {
    enum Comic: String {
        case type
    }
}
