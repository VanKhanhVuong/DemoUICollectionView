//
//  News.swift
//  DemoUICollectionView
//
//  Created by admin on 22/03/2022.
//

import Foundation

struct DataNews: Decodable {
    var status: String?
    var articles: [Articles]?
    
    private enum CodingKeys: String, CodingKey {
        case status = "status"
        case articles = "articles"
    }
}

struct Articles: Decodable {
    var source: Source?
    var author: String?
    var title: String?
    var description: String?
    var urlToImage: String?
    
    private enum CodingKeys: String, CodingKey {
        case source = "source"
        case author = "author"
        case title = "title"
        case description = "description"
        case urlToImage = "urlToImage"
    }
}

struct Source: Decodable {
    var id: String?
    var name: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}
