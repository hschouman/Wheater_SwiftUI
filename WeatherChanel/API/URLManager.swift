//
//  URLManager.swift
//  WeatherChanel
//
//  Created by Hugo Schouman on 13/12/2019.
//  Copyright © 2019 CocoaConsulting. All rights reserved.
//

import Foundation

struct URLManager {

    // MARK: - Init
    init() {
        fatalError("This object should be used as static only")
    }

    // MARK: - Func
    static func createURL(from url: URL, basePath: String?, path: String?, params: Dictionary<String, String?>?) -> URL? {
        guard var components = URLComponents(string: url.absoluteString) else {
            return nil
        }

        switch (basePath, path) {
        case (.none, .none):
            break
        case (.some(let value1), .none):
            components.path = value1
        case (.none, .some(let value2)):
            components.path = value2
        case (.some(let value1), .some(let value2)):
            components.path = value1+value2
        }

        if let items = (params?.map { URLQueryItem(name: $0.key, value: $0.value) }) {
            components.queryItems = items
        }

        return components.url
    }

    static func add(queryItem: URLQueryItem, to url: URL) -> URL? {
        var components = URLComponents(string: url.absoluteString)
        components?.queryItems?.append(queryItem)
        return components?.url
    }
}
