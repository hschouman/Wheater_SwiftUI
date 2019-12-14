//
//  Weather.swift
//  WeatherChanel
//
//  Created by Hugo Schouman on 13/12/2019.
//  Copyright © 2019 CocoaConsulting. All rights reserved.
//

import Foundation

enum WeatherIcon: String, Decodable {

    // day
    case clear = "01d"
    case fewClouds = "02d"
    case scatteredClouds = "03d"
    case brokenClouds = "04d"
    case showerRain = "09d"
    case rain = "10d"
    case thunderstorm = "11d"
    case snow = "13d"
    case mist = "50d"

    // night
    case nClear = "01n"
    case nFewClouds = "02n"
    case nScatteredClouds = "03n"
    case nBrokenClouds = "04n"
    case nShowerRain = "09n"
    case nRain = "10n"
    case nThunderstorm = "11n"
    case nSnow = "13n"
    case nMist = "50n"
}

struct Weather {
    let id: Int
    let description: String
    let icon: WeatherIcon
}

extension Weather: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case description
        case icon
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        description = try values.decode(String.self, forKey: .description)
        let iconString: String = try values.decode(String.self, forKey: .icon)
        icon = WeatherIcon(rawValue: iconString) ?? .clear
    }
}

struct MainWeather {
    let temp: Double
    let humidity: Int
}

extension MainWeather: Decodable {
    enum CodingKeys: String, CodingKey {
        case temp
        case humidity
    }
}
