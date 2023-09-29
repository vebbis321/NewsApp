//
//  ImageHeaderCell.swift
//  NewsApp
//
//  Created by Vebjørn Daniloff on 9/29/23.
//

import UIKit

final class ImageHeaderCell: UICollectionReusableView {
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleToFill
        return imageView
    }()

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)

        addSubview(imageView)
        imageView.pin(to: self)
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with urlString: String?) {
        imageView.image = UIImage(named: "placeholder")

        guard let urlString = urlString else { return }

        Task {
            await imageView.loadUrlImage(with: urlString)
        }
    }
}
