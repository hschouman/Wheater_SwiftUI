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
    var hour: Hour

    var body: some View {
        HStack {
            Text(hour.dateString)
            Image(hour.weather[0].icon.rawValue)
            Text(hour.weather[0].description).font(.body)
            Text(String(format: "%.0f °C", hour.temp.value))
                .bold()
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                .font(.body)
        }
    }
}
