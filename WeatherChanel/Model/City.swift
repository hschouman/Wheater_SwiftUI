//
//  City.swift
//  WeatherChanel
//
//  Created by Hugo Schouman on 13/12/2019.
//  Copyright © 2019 CocoaConsulting. All rights reserved.
//

import Foundation

struct City: Identifiable {
    let id: Int
    let name: String
    let weather: [Weather]
    let mainWeather: MainWeather
}

extension City: Decodable {

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case weather
        case mainWeather = "main"
    }
}

extension City {
    var tempString: String {
        return String(format: "%.0f °C", mainWeather.temp)
    }
}
