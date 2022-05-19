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
        [NSSortDescriptor(key: "creationDate", ascending: false)]
    }
    
    public var fetchLimit: Int {
        20
    }
    
    public init(
        status: ComicStatus
    ) {
        self.predicate = NSPredicate(format: "status = %d", status.intValue)
    }
}

enum Schema {
    enum Comic: String {
        case type
    }
}
