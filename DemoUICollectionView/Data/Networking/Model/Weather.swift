//
//  Weather.swift
//  DemoUICollectionView
//
//  Created by admin on 24/03/2022.
//

import Foundation

struct DataWeather: Codable {
    var base: String?
    var main: Main?
    
    
    private enum CodingKeys: String, CodingKey {
        case base = "base"
        case main = "main"
    }
}

struct Main: Codable {
    var temp: Float?
    
    private enum CodingKeys: String, CodingKey {
        case temp = "temp"
    }
}
