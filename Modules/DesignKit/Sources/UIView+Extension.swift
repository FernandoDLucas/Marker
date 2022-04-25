//
//  UIView+Extension.swift
//  DesignKit
//
//  Created by Fernando de Lucas da Silva Gomes on 25/04/22.
//  Copyright © 2022 Marker. All rights reserved.
//

import AnchorKit
import UIKit

extension UIView {
    public func addBottomBorder(of size: CGFloat) {
        let view = UIView()
        view.backgroundColor = .gray
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
         
        view.anchorToHorizontalEdges(of: self)
        view.anchorToLeading(of: self)
        view.anchorHeight(withSize: size)
    }
}

