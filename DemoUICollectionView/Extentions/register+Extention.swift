//
//  register+Extention.swift
//  DemoUICollectionView
//
//  Created by admin on 22/03/2022.
//

import UIKit

extension UICollectionView {
    public func register<T: UICollectionViewCell>(cellType: T.Type) {
        let className = cellType.className
        register(T.self, forCellWithReuseIdentifier: className)
    }
    
    public func dequeueReusableCell<T: UICollectionViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: type.className, for: indexPath) as! T
    }
}
