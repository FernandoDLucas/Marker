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
        view.anchorToBottom(of: self)
        view.anchorHeight(withSize: size)
    }
    
    public func addTapAction(
        on target: Any?,
        execute action: Selector
    ) {
        self.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: target, action: action)
        self.addGestureRecognizer(gesture)
    }
    
    public func addLongPressAction(
        on target: Any?,
        execute action: Selector,
        after duration: Double = 2
    ) {
        self.isUserInteractionEnabled = true
        let gesture = UILongPressGestureRecognizer(target: target, action: action)
        gesture.minimumPressDuration = duration
        self.addGestureRecognizer(gesture)
    }
}

