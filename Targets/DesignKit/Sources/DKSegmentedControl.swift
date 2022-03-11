//
//  DKSegmentedControl.swift
//  Marker
//
//  Created by Fernando de Lucas da Silva Gomes on 15/03/22.
//  Copyright © 2022 Marker. All rights reserved.
//

import UIKit
import AnchorKit

public final class DKSegmentedControl: UIView {
    
    private var stackView = UIStackView()
    private var items: [String]

    init(items: [String]) {
        self.items = items
        super.init(frame: .zero)
        build()
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func build() {
        items.forEach {
            let view = DKSegmentedItem(named: $0)
            stackView.addArrangedSubview(view)
        }
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
    }

    func update(_ stri: String) {

    }
}

extension DKSegmentedControl: ViewCode {
    public func setupViewHierarchy() {
        addSubview(stackView)
    }
    
    public func setupConstraints() {
        stackView.anchorToHorizontalEdges(of: self, withSpace: 17)
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true 
        stackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}

public class DKSegmentedItem: UIView {
    
    public enum State {
        case enabled, disabled
    }
    
    private (set) var state: State = .enabled

    init(named: String) {
        super.init(frame: .zero)
        self.backgroundColor = DKColor.mainButtonColor
        self.tintColor = DKColor.labelColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func toogleState(for state: State) {
        self.state = state
    }
    
}

extension DKSegmentedItem: ViewCode {
    public func setupViewHierarchy() {
        
    }
    
    public func setupConstraints() {
    }
    
}

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
