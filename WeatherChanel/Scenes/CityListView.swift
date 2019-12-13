//
//  ContentView.swift
//  WeatherChanel
//
//  Created by Hugo Schouman on 13/12/2019.
//  Copyright © 2019 CocoaConsulting. All rights reserved.
//

import SwiftUI


struct WeatherRow: View {
    var city: City

    var body: some View {
        HStack {
            Text(city.name)
        }
    }
}

//let weather = Weather(id: 300, description: "", icon: WeatherIcon.clear)

var cities: [City] = []

struct CityListView: View {
    var body: some View {
        List(cities) { city in
            WeatherRow(city: city)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CityListView()
    }
}
