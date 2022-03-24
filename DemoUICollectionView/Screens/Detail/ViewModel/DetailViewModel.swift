//
//  DetailViewModel.swift
//  DemoUICollectionView
//
//  Created by admin on 22/03/2022.
//

import Foundation
protocol DetailViewModelEvents: AnyObject {
    func gotData()
    func refreshData()
}

class DetailViewModel {
    
    var itemNews: Articles = Articles()
    weak var delegate: DetailViewModelEvents?
    var listNews: [Articles] = []
    
    func getData() {
        delegate?.gotData()
    }
    
    func refreshList() {
        delegate?.refreshData()
    }
    
    func clearData() {
        itemNews.urlToImage?.removeAll()
        itemNews.source?.name?.removeAll()
        itemNews.author?.removeAll()
        itemNews.title?.removeAll()
        itemNews.description?.removeAll()
    }
}
