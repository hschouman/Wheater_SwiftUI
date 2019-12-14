//
//  MainWheater.swift
//  WeatherChanel
//
//  Created by Hugo Schouman on 14/12/2019.
//  Copyright © 2019 CocoaConsulting. All rights reserved.
//

import Foundation

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
