//
//  NewsViewController.swift
//  NewsApp
//
//  Created by Vebjørn Daniloff on 9/28/23.
//

import UIKit
import Combine

final class NewsViewController: UIViewController {

    // MARK: - Private components
    private lazy var contentStateVC = ContentStateViewController()
    private lazy var contentVC: NewsContentViewController? = nil

    private lazy var filterButton: UIBarButtonItem = .navBarButton(name: "slider.horizontal.3", action: #selector(tappedFilter), target: self)

    private lazy var ligthDarkToggleButton: UIBarButtonItem = {
        let btn: UIBarButtonItem = .navBarButton(name: mode.setIcon(), action: #selector(toggleDarkLightMode), target: self)
        btn.accessibilityIdentifier = "LigthDarkToggleButton"
        return btn
    }()

    // MARK: - Private properties
    private let viewModel: NewsViewModel
    private var subscriptions = Set<AnyCancellable>()

    private lazy var mode: DarkMode = .init(userInterfaceStyle: traitCollection.userInterfaceStyle) {
        didSet {
            modeChanged()
        }
    }

    // MARK: - LifeCycle
    init(viewModel: NewsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bind()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }

    // MARK: - setup
    private func setup() {
        title = "News"
        view.backgroundColor = .appColor(.background)

        filterButton.isEnabled = false
        navigationItem.leftBarButtonItem = filterButton
        navigationItem.rightBarButtonItem = ligthDarkToggleButton

        add(contentStateVC)
    }

    // MARK: - bind
    private func bind() {
        viewModel
            .state
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                switch state {

                case let .loaded(data):
                    self?.render(data)
                    self?.filterButton.isEnabled = true

                case .error(let error):
                    self?.render(error)
                    self?.filterButton.isEnabled = false
                }
            }.store(in: &subscriptions)
    }

    // MARK: - Private methods
    private func render(_ data: [Article]) {
        if contentStateVC.shownViewController == contentVC {
            contentVC?.snapData = data
        } else {
            contentVC = NewsContentViewController(snapData: data)
            contentVC?.delegate = self
            contentStateVC.transition(to: .render(contentVC!))
        }
    }

    private func render(_ error: NewsError) {
        contentStateVC.transition(to: .failed(error, action: viewModel.loadArticlesFromAPI))
    }

    private func modeChanged() {
        let window = UIApplication.shared.keyWindow
        window?.overrideUserInterfaceStyle = mode.setUserInterfaceStyle()
        ligthDarkToggleButton.image = .init(systemName: mode.setIcon())
    }

    // MARK: - Private actions
    @objc private func tappedFilter() {
        viewModel.openFilter()
    }

    @objc private func toggleDarkLightMode() {
        mode = mode.toggle()
    }
}

// MARK: - NewsContentViewControllerDelegate
extension NewsViewController: NewsContentViewControllerDelegate {
    func didTap(_ article: Article) {
        viewModel.tappedArticle(article)
    }
}

extension NewsViewController {
    enum DarkMode {
        case on
        case off

        func setIcon() -> String {
            switch self {
            case .on:
                return "sun.min"
            case .off:
                return "moon"
            }
        }

        func setUserInterfaceStyle() -> UIUserInterfaceStyle {
            self == .on ? .dark : .light
        }

        func toggle() -> DarkMode {
            return self == .off ? .on : .off
        }

        init(userInterfaceStyle: UIUserInterfaceStyle) {
            self = userInterfaceStyle == .dark ? .on : .off
        }
    }
}

