//
//  NKLocalPersistenceError.swift
//  Marker
//
//  Created by Fernando de Lucas da Silva Gomes on 15/03/22.
//  Copyright © 2022 Marker. All rights reserved.
//

import Foundation

public struct NKLocalPersistenceServiceError: Error {

    let errorType: ErrorType
    let underlyingError: Error?

    init(_ errorType: ErrorType, underlyingError: Error? = nil) {
        self.errorType = errorType
        self.underlyingError = underlyingError
    }

    enum ErrorType {
        case inconsistenceOnContext
        case failToSaveContext
        case failToFetch
        case failToCreateObject
    }
}
