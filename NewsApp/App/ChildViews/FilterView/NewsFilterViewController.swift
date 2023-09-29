//
//  FIlterViewController.swift
//  NewsApp
//
//  Created by Vebjørn Daniloff on 9/28/23.
//

import SwiftUI
import Combine

final class NewsFilterViewController: UIViewController {

    // MARK: - Private components
    private let viewModel: NewsFilterViewModel
    private var selectionChanged: ((Set<String>)->Void)?

    private var subscription: AnyCancellable?

    // MARK: - LifeCycle
    init(
        sources: [String],
        selectedSources: Set<String>,
        selectionChanged: ((Set<String>)->Void)?
    ) {
        self.viewModel = .init(sources: sources, selectedSources: selectedSources)
        self.selectionChanged = selectionChanged
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        listen()
    }

    // MARK: - setup
    func setup() {
        title = "Filter articles by source!"
        view.backgroundColor = .appColor(.background)

        navigationItem.leftBarButtonItem = .init(title: "Close", style: .done, target: self, action: #selector(tappedClose))
        navigationItem.rightBarButtonItem = .init(title: "Clear", style: .plain, target: self, action: #selector(tappedClear))

        let childView = UIHostingController(rootView: NewsFilterView(viewModel: viewModel))
        addChild(childView)
        view.addSubview(childView.view)
        childView.view.translatesAutoresizingMaskIntoConstraints = false
        childView.view.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor
        )
        childView.didMove(toParent: self)
    }

    // MARK: - listen
    private func listen() {
        subscription = viewModel
            .$selectedSources
            .sink { [weak self] selection in
                self?.selectionChanged?(selection)
            }
    }

    // MARK: - Private actions
    @objc private func tappedClear() {
        viewModel.clearSelection()
    }

    @objc private func tappedClose() {
        dismiss(animated: true)
    }
}
