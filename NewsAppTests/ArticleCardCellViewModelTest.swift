//
//  NewsAppTests.swift
//  NewsAppTests
//
//  Created by Vebjørn Daniloff on 9/28/23.
//

import XCTest
@testable import NewsApp

final class ArticleCardCellViewModelTest: XCTestCase {

    func testInitFromArticle() {
        let article = createArticle(title: "This is some title!", imgUrl: "https://google.com")

        let sut = ArticleCardCellViewModel(article: article)

        XCTAssertEqual(sut.title, article.title)
        XCTAssertEqual(sut.imgUrl, article.urlToImage)
    }

    func testOptionalInitFromArticle() {
        let article = createArticle(title: nil, imgUrl: nil)

        let sut = ArticleCardCellViewModel(article: article)

        XCTAssertEqual(sut.title, "N/A")
        XCTAssertEqual(sut.imgUrl, nil)
    }

    private func createArticle(title: String?, imgUrl: String?) -> Article {

        Article(
            source: nil,
            author: nil,
            title: title,
            description: nil,
            url: nil,
            urlToImage: imgUrl,
            publishedAt: nil,
            content: nil
        )
    }
}

