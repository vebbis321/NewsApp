//
//  UIViewController+Components.swift
//  NewsApp
//
//  Created by Vebjørn Daniloff on 9/28/23.
//

import UIKit

extension UIBarButtonItem {
    static func navBarButton(name: String, action: Selector, target: Any?) -> UIBarButtonItem {
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large)
        let image = UIImage(systemName: name, withConfiguration: config)
        let button = UIBarButtonItem(image: image, style: .plain, target: target, action: action)
        return button
    }
}
