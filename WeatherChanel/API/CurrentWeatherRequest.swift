//
//  CurrentWeatherRequest.swift
//  WeatherChanel
//
//  Created by Hugo Schouman on 13/12/2019.
//  Copyright © 2019 CocoaConsulting. All rights reserved.
//

import Foundation

struct CurrentWeatherRequest: APIRequestType {
    typealias Response = CurrentWeatherResponse

    var path: String { return "\(APIConstants.basePath.rawValue)/group" }
    var queryItems: [URLQueryItem]? {
        return [
            .init(name: APIConstants.unitsKey.rawValue, value: APIConstants.unitsValue.rawValue),
            .init(name: APIConstants.idKey.rawValue, value: CityId.allJoined),
            .init(name: APIConstants.appIdKey.rawValue, value: APIConstants.appIdValue.rawValue)
        ]
    }
}
