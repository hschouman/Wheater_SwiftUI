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
        let ids = [CityId.barcelona, CityId.kiev, CityId.london, CityId.madrid, CityId.milan, CityId.moscow, CityId.paris]
            .map({ "\($0.rawValue)" })
            .joined(separator: ",")
        return [
            .init(name: APIConstants.unitsKey.rawValue, value: APIConstants.unitsValue.rawValue),
            .init(name: APIConstants.idKey.rawValue, value: "\(ids)"),
            .init(name: APIConstants.appIdKey.rawValue, value: APIConstants.appIdValue.rawValue)
        ]
    }
}
