//
//  ViewCodeProtocol.swift
//  Marker
//
//  Created by Fernando de Lucas da Silva Gomes on 15/03/22.
//  Copyright © 2022 Marker. All rights reserved.
//

import UIKit

public protocol ViewCode {
    func setupViewHierarchy()
    func setupConstraints()
}

extension ViewCode {
    public func setupView() {
        setupViewHierarchy()
        setupConstraints()
    }
}
