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

    var path: String { return "/data/2.5/forecast" }
    var queryItems: [URLQueryItem]? {
        return [
            .init(name: "id", value: "\(cityId)"),
            .init(name: "appid", value: "ead2be695e935e8a560ac3b0ede63005")
        ]
    }
}
