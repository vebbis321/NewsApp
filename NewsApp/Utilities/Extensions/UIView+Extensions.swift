//
//  UIView+Extensions.swift
//  NewsApp
//
//  Created by Vebjørn Daniloff on 9/28/23.
//

import UIKit

extension UIView {
    // MARK: - pin
    func pin(to superView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        leftAnchor.constraint(equalTo: superView.leftAnchor).isActive = true
        rightAnchor.constraint(equalTo: superView.rightAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
    }

    // MARK: - anchor
    func anchor(
        top: NSLayoutYAxisAnchor? = nil,
        paddingTop: CGFloat = 0,
        bottom: NSLayoutYAxisAnchor? = nil,
        paddingBottom: CGFloat = 0,
        left: NSLayoutXAxisAnchor? = nil,
        paddingLeft: CGFloat = 0,
        right: NSLayoutXAxisAnchor? = nil,
        paddingRight: CGFloat = 0,
        height: NSLayoutDimension? = nil,
        width: NSLayoutDimension? = nil,
        heightConstant: CGFloat = 0,
        widthConstant: CGFloat = 0,
        centerX: NSLayoutXAxisAnchor? = nil,
        centerY: NSLayoutYAxisAnchor? = nil
    ) {
        if let top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        if let right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if let left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let height {
            heightAnchor.constraint(equalTo: height).isActive = true
        }
        if let width {
            widthAnchor.constraint(equalTo: width).isActive = true
        }
        if widthConstant != 0 {
            widthAnchor.constraint(equalToConstant: widthConstant).isActive = true
        }
        if heightConstant != 0 {
            heightAnchor.constraint(equalToConstant: heightConstant).isActive = true
        }
        if let centerX {
            centerXAnchor.constraint(equalTo: centerX).isActive = true
        }
        if let centerY {
            centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
    }
    
    // MARK: - Custom init
    convenience init(withAutolayout: Bool) {
        self.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = !withAutolayout
    }

    // MARK: - drop shadow
    func addDropShadow() {
        backgroundColor = .appColor(.background)
        layer.shadowColor = UIColor.appColor(.tint)?.withAlphaComponent(0.3).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2.0)
        layer.shadowRadius = 3.0
        layer.shadowOpacity = 1.0

        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 10).cgPath
        layer.cornerRadius = 10

        layer.masksToBounds = false
    }

}
