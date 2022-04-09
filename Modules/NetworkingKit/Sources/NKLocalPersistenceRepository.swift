//
//  NKLocalPersistenceService.swift
//  NetworkingKit
//
//  Created by Fernando de Lucas da Silva Gomes on 03/03/22.
//  Copyright © 2022 Marker. All rights reserved.
//

import Foundation
import CoreData

public final class NKComicRepository{
    
    private let service: NKLocalPersistenceService<Comic>

    init(
        service: NKLocalPersistenceService<Comic>
    ) {
        self.service = service
    }
    
    public func retrieveAll() -> [Comic]? {
        switch service.retriveAll() {
        case .success(let comics):
            return comics
        case .failure(_):
            return nil
        }
    }
    
    public func create() {
        
    }
}
