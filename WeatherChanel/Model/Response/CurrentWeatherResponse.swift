//
//  CurrentWeatherResponse.swift
//  WeatherChanel
//
//  Created by Hugo Schouman on 13/12/2019.
//  Copyright © 2019 CocoaConsulting. All rights reserved.
//

import Foundation

struct CurrentWeatherResponse: Decodable {
    let cities: [City]

    enum CodingKeys: String, CodingKey {
        case cities = "list"
    }
}
