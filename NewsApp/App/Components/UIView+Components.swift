//
//  UIView+Components.swift
//  NewsApp
//
//  Created by Vebjørn Daniloff on 9/29/23.
//

import UIKit

extension UIView {
    // MARK: - Spacer
    enum Direction {
        case horizontal
        case vertical
    }

    static func createSpacer(direction: Direction) -> UIView {
        let view = UIView(withAutolayout: true)

        var spacerWidthConstr: NSLayoutConstraint!

        switch direction {
        case .horizontal:
            spacerWidthConstr = view.widthAnchor.constraint(equalToConstant: .greatestFiniteMagnitude)
        case .vertical:
            spacerWidthConstr = view.heightAnchor.constraint(equalToConstant: .greatestFiniteMagnitude)
        }

        spacerWidthConstr.priority = .defaultLow
        spacerWidthConstr.isActive = true
        return view
    }
}
