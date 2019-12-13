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

    var path: String { return "/data/2.5/group" }
    var queryItems: [URLQueryItem]? {
        let ids = [CityId.barcelona, CityId.kiev, CityId.london, CityId.madrid, CityId.milan, CityId.moscow, CityId.newyork, CityId.paris]
            .map({ "\($0.rawValue)" }).joined(separator: ",")
        return [
            .init(name: "units", value: "metric"),
            .init(name: "id", value: "\(ids)"),
            .init(name: "appid", value: "ead2be695e935e8a560ac3b0ede63005")
        ]
    }
}
