//
//  ForecastWeatherRequest.swift
//  WeatherChanel
//
//  Created by Hugo Schouman on 14/12/2019.
//  Copyright © 2019 CocoaConsulting. All rights reserved.
//

import Foundation

struct ForecastWeatherRequest: APIRequestType {
    typealias Response = ForecastWeatherResponse

    let cityId: Int

    var path: String { return "\(APIConstants.basePath.rawValue)/forecast" }
    var queryItems: [URLQueryItem]? {
        return [
            .init(name: APIConstants.unitsKey.rawValue, value: APIConstants.unitsValue.rawValue),
            .init(name: APIConstants.idKey.rawValue, value: "\(cityId)"),
            .init(name: APIConstants.appIdKey.rawValue, value: APIConstants.appIdValue.rawValue)
        ]
    }
}
