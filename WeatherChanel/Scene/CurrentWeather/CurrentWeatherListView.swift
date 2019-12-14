//
//  ContentView.swift
//  WeatherChanel
//
//  Created by Hugo Schouman on 13/12/2019.
//  Copyright © 2019 CocoaConsulting. All rights reserved.
//

import SwiftUI

struct CurrentWeatherListView: View {

    @ObservedObject var viewModel: CurrentWeatherListViewModel
    @State private var isShowing = false

    var body: some View {
        NavigationView {
            List(viewModel.cities) { city in
                NavigationLink(destination: ForecastWeatherView(viewModel: ForecastWeatherViewModel(city: city))) {
                    CurrentWeatherRow(city: city)
                }
            }
            .navigationBarTitle(Text("Current Weather"))
            .background(PullToRefresh(action: {
                self.viewModel.apply(.onRefresh, completion: {
                    self.isShowing = false
                })
            }, isShowing: $isShowing))
        }
        .alert(isPresented: $viewModel.isErrorShown, content: { () -> Alert in
            Alert(title: Text("Error"), message: Text(viewModel.errorMessage))
        })
            .onAppear(perform: { self.viewModel.apply(.onAppear, completion: {}) })
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        return CurrentWeatherListView(viewModel: .init())
    }
}
#endif
