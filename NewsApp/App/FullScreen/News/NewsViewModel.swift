//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Vebjørn Daniloff on 9/28/23.
//

import Foundation
import Combine
import Network

final class NewsViewModel: ObservableObject {

    weak var navigation: NewsNavigatable?
    var state = PassthroughSubject<State, Never>()

    private var apiService: NewsAPIServiceProtocol
    private let monitor = NWPathMonitor()

    var articles = [Article]()
    var selectedSources = Set<String>()

    init(apiService: NewsAPIServiceProtocol) {
        self.apiService = apiService

        monitor.pathUpdateHandler = { [weak self] path in
            if path.status == .satisfied {
                self?.loadArticlesFromAPI()
            } else {
                self?.loadArticlesFromdocumentsDirectory()
            }
        }

        monitor.start(queue: .init(label: "Monitor"))
    }

    func loadArticlesFromAPI() {
        monitor.cancel()

        Task {
            do {
                articles = try await apiService.getArticles(amount: 20).filter { $0.url != "https://removed.com" }
                state.send(.loaded(articles))

            } catch {
                state.send(.error(.default(error)))
            }
        }
    }

    private func loadArticlesFromdocumentsDirectory() {
        monitor.cancel()

        do {
            let articles = try FileManager().decode(NewsRepsonseObject.self, from: .getJsonStr(for: .newsResponse)).articles ?? []
            state.send(.loaded(articles))
        } catch {
            state.send(.error(.default(error)))
        }
    }

    func openFilter() {
        let sources = articles.compactMap(\.source?.name).uniqued().sorted(by: { $1 > $0 })

        navigation?.showFilter(selectedSources: selectedSources, sources: sources, selectionChanged: { [weak self] selection in
            guard let self = self else { return }

            if selection.isEmpty {
                self.selectedSources.removeAll()
                self.state.send(.loaded(self.articles))

            } else {
                self.selectedSources = selection

                let articlesForSources = self.articles.filter({ selection.contains($0.source?.name ?? "") })
                self.state.send(.loaded(articlesForSources))
            }
        })
    }

    func tappedArticle(_ article: Article) {
        navigation?.tapped(article: article)
    }
}

extension NewsViewModel {
    enum State {
        case loaded([Article])
        case error(NewsError)
    }
}
