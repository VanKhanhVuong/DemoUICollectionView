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
    let api = APIClient()
    
    func getWeatherApi() {
        api.getWeather { [weak self] result in
            switch result {
            case .success(let weather):
                print(weather)
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
    func getNewsApi(query: String) {
        listNews.removeAll()
        api.getNews(query: query) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let list):
                self.listNews = list
                self.delegate?.gotDataNews()
            case .failure(_):
                self.delegate?.gotError()
            }
        }
    }
}
