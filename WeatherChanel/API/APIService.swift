//
//  APIService.swift
//  WeatherChanel
//
//  Created by Hugo Schouman on 13/12/2019.
//  Copyright © 2019 CocoaConsulting. All rights reserved.
//

import Foundation
import Combine

protocol APIServiceType {
    func response<Request>(from request: Request) -> AnyPublisher<Request.Response, ServiceError> where Request: APIRequestType
}

final class APIService: APIServiceType {

    private let baseURL: URL
    init(baseURL: URL = URL(string: "http://api.openweathermap.org")!) {
        self.baseURL = baseURL
    }

    func response<Request>(from request: Request) -> AnyPublisher<Request.Response, ServiceError> where Request: APIRequestType {

        let pathURL = URL(string: request.path, relativeTo: baseURL)!

        var urlComponents = URLComponents(url: pathURL, resolvingAgainstBaseURL: true)!
        urlComponents.queryItems = request.queryItems
        var request = URLRequest(url: urlComponents.url!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { data, urlResponse in data }
            .mapError { _ in ServiceError.badStatusCode }
            .decode(type: Request.Response.self, decoder: decoder)
            .mapError(ServiceError.parseError)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}

