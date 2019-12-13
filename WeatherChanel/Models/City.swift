//
//  City.swift
//  WeatherChanel
//
//  Created by Hugo Schouman on 13/12/2019.
//  Copyright © 2019 CocoaConsulting. All rights reserved.
//

import Foundation

protocol Ids {}

enum CityId: Int, Ids {
    case paris = 6455259
    case madrid = 6359304
    case milan = 6542283
    case barcelona = 6356055
    case washington = 4880731
    case newyork = 5128638
    case moscow = 524901
    case kiev = 703448
    case london = 2643743
}

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

struct CityList: Decodable {
    let cities: [City]

    enum CodingKeys: String, CodingKey {
        case cities = "list"
    }
}
