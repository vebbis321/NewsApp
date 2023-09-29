//
//  ArticleContentsDetailsCell.swift
//  NewsApp
//
//  Created by Vebjørn Daniloff on 9/29/23.
//

import UIKit

final class ArticleContentDetailsCell: UICollectionViewCell {
    // MARK: - Private components
    private lazy var hStack: UIStackView = {
        let stack: UIStackView = UIStackView(frame: .zero)
        stack.axis = .horizontal
        stack.distribution = .fill
        return stack
    }()

    private lazy var authorLabel: UILabel = {
        let label = UILabel(withAutolayout: true)
        label.font = .preferredFont(forTextStyle: .footnote)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.textColor = .appColor(.tint)
        return label
    }()

    private lazy var dateLabel: UILabel = {
        let label = UILabel(withAutolayout: true)
        label.font = .preferredFont(forTextStyle: .footnote)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.textColor = .appColor(.tint)
        return label
    }()

    private lazy var vStack: UIStackView = {
        let stack: UIStackView = UIStackView(frame: .zero)
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 10
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel(withAutolayout: true)
        label.font = .preferredFont(forTextStyle: .title3)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = .appColor(.tint)
        return label
    }()

    private lazy var contentTextView = TappableTextView()

    private lazy var verticalSpacer: UIView = .createSpacer(direction: .vertical)
    private lazy var horizontalSpacer: UIView = .createSpacer(direction: .horizontal)

    // MARK: - LifeCycle
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - setup
    private func setup() {
        // so the authors doesnt overlap date
        authorLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 200).isActive = true

        hStack.addArrangedSubview(authorLabel)
        hStack.addArrangedSubview(horizontalSpacer)
        hStack.addArrangedSubview(dateLabel)

        vStack.addArrangedSubview(hStack)
        vStack.addArrangedSubview(titleLabel)
        vStack.addArrangedSubview(contentTextView)
        vStack.addArrangedSubview(verticalSpacer)

        contentView.addSubview(vStack)
        vStack.pin(to: contentView)
    }


    // MARK: - Internal methods
    func configure(with viewModel: ArticleDetailsViewModel) {
        authorLabel.text = viewModel.author
        dateLabel.text = viewModel.date

        titleLabel.text = viewModel.title
        contentTextView.text = viewModel.content

        let linkText = "read more"
        contentTextView.addTappableTexts([linkText: viewModel.contentUrl])

    }
}
