//
//  NewsAPI.swift
//  DemoUICollectionView
//
//  Created by admin on 24/03/2022.
//

import Foundation

enum NewsAPI {
    case getNews(query: String)
}

extension NewsAPI: TargetType {
    var param: String {
        switch self {
        case .getNews(let query):
            return "q=\(query)&from=\(year)-\(month)-\(day)&sortBy=publishedAt&apiKey=" + apiKeyNews
        }
    }
    
    var baseURL: String {
        baseUrlNews
    }
    
    var url: URL? {
        guard let url = URL(string: self.baseURL + self.param) else { return nil }
        return url
    }
}
