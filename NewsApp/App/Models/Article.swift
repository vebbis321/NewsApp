//
//  News.swift
//  NewsApp
//
//  Created by Vebjørn Daniloff on 9/28/23.
//

import Foundation

struct NewsRepsonseObject: Codable {
    var status: String
    var totalResults: Int?
    var articles: [Article]?

    var code: String?
    var message: String?

    
}

struct Article: Codable, Hashable {

    var source: Source?

    struct Source: Codable, Hashable {
        var id: String?
        var name: String?
    }

    var author: String?
    var title: String?
    var description: String?

    var url: String?
    var urlToImage: String?

    var publishedAt: String?
    var content: String?
}

