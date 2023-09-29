//
//  UICollecionView+Layouts.swift
//  NewsApp
//
//  Created by Vebjørn Daniloff on 9/28/23.
//

import UIKit

extension NSCollectionLayoutSection {
    // MARK: - News
    static func createNewsLayout() -> NSCollectionLayoutSection {
        let inset: CGFloat = 5

        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )

        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(270)
        )

        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        group.contentInsets = .init(top: inset, leading: inset, bottom: inset, trailing: inset)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10

        section.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)

        return section
    }

    // MARK: - News
    static func createDetailsViewLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )

        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(240)
        )

        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [
            .init(
                layoutSize: .init(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(200)),
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
        ]

        section.contentInsets = .init(top: 10, leading: 0, bottom: 10, trailing: 0)

        return section
    }

}
