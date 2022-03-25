//
//  ApiService.swift
//  DemoUICollectionView
//
//  Created by admin on 23/03/2022.
//

import Foundation

final class APIManager {
    let defaultSession = URLSession(configuration: .default)
    let reachability = Reachability()
    var dataTask: URLSessionDataTask?
    static var shared = APIManager()
    private init() { }
}

extension APIManager {
    func requestApi<T>(type: TargetType, completionHandler: @escaping (_ result: Result<T?, ErrorModel>) -> ()) where T: Codable {
        if reachability.isConnectedToNetwork() {
            dataTask?.cancel()
            
            guard let url = type.url else {
                completionHandler(.failure(ErrorModel.unknownError))
                return
            }
            
            dataTask = defaultSession.dataTask(with: url) { data, response, error in
                defer { self.dataTask = nil }
                if let response = response as? HTTPURLResponse {
                    if response.statusCode == 200 {
                        guard let responseData = data else {
                            completionHandler(.failure(ErrorModel.unknownError))
                            return
                        }
                        let decoder = JSONDecoder()
                        guard let result = try? decoder.decode(T.self, from: responseData) else {
                            completionHandler(.failure(ErrorModel.noData))
                            return
                        }
                        completionHandler(.success(result))
                    } else {
                        completionHandler(.failure(ErrorModel.init(responseDataStatus: response)))
                    }
                }
            }
            dataTask?.resume()
        } else {
            completionHandler(.failure(ErrorModel.notInternet))
        }
    }
}
