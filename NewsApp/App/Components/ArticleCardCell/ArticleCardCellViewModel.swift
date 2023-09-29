//
//  ArticleCardCellViewModel.swift
//  NewsApp
//
//  Created by Vebjørn Daniloff on 9/28/23.
//

import Foundation

struct ArticleCardCellViewModel {
    var article: Article

    var title: String {
        article.title ?? "N/A"
    }

    var imgUrl: String? {
        article.urlToImage
    }

}
