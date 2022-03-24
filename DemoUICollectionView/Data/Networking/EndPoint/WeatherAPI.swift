//
//  WeatherAPI.swift
//  DemoUICollectionView
//
//  Created by admin on 24/03/2022.
//

import Foundation

enum WeatherAPI{
    case getWeather
}

extension WeatherAPI: TargetType {
    var baseURL: String {
        baseUrlWeather
    }
    
    var param: String {
        "lat=10.800306&lon=106.721854&appid=" + apiKeyWeather
    }
    
    var url: URL? {
        guard let url = URL(string: self.baseURL + self.param) else { return nil }
        return url
    }
}
