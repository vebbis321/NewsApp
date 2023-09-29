//
//  ArticleDetailsViewController.swift
//  NewsApp
//
//  Created by Vebjørn Daniloff on 9/29/23.
//

import UIKit
import SwiftUI
import Combine

final class ArticleDetailsViewController: UIViewController {

    // MARK: - Private Components
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()

    // MARK: - Private properties
    private var dataSource: DataSource!
    private var snapshot: Snapshot!

    private var viewModel: ArticleDetailsViewModel

    // MARK: - LifeCycle
    init(article: Article) {
        self.viewModel = .init(article: article)
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable) required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configureDataSource()
        updateSnapshot(animated: false)
    }

    // MARK: - setup
    private func setup() {
        title = viewModel.source

        view.backgroundColor = .appColor(.background)
        view.addSubview(collectionView)
    }

    // MARK: - CollectionView layout
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnv in
            return .createDetailsViewLayout()
        }
        return layout
    }

    // MARK: - CollectionView dataSource
    private func configureDataSource() {

        let headerRegistration = UICollectionView.SupplementaryRegistration<ImageHeaderCell>(elementKind: UICollectionView.elementKindSectionHeader) { [weak self] headerView, elementkind, indexPath in
            guard let self = self else { fatalError() }
            headerView.configure(with: self.viewModel.imgUrl)
        }

        let detailsContentCellRegistration = UICollectionView.CellRegistration<ArticleContentDetailsCell, ArticleDetailsViewModel> { cell, _, viewModel in
            cell.configure(with: viewModel)
        }

        dataSource = .init(collectionView: collectionView) { collectionView, indexPath, item in
            return collectionView.dequeueConfiguredReusableCell(
                using: detailsContentCellRegistration,
                for: indexPath,
                item: item
            )
        }

        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            let header = collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
            return header
        }
    }

    // MARK: - Update snapshot
    @MainActor
    private func updateSnapshot(animated: Bool = true) {
        snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems([viewModel], toSection: 0)

        dataSource.apply(snapshot, animatingDifferences: animated)
    }
}

extension ArticleDetailsViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, ArticleDetailsViewModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, ArticleDetailsViewModel>
}



