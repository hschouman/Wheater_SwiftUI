//
//  Day.swift
//  WeatherChanel
//
//  Created by Hugo Schouman on 15/12/2019.
//  Copyright © 2019 CocoaConsulting. All rights reserved.
//

import Foundation

struct Day: Identifiable {
    var id: TimeInterval {
        return date.timeIntervalSince1970
    }
    let date: Date
    var hours: [Hour]
}

extension Day {
    var dateString: String {
        return WeatherDateFormatter.displayDay(date: date)
    }
}
