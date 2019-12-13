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

    var body: some View {
        NavigationView {
            List(viewModel.cities) { city in
                CurrentWeatherRow(city: city)
            }.navigationBarTitle(Text("Current Weather"))
        }
        .onAppear(perform: { self.viewModel.apply(.onAppear) })
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        return CurrentWeatherListView(viewModel: .init())
    }
}
#endif
