//
//  ApiService.swift
//  DemoUICollectionView
//
//  Created by admin on 23/03/2022.
//

import Foundation

class ApiService {
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    func getSearchResults(searchTerm: String, day: Int, month: Int, year: Int, completion: @escaping (_ response: [Articles]?,_ error: ErrorModel?) -> Void) {
        dataTask?.cancel()
        guard var urlComponents = URLComponents(string: "https://newsapi.org/v2/everything?") else { return }
        urlComponents.query = "q=\(searchTerm)&from=\(year)-\(month)-\(day)&sortBy=publishedAt&apiKey=" + apiKey
        guard let url = urlComponents.url else { return }
        dataTask = defaultSession.dataTask(with: url) { data, response, error in
            defer { self.dataTask = nil }
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    guard let responseData = data else {
                        completion(nil,.none)
                        return
                    }
                    let decoder = JSONDecoder()
                    guard let result = try? decoder.decode(DataNews.self, from: responseData) else { return }
                    guard let resultData = result.articles else {
                        completion(nil,.noData)
                        return
                    }
                    if !resultData.isEmpty {
                        completion(resultData,nil)
                    }
                } else {
                    let errorResponse = ErrorModel(responseDataStatus: response)
                    completion(nil,errorResponse)
                }
            }
        }
        dataTask?.resume()
    }
}
