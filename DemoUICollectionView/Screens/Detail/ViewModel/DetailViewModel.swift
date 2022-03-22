//
//  DetailViewModel.swift
//  DemoUICollectionView
//
//  Created by admin on 22/03/2022.
//

import Foundation
protocol DetailViewModelEvents: AnyObject {
    func gotData()
}


class DetailViewModel {
    var itemProduct: Product = Product()
    weak var delegate: DetailViewModelEvents?
    
    func getData() {
        delegate?.gotData()
    }
}
