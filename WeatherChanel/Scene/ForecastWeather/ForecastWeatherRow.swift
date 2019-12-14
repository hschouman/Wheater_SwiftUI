//
//  ForecastWeatherRow.swift
//  WeatherChanel
//
//  Created by Hugo Schouman on 14/12/2019.
//  Copyright © 2019 CocoaConsulting. All rights reserved.
//

import Foundation
import SwiftUI

struct ForecastWeatherRow: View {
    var day: Day

    var body: some View {
        HStack {
//            Image(day.hours[0].weather[0].icon.rawValue)
            Text(String(format: "%.0f °C", day.hours[0].temp.value)).font(.body)
//            Text(String(format: "%.0f °C", day.temp.eveningTemp)).font(.body)
//            Text(String(format: "%.0f °C", day.temp.nightTemp)).font(.body)
        }
    }
}

#if DEBUG
struct ForecastWeatherRow_Previews: PreviewProvider {
    static var previews: some View {
        let day = Day(id: 10, date: Date(), hours: [Hour(date: Date(), temp: Temp(value: 12.0, min: 9.0, max: 29))])
//        let day = Day(id: 10,
//                      date: Date(),
//                      hours: [Hour(date: Date(), temp: Temp(value: 8.0, min: 14.2, max: 2.0),
//                                   weather: [Weather(id: 12, description: "clear", icon: WeatherIcon.clear)])])
        return ForecastWeatherRow(day: day)
    }
}
#endif
