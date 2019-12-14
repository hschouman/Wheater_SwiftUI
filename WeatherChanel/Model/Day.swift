//
//  Day.swift
//  WeatherChanel
//
//  Created by Hugo Schouman on 14/12/2019.
//  Copyright © 2019 CocoaConsulting. All rights reserved.
//

import Foundation

struct Hour {
    let date: Date
    let temp: Temp
//    let weather: [Weather]
}

extension Hour: Decodable {
    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case temp = "main"
//        case weather
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let timeStamp: Int = try container.decode(Int.self, forKey: .date)
        date = Date(timeIntervalSince1970: Double(timeStamp))
        temp = try container.decode(Temp.self, forKey: .temp)
    }
}

struct Day: Identifiable {
    let id: Int
    let date: Date
    let hours: [Hour]
}

extension Day: Decodable {

    enum CodingKeys: String, CodingKey {
        case id
        case hours = "list"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        hours = try container.decode([Hour].self, forKey: .hours)
        if let firstHourDate = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: hours[0].date)) {
              date = firstHourDate
        } else {
            date = Date()
        }
        id = date.hashValue
    }
}
