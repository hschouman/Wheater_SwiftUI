//
//  Hour.swift
//  WeatherChanel
//
//  Created by Hugo Schouman on 14/12/2019.
//  Copyright © 2019 CocoaConsulting. All rights reserved.
//

import Foundation

struct Hour: Identifiable {
    let id: Int64
    let date: Date
    let temp: Temp
    let weather: [Weather]
}

extension Hour {
    var dateString: String {
        return WeatherDateFormatter.display(date: date)
    }

    var tempString: String {
        return temp.string
    }
}

extension Hour: Decodable {
    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case temp = "main"
        case weather
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let timeStamp: Int64 = try container.decode(Int64.self, forKey: .date)
        id = timeStamp
        date = Date(timeIntervalSince1970: Double(timeStamp))
        temp = try container.decode(Temp.self, forKey: .temp)
        weather = try container.decode([Weather].self, forKey: .weather)
    }
}
