//
//  ComicStatus.swift
//  NetworkingKit
//
//  Created by Fernando de Lucas da Silva Gomes on 17/05/22.
//  Copyright © 2022 Marker. All rights reserved.
//

import Utils


public struct ComicSchema {
    let status: ComicStatus
    let organizedBy: ComicOrganizedBy
}

public enum ComicOrganizedBy: String, EnumCollection {
    case volume = "Volumes"
    case pages = "Páginas"
    
    public static func getCaseInIndex(_ index: Int) -> Self {
        switch index {
        case 0:
            return .volume
        case 1:
            return .pages
        default:
            return .volume
        }
    }
}

public enum ComicType: String, EnumCollection {
    case comic = "Volumes"
    case book = "Páginas"
    
    public static func getCaseInIndex(_ index: Int) -> Self {
        switch index {
        case 0:
            return .comic
        case 1:
            return .book
        default:
            return .comic
        }
    }
}

public enum ComicStatus: String, EnumCollection {
    case reading = "Lendo"
    case read = "Lido"
    case wantToRead = "Quero Ler"
    
    public static func getCaseInIndex(_ index: Int) -> Self{
        switch index {
        case 0:
            return .reading
        case 1:
            return .read
        case 2:
            return .wantToRead
        default:
            return .reading
        }
    }
    
    var intValue: Int {
        ComicStatus.getIndexFor(self.rawValue)
    }
}
