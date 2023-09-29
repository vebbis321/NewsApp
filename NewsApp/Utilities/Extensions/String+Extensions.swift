//
//  String+Extensions.swift
//  NewsApp
//
//  Created by Vebjørn Daniloff on 9/28/23.
//

import Foundation

extension String {
    enum JsonFile: String {
        case newsResponse = "newsResponse"
    }

    static func getJsonStr(for file: JsonFile) -> String {
        file.rawValue
    }
}
