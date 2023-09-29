//
//  Colors.swift
//  NewsApp
//
//  Created by Vebjørn Daniloff on 9/28/23.
//

import SwiftUI

enum AssetsColor: String {
    case background = "Background"
    case tint = "Tint"
}

extension UIColor {
    static func appColor(_ name: AssetsColor) -> UIColor? {
        return UIColor(named: name.rawValue)
    }
}

extension Color {
    static func appColor(_ name: AssetsColor) -> Color? {
        return Color(name.rawValue)
    }
}
