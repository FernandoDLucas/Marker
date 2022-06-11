//
//  UIViewController+Extensions.swift
//  DesignKit
//
//  Created by Fernando de Lucas da Silva Gomes on 11/06/22.
//  Copyright © 2022 Marker. All rights reserved.
//

import UIKit

extension UIViewController {
    public func setupNavigationBar(
        title: String? = nil,
        navColor: UIColor?,
        barColor: UIColor?
    ) {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = false

            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = navColor
            appearance.shadowImage = UIImage()
            appearance.shadowColor = .clear

            appearance.titleTextAttributes = [
                .foregroundColor: barColor as Any
            ]

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
}

