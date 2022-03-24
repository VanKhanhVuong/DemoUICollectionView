//
//  HomeViewModel.swift
//  DemoUICollectionView
//
//  Created by admin on 22/03/2022.
//

import Foundation

protocol HomeViewModelEvents: AnyObject {
    func gotDataNews()
    func gotError()
}

class HomeViewModel {
    weak var delegate: HomeViewModelEvents?
    var listNews: [Articles] = []
    let api = ApiService()

    func getApi(query: String) {
        listNews.removeAll()
        api.getSearchResults(searchTerm: query, day: day, month: month, year: year) { [weak self] response, error in
            guard let self = self else { return }
            guard let result = response else { return }
            if !result.isEmpty {
                self.listNews = result
                self.delegate?.gotDataNews()
            } else {
                self.delegate?.gotError()
            }
        }
    }
}
