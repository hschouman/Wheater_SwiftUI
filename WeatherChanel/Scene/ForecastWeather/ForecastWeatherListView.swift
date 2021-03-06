//
//  ForecastWeatherView.swift
//  WeatherChanel
//
//  Created by Hugo Schouman on 13/12/2019.
//  Copyright © 2019 CocoaConsulting. All rights reserved.
//

import SwiftUI

struct ForecastWeatherListView: View {

    @ObservedObject var viewModel: ForecastWeatherListViewModel
    @State private var isShowing = false

    var body: some View {
        List {
            ForEach(viewModel.days) { day in
                Section(header: Text(day.dateString)) {
                    ForEach(day.hours) { hour in
                        ForecastWeatherRow(hour: hour)
                    }
                }
            }
        }
        .navigationBarTitle(Text(self.viewModel.city.name))
        .background(PullToRefresh(action: {
            self.viewModel.apply(.onRefresh, completion: {
                self.isShowing = false
            })
        }, isShowing: $isShowing))
        .alert(isPresented: $viewModel.isErrorShown, content: { () -> Alert in
            Alert(title: Text(viewModel.errorTitle), message: Text(viewModel.errorMessage))
        })
        .onAppear(perform: { self.viewModel.apply(.onAppear, completion: {}) })
    }
}

#if DEBUG
struct DetailCityView_Previews: PreviewProvider {
    static var previews: some View {
        let city = City(id: 12, name: "Paris",
                        weather: [Weather(id: 12, description: "clear", icon: WeatherIcon.clear)],
                        temp: Temp(value: 25.4))
        return ForecastWeatherListView(viewModel: .init(city: city))
    }
}
#endif
