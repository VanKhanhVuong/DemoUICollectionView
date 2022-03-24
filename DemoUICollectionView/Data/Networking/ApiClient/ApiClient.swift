//
//  ApiClient.swift
//  DemoUICollectionView
//
//  Created by admin on 24/03/2022.
//

import Foundation

class APIClient {
    func getNews(query: String, completionHandler: @escaping (_ result: Result<[Articles], ErrorModel>) -> ()) {
        APIManager.shared.requestApi(type: NewsAPI.getNews(query: query)) { (result: Result<DataArticles?, ErrorModel>) in
            switch result {
            case .success(let data):
                guard let news = data?.articles else {
                    completionHandler(.failure(ErrorModel.noData))
                    return
                }
                completionHandler(.success(news))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getWeather(completionHandler: @escaping (_ result: Result<Main, ErrorModel>) -> ()) {
        APIManager.shared.requestApi(type: WeatherAPI.getWeather) { (result: Result<DataWeather?, ErrorModel>) in
            switch result {
            case .success(let data):
                guard let weather = data?.main else {
                    completionHandler(.failure(ErrorModel.noData))
                    return
                }
                completionHandler(.success(weather))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
