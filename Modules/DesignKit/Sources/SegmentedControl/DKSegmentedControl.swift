//
//  DKSegmentedControl.swift
//  Marker
//
//  Created by Fernando de Lucas da Silva Gomes on 15/03/22.
//  Copyright © 2022 Marker. All rights reserved.
//

import UIKit
import Strategy

public final class DKSegmentedControl: UISegmentedControl {

    private var leading = NSLayoutConstraint()

    private let segmentIndicator: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.systemPink
        return view
    }()

    override public init(items: [Any]?){
        super.init(items: items)
        self.translatesAutoresizingMaskIntoConstraints = false
       self.setBackgroundImage(UIImage(ciImage: .clear), for: .normal, barMetrics: .default)
        self.selectedSegmentIndex = 0
        configureColors()
        setupView()
    }

    @available (*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func configureColors() {
        self.selectedSegmentTintColor = .clear
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: DKColor.mainButtonColor], for: UIControl.State.selected)
        segmentIndicator.backgroundColor = DKColor.mainButtonColor
        segmentIndicator.tintColor = DKColor.mainButtonColor
    }

    public func indexChanged(newIndex: Int) {
        segmentIndicator.translatesAutoresizingMaskIntoConstraints = false
        leading.isActive = false
        leading = segmentIndicator.leadingAnchor.constraint(
            equalTo: self.leadingAnchor,
            constant: (((UIScreen.main.bounds.width)/3) * CGFloat(newIndex))+(20/2)
        )
        leading.isActive = true
        UIView.animate(
            withDuration: 0.2,
            animations: {
                self.layoutIfNeeded()
            }
        )
        configureColors()
    }

}

extension DKSegmentedControl: ViewCode {
    public func setupViewHierarchy() {
        self.addSubview(segmentIndicator)
    }

    public func setupConstraints() {
        buildSegmentedIndicatorConstraints()
    }

    private func buildSegmentedIndicatorConstraints() {
        segmentIndicator.translatesAutoresizingMaskIntoConstraints = false
        segmentIndicator.topAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        segmentIndicator.heightAnchor.constraint(equalToConstant: 10).isActive = true
        leading.isActive = false
        leading = segmentIndicator.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: (((UIScreen.main.bounds.width)/3) * CGFloat(self.selectedSegmentIndex))+(20/2))
        leading.isActive = true
        segmentIndicator.widthAnchor.constraint(equalToConstant: CGFloat((UIScreen.main.bounds.width)/3)-20).isActive = true
    }
}
