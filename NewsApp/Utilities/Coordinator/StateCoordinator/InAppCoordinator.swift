//
//  InAppCoordinator.swift
//  NewsApp
//
//  Created by Vebjørn Daniloff on 9/28/23.
//

import UIKit

protocol NewsNavigatable: AnyObject {
    func tapped(article: Article)
    func showFilter(selectedSources: Set<String>, sources: [String], selectionChanged: ((Set<String>)->Void)?)
}

final class InAppCoordinator: StateCoordinator {

    weak var parentCoordinator: ApplicationCoordinator?

    var rootViewController: UINavigationController = .init()

    func start() {
        let viewModel = NewsViewModel(apiService: NewsAPIService())
        viewModel.navigation = self

        let vc = NewsViewController(viewModel: viewModel)
        rootViewController.pushViewController(vc, animated: false)
    }
}

// MARK: - NewsDetailsNavigatable
extension InAppCoordinator: NewsNavigatable {
    func tapped(article: Article) {
        let vc = ArticleDetailsViewController(article: article)
        rootViewController.pushViewController(vc, animated: true)
    }

    func showFilter(selectedSources: Set<String>, sources: [String], selectionChanged: ((Set<String>)->Void)?) {
        // can add a new coordinator flow here
        let vc = NewsFilterViewController(sources: sources, selectedSources: selectedSources, selectionChanged: selectionChanged)
        let navVC = UINavigationController(rootViewController: vc)

        navVC.modalPresentationStyle = .pageSheet

        if let sheet = navVC.sheetPresentationController {
            sheet.detents = [.large()]
        }

        rootViewController.present(navVC, animated: true, completion: nil)
    }
}
