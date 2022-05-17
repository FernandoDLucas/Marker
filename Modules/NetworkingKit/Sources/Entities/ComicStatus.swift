//
//  ComicStatus.swift
//  NetworkingKit
//
//  Created by Fernando de Lucas da Silva Gomes on 17/05/22.
//  Copyright © 2022 Marker. All rights reserved.
//

import Utils


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
