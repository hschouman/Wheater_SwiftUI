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
            Text(city.name)
            Text(String(format: "%.1f °C", city.mainWeather.temp))
            Text(city.weather[0].description)
        }
    }
}

struct CurrentWeatherRow_Previews: PreviewProvider {
    static var previews: some View {
        let city = City(id: 12, name: "Paris", weather: [Weather(id: 12, description: "clear", icon: WeatherIcon.clear)], mainWeather: MainWeather(temp: 25.4, humidity: 20))
        return CurrentWeatherRow(city: city)
    }
}
