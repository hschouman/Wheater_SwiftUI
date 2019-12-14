//
//  CurrentWeatherRow.swift
//  WeatherChanel
//
//  Created by Hugo Schouman on 13/12/2019.
//  Copyright © 2019 CocoaConsulting. All rights reserved.
//

import SwiftUI

struct CurrentWeatherRow: View {
    var city: City

    var body: some View {
        HStack {
            Image(city.weather[0].icon.rawValue)
            VStack {
                Text(city.name)
                    .font(.title)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                Text(city.weather[0].description)
                    .font(.body)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            }
            Text(String(format: "%.0f °C", city.mainWeather.temp))
                .font(.title)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
        }
    }
}

struct CurrentWeatherRow_Previews: PreviewProvider {
    static var previews: some View {
        let city = City(id: 12, name: "Paris", weather: [Weather(id: 12, description: "clear", icon: WeatherIcon.clear)], mainWeather: MainWeather(temp: 25.4, humidity: 20))
        return CurrentWeatherRow(city: city)
    }
}
