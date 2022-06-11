//
//  DSShakingAnimation.swift
//  DesignKit
//
//  Created by Fernando de Lucas da Silva Gomes on 11/06/22.
//  Copyright © 2022 Marker. All rights reserved.
//

import Foundation
import UIKit

public class DSShakingAnimation: DSAnimationProtocol {
    
    private var view: UIView?
    private var animation: CAKeyframeAnimation = .init(keyPath: "transform.rotation.z")

    init () {}
    
    public func viewForAnimation(_ view: UIView) {
        self.view = view
    }

    public func animate() {
        guard let view = view else {
            return
        }
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.2
        animation.values = [0.015, 0.03, 0.015, 0, -0.015, -0.03, -0.015, 0]
        animation.repeatDuration = .infinity
        view.layer.add(animation, forKey: "shaking")
    }
    
    public func stop() {
        view?.layer.removeAnimation(forKey: "shaking")
    }
}
