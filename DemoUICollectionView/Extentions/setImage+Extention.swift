//
//  setImage+Extention.swift
//  DemoUICollectionView
//
//  Created by admin on 22/03/2022.
//

import Foundation
import Kingfisher

extension UIImageView {
    func setImageWithUrl(url: String) {
        let url = URL(string: url)
        self.kf.setImage(with: url)
    }
}
