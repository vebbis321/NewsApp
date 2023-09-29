//
//  Array+Extensions.swift
//  NewsApp
//
//  Created by Vebjørn Daniloff on 9/28/23.
//

import Foundation

public extension Array where Element: Hashable {
    func uniqued() -> [Element] {
        var seen = Set<Element>()
        return filter { seen.insert($0).inserted }
    }
}
