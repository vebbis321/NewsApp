//
//  ArticleCardCell.swift
//  NewsApp
//
//  Created by Vebjørn Daniloff on 9/28/23.
//

import UIKit

final class ArticleCardCell: UICollectionViewCell {

    // MARK: - Private components
    private lazy var vStack: UIStackView = {
        let stack: UIStackView = UIStackView(frame: .zero)
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 8
        return stack
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(withAutolayout: true)
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 10
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        imageView.layer.masksToBounds = true
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = PaddingLabel(withInsets: 0, 8, 5, 5)
        label.font = .preferredFont(forTextStyle: .footnote)
        label.textAlignment = .left
        label.numberOfLines = 2
        label.textColor = .appColor(.tint)
        return label
    }()

    // MARK: - Private properties
    private var task: Task<Void, Error>?

    // MARK: - LifeCycle
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        titleLabel.text = nil
        task?.cancel()
        task = nil
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            contentView.addDropShadow()
        }
    }

    // MARK: - setup
    private func setup() {
        vStack.addArrangedSubview(imageView)
        vStack.addArrangedSubview(titleLabel)

        contentView.addDropShadow()
        contentView.addSubview(vStack)

        imageView.anchor(heightConstant: 200)

        vStack.pin(to: contentView)
    }

    // MARK: - Internal methods
    func configure(with viewModel: ArticleCardCellViewModel) {
        titleLabel.text = viewModel.title
        imageView.image = UIImage(named: "placeholder")

        guard let url = viewModel.imgUrl else { return }

        task = Task {
            await imageView.loadUrlImage(with: url)
        }
    }
}
