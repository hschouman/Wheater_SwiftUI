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
            Text(city.tempString)
                .font(.title)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
        }
    }
}

#if DEBUG
struct CurrentWeatherRow_Previews: PreviewProvider {
    static var previews: some View {
        let city = City(id: 12, name: "Paris",
                        weather: [Weather(id: 12, description: "clear", icon: WeatherIcon.clear)],
                        temp: Temp(value: 25.4))
        return CurrentWeatherRow(city: city)
    }
}
#endif
