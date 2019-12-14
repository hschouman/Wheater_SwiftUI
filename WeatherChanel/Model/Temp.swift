//
//  Temp.swift
//  WeatherChanel
//
//  Created by Hugo Schouman on 14/12/2019.
//  Copyright © 2019 CocoaConsulting. All rights reserved.
//

import Foundation

struct Temp {
    let value: Double
}

extension Temp: Decodable {

    enum CodingKeys: String, CodingKey {
        case value = "temp"
    }
}
