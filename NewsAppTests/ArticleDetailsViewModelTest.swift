//
//  ArticleDetailsViewModelTest.swift
//  NewsAppTests
//
//  Created by Vebjørn Daniloff on 9/29/23.
//

import XCTest
@testable import NewsApp

final class ArticleDetailsViewModelTest: XCTestCase {

    func testInitFromArticle() {
        let article = createArticle(
            author: "Vebjorn",
            date: "27/03/22T",
            imgUrl: "google.com",
            source: "NRK",
            title: "Some important news!",
            content: "Some content!",
            contentUrl: "nrk.no"
        )

        let sut = ArticleDetailsViewModel(article: article)

        XCTAssertEqual(sut.author, article.author)
        XCTAssertEqual(sut.date, article.publishedAt?.components(separatedBy: "T")[0])
        XCTAssertEqual(sut.imgUrl, article.urlToImage)
        XCTAssertEqual(sut.source, article.source?.name)
        XCTAssertEqual(sut.title, article.title)
        XCTAssertEqual(sut.content, (article.content?.components(separatedBy: "[")[0])! + " read more")
        XCTAssertEqual(sut.contentUrl, article.url)
    }

    func testOptionalInitFromArticle() {
        let article = createArticle(author: nil, date: nil, imgUrl: nil, source: nil, title: nil, content: nil, contentUrl: nil)

        let sut = ArticleDetailsViewModel(article: article)

        XCTAssertEqual(sut.author, "")
        XCTAssertEqual(sut.date, "")
        XCTAssertEqual(sut.imgUrl, nil)
        XCTAssertEqual(sut.source, "")
        XCTAssertEqual(sut.title, "")
        XCTAssertEqual(sut.content, "Content not available...")
        XCTAssertEqual(sut.contentUrl, "")
    }

    private func createArticle(
        author: String?,
        date: String?,
        imgUrl: String?,
        source: String?,
        title: String?,
        content: String?,
        contentUrl: String?
        
    ) -> Article {
        Article(
            source: .init(id: nil, name: source),
            author: author,
            title: title,
            description: nil,
            url: contentUrl,
            urlToImage: imgUrl,
            publishedAt: date,
            content: content
        )
    }
}


