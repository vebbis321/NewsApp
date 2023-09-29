//
//  NewsViewModelTest.swift
//  NewsAppTests
//
//  Created by Vebjørn Daniloff on 9/29/23.
//

import Foundation
import XCTest
@testable import NewsApp

final class NewsViewModelTest: XCTestCase {
    func testViewModel() {
        let service = MockedNewsApiService()
        let viewModel = NewsViewModel(apiService: service)
        viewModel.loadArticlesFromAPI()

        XCTAssertEqual(viewModel.articles.count, 3)
        XCTAssertEqual(viewModel.selectedSources.count, 0)
    }
}

class MockedNewsApiService: NewsAPIServiceProtocol {
    func getArticles(amount: Int) async throws -> [NewsApp.Article] {
        let articles = [
            Article(source: .init(id: "", name: "NRK"), author: "some name", title: "some title", description: nil, url: nil, urlToImage: nil, publishedAt: nil, content: nil),
            Article(source: .init(id: "", name: "NBC"), author: "some name", title: nil, description: nil, url: nil, urlToImage: nil, publishedAt: nil, content: "some content"),
            Article(source: .init(id: "", name: "CNN"), author: "some name", title: "some title", description: nil, url: nil, urlToImage: nil, publishedAt: nil, content: nil)
        ]
        return articles
    }

}
