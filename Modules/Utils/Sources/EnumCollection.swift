//
//  ComicStatus.swift
//  NetworkingKit
//
//  Created by Fernando de Lucas da Silva Gomes on 17/05/22.
//  Copyright © 2022 Marker. All rights reserved.
//

public protocol EnumCollection: CaseIterable, Codable, Equatable, RawRepresentable {
}

extension EnumCollection where Self.RawValue: Equatable{
    public static var allValues: [RawValue] {
        var array: [RawValue] = []
        Self.allCases.forEach {
            array.append($0.rawValue)
        }
        return array
    }
    
    public static func getIndexFor(_ value: RawValue) -> Int {
        return self.allValues.firstIndex { $0 == value } ?? 0
    }
}
