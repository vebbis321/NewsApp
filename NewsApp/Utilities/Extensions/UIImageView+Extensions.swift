//
//  UIImage+Extensions.swift
//  NewsApp
//
//  Created by Vebjørn Daniloff on 9/28/23.
//

import UIKit


extension UIImageView {
    func loadUrlImage(with urlString: String) async {
        guard let url = URL(string: urlString) else {
            return
        }

        if let cachedImage = ImageCache.shared.image(forKey: urlString)  {
            self.image = cachedImage
            return
        }

        guard let (data, _) = try? await URLSession.shared.data(from: url) else { return }

        if let image = UIImage(data: data) {
            await MainActor.run { [weak self] in
                ImageCache.shared.save(image: image, forKey: urlString)
                self?.image = image
            }
        }
    }
}
