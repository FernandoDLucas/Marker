//
//  Anchor.swift
//  Marker
//
//  Created by Fernando de Lucas da Silva Gomes on 15/03/22.
//  Copyright © 2022 Marker. All rights reserved.
//

import UIKit

public protocol Anchor: UIView {}

extension UIView: Anchor {}

extension Anchor {
      func prepareForLayout() {
          self.translatesAutoresizingMaskIntoConstraints = false
      }

      @discardableResult
      func anchor<T, S>(
                      _ from: KeyPath<UIView, T>,
                      on referenceView: S,
                      equal to: KeyPath<S, T>,
                      multiplier: CGFloat
                      ) -> Self where T: NSLayoutDimension {
              self[keyPath: from].constraint(
                equalTo: referenceView[keyPath: to],
                multiplier: multiplier
              ).isActive = true
              return self
      }

      @discardableResult
      func anchor<T, Axis, S>(
                          _ from: KeyPath<UIView, T>,
                          on referenceView: S,
                          equal to: KeyPath<S, T>,
                          constant: CGFloat = 0
                          ) -> Self where T: NSLayoutAnchor<Axis> {
              self[keyPath: from].constraint(equalTo: referenceView[keyPath: to], constant: constant).isActive = true
              return self
      }

      @discardableResult
      public func anchorToSafeArea<S>(of referenceView: S) -> Self where S: UILayoutGuide {
          prepareForLayout()
          self.anchor(\.topAnchor, on: referenceView, equal: \.topAnchor)
          self.anchor(\.leadingAnchor, on: referenceView, equal: \.leadingAnchor)
          self.anchor(\.trailingAnchor, on: referenceView, equal: \.trailingAnchor)
          self.anchor(\.bottomAnchor, on: referenceView, equal: \.bottomAnchor)
          return self
      }

      @discardableResult
      public func anchorToEdges<S>(of referenceView: S) -> Self where S: UIView {
          prepareForLayout()
          self.anchor(\.topAnchor, on: referenceView, equal: \.topAnchor)
          self.anchor(\.leadingAnchor, on: referenceView, equal: \.leadingAnchor)
          self.anchor(\.trailingAnchor, on: referenceView, equal: \.trailingAnchor)
          self.anchor(\.bottomAnchor, on: referenceView, equal: \.bottomAnchor)
          return self
      }
    
    public func anchorToHorizontalEdges<S>(of referenceView: S, withSpace padding: CGFloat = 0) where S: UIView {
        prepareForLayout()
        self.anchor(\.leadingAnchor, on: referenceView, equal: \.leadingAnchor, constant: padding)
        self.anchor(\.trailingAnchor, on: referenceView, equal: \.trailingAnchor, constant: -padding)
    }
}
