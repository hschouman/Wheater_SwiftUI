//
//  AppService.swift
//  WeatherChanel
//
//  Created by Hugo Schouman on 13/12/2019.
//  Copyright © 2019 CocoaConsulting. All rights reserved.
//

import Foundation

protocol Service {
    var path: String { get }
}

protocol AppServiceProtocol {
    func fetch<Object: Decodable>(onPath path: String?, withParams params: Dictionary<String, String?>?, shouldUseAppId: Bool, completion: @escaping (Result<Object, ServiceError>) -> ())
}

struct AppService: AppServiceProtocol {

    // MARK: - Constants
    enum Constant: String {
        case baseURL = "http://api.openweathermap.org"
        case basePath = "/data/2.5"
        case apiKeyName = "appid"
        case apiKeyValue = "ead2be695e935e8a560ac3b0ede63005"
    }

    // MARK: - Var
    let network: NetworkProtocol = Network()

    func fetch<Object: Decodable>(onPath path: String?, withParams params: Dictionary<String, String?>?, shouldUseAppId: Bool,
                                  completion: @escaping (Result<Object, ServiceError>) -> ()) {

        guard let baseURL = URL(string: Constant.baseURL.rawValue),
            var url = URLManager.createURL(from: baseURL, basePath: Constant.basePath.rawValue, path: path, params: params) else {
                completion(.failure(.urlWithBadFormat))
                return
        }

        if shouldUseAppId {
            let queryItem = URLQueryItem(name: Constant.apiKeyName.rawValue, value: Constant.apiKeyValue.rawValue)
            guard let newUrl = URLManager.add(queryItem: queryItem, to: url) else {
                completion(.failure(.urlWithBadFormat))
                return
            }
            url = newUrl
        }
        network.fetch(from: url, completion: completion)
    }
}
