//
//  ForecastWeatherView.swift
//  WeatherChanel
//
//  Created by Hugo Schouman on 13/12/2019.
//  Copyright © 2019 CocoaConsulting. All rights reserved.
//

import SwiftUI

struct ForecastWeatherView: View {

    @ObservedObject var viewModel: ForecastWeatherViewModel
    @State private var isShowing = false

    var body: some View {
        List(viewModel.hours) { hour in
            ForecastWeatherRow(hour: hour)
        }
        .navigationBarTitle(Text(self.viewModel.city.name))
        .background(PullToRefresh(action: {
            self.viewModel.apply(.onRefresh, completion: {
                self.isShowing = false
            })
        }, isShowing: $isShowing))
        .alert(isPresented: $viewModel.isErrorShown, content: { () -> Alert in
            Alert(title: Text("Error"), message: Text(viewModel.errorMessage))
        })
        .onAppear(perform: { self.viewModel.apply(.onAppear, completion: {}) })
    }
}

#if DEBUG
struct DetailCityView_Previews: PreviewProvider {
    static var previews: some View {
        let city = City(id: 12, name: "Paris", weather: [Weather(id: 12, description: "clear", icon: WeatherIcon.clear)],
                        mainWeather: MainWeather(temp: 25.4, humidity: 20))
        return ForecastWeatherView(viewModel: .init(city: city))
    }
}
#endif
