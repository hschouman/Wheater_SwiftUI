//
//  MockAPIService.swift
//  WeatherChanelTests
//
//  Created by Hugo Schouman on 14/12/2019.
//  Copyright © 2019 CocoaConsulting. All rights reserved.
//

import Foundation

import Foundation
import Combine
@testable import WeatherChanel

final class MockAPIService: APIServiceType {
    var stubs: [Any] = []

    func stub<Request>(for type: Request.Type, response: @escaping ((Request) -> AnyPublisher<Request.Response, ServiceError>)) where Request: APIRequestType {
        stubs.append(response)
    }

    func response<Request>(from request: Request) -> AnyPublisher<Request.Response, ServiceError> where Request: APIRequestType {

        let response = stubs.compactMap { stub -> AnyPublisher<Request.Response, ServiceError>? in
            let stub = stub as? ((Request) -> AnyPublisher<Request.Response, ServiceError>)
            return stub?(request)
        }.last

        return response ?? Empty<Request.Response, ServiceError>()
            .eraseToAnyPublisher()
    }
}
