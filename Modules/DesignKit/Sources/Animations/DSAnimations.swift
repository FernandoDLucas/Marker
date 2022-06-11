//
//  DSAnimations.swift
//  DesignKit
//
//  Created by Fernando de Lucas da Silva Gomes on 11/06/22.
//  Copyright © 2022 Marker. All rights reserved.
//

import Foundation
import UIKit

public protocol DSAnimationProtocol {
    func viewForAnimation(_ view: UIView)
    func animate()
    func stop()
}

public class DSAnimationResolver {
    
    public init () {}
    
    public func resolveAnimation(
        _ animationType: DSAnimationType
    ) -> DSAnimationProtocol{
        switch animationType {
        case .shakingAnimation:
            return DSShakingAnimation()
        }
    }
}

public enum DSAnimationType {
    case shakingAnimation
}
