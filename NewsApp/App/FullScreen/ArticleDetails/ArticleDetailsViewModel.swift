//
//  ArticleDetailsView.swift
//  NewsApp
//
//  Created by Vebjørn Daniloff on 9/29/23.
//

import Foundation

struct ArticleDetailsViewModel: Hashable {
    var article: Article

    var author: String {
        article.author ?? ""
    }

    var date: String {
        if let publishedStr = article.publishedAt {
            return publishedStr.components(separatedBy: "T")[0]
        } else {
            return ""
        }
    }

    var imgUrl: String? {
        article.urlToImage
    }

    var source: String {
        article.source?.name ?? ""
    }

    var title: String {
        article.title ?? ""
    }

    var content: String {
        if let content = article.content {
            return content.components(separatedBy: "[")[0] + " read more"
        } else {
            return "Content not available..."
        }
    }

    var contentUrl: String {
        article.url ?? ""
    }
}



