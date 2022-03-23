//
//  setImage+Extention.swift
//  DemoUICollectionView
//
//  Created by admin on 22/03/2022.
//

import SDWebImage
import UIKit

extension UIImageView {
    func setImageWithUrl(url: String) {
        let url = URL(string: url)
        self.sd_setImage(with: url, placeholderImage: UIImage(named: "empty"), options: [])
    }
}
