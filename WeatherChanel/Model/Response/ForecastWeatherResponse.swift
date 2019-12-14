//
//  ForecastWeatherResponse.swift
//  WeatherChanel
//
//  Created by Hugo Schouman on 14/12/2019.
//  Copyright © 2019 CocoaConsulting. All rights reserved.
//

import Foundation

struct ForecastWeatherResponse: Decodable {
        let days: [Day]

    enum CodingKeys: String, CodingKey {
        case days = "list"
    }
}
