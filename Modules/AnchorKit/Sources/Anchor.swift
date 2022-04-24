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
      private func anchor<T, S>(
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
      private func anchor<T, Axis, S>(
                          _ from: KeyPath<UIView, T>,
                          on referenceView: S,
                          equal to: KeyPath<S, T>,
                          constant: CGFloat = 0
                          ) -> Self where T: NSLayoutAnchor<Axis> {
              self[keyPath: from].constraint(equalTo: referenceView[keyPath: to], constant: constant).isActive = true
              return self
      }
    
    @discardableResult
    private func anchor<T>(
                        _ from: KeyPath<UIView, T>,
                        constant: CGFloat = 0
                        ) -> Self where T: NSLayoutDimension {
            self[keyPath: from].constraint(equalToConstant: constant).isActive = true
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
    
    public func anchorToVerticalEdges<S>(of referenceView: S, withSpace padding: CGFloat = 0) where S: UIView {
        prepareForLayout()
        self.anchor(\.topAnchor, on: referenceView, equal: \.topAnchor, constant: padding)
        self.anchor(\.bottomAnchor, on: referenceView, equal: \.bottomAnchor, constant: -padding)
    }
    
    public func anchorToTop<S>(of referenceView: S) where S: UILayoutGuide{
        prepareForLayout()
        self.anchor(\.topAnchor, on: referenceView, equal: \.topAnchor)
    }
    
    public func anchorToBottom<S>(of referenceView: S) where S: UILayoutGuide{
        prepareForLayout()
        self.anchor(\.bottomAnchor, on: referenceView, equal: \.bottomAnchor)
    }
    
    public func anchorTopToBottom<S>(of referenceView: S) where S: UIView{
        prepareForLayout()
        self.anchor(\.topAnchor, on: referenceView, equal: \.bottomAnchor)
    }

    public func anchorToLeading<S>(of referenceView: S) where S: UIView{
        prepareForLayout()
        self.anchor(\.leadingAnchor, on: referenceView, equal: \.leadingAnchor)
    }

    public func anchorToTrailing<S>(of referenceView: S) where S: UIView{
        prepareForLayout()
        self.anchor(\.leadingAnchor, on: referenceView, equal: \.leadingAnchor)
    }
    
    public func anchorWidth<S>(
        basedOn referenceView: S,
        withSize size: CGFloat
    ) where S: UIView{
        prepareForLayout()
        self.anchor(\.widthAnchor, on: referenceView, equal: \.widthAnchor, multiplier: size)
    }
    
    public func anchorWidth(
        withSize size: CGFloat
    ) {
        prepareForLayout()
        self.anchor(\.widthAnchor, constant: size)
    }
    
    public func anchorHeight<S>(
        basedOn referenceView: S,
        withSize size: CGFloat
    ) where S: UIView{
        prepareForLayout()
        self.anchor(\.heightAnchor, on: referenceView, equal: \.heightAnchor, multiplier: size)
    }
    
    public func anchorHeight(
        withSize size: CGFloat
    ) {
        prepareForLayout()
        self.anchor(\.heightAnchor, constant: size)
    }
}
