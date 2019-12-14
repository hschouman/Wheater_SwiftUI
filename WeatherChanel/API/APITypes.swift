//
//  APITypes.swift
//  WeatherChanel
//
//  Created by Hugo Schouman on 14/12/2019.
//  Copyright © 2019 CocoaConsulting. All rights reserved.
//

import Foundation

enum ServiceError: Error {
    case networkError
    case badStatusCode
    case parseError(Error)

    var description: StaticString {
        switch self {
        case .networkError:
            return "No network"
        case .badStatusCode:
            return "The code HTTP is not valid"
        case .parseError(let error):
            Logger.log(text: "%{PRIVATE}@", param: error.localizedDescription, level: .error)
            return "The JSON format is not valid"
        }
    }
}

protocol APIRequestType {
    associatedtype Response: Decodable

    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
}
