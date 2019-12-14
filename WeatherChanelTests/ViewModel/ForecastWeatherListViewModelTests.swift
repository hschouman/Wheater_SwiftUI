//
//  ForecastWeatherListViewModelTests.swift
//  WeatherChanelTests
//
//  Created by Hugo Schouman on 14/12/2019.
//  Copyright © 2019 CocoaConsulting. All rights reserved.
//

import Foundation
import Combine
import XCTest
@testable import WeatherChanel

final class ForecastWeatherListViewModelTests: XCTestCase {


    // MARK: - OnAppear
    func test_updateForecastWeatherWhenOnAppear() {
        let apiService = MockAPIService()
        apiService.stub(for: ForecastWeatherRequest.self) { _ in
            Result.Publisher(
                ForecastWeatherResponse(hours: [.init(id: Int64(13),
                                                      date: Date(),
                                                      temp: Temp(value: 19.9),
                                                      weather: [Weather(id: 12, description: "clear", icon: WeatherIcon.clear)])
                ])
            ).eraseToAnyPublisher()
        }
        let viewModel = makeViewModel(apiService: apiService)
        viewModel.apply(.onAppear, completion: {})
        XCTAssertTrue(!viewModel.hours.isEmpty)
    }

    func test_serviceErrorWhenOnAppear() {
        let apiService = MockAPIService()
        apiService.stub(for: ForecastWeatherRequest.self) { _ in
            Result.Publisher(
                ServiceError.networkError
            ).eraseToAnyPublisher()
        }
        let viewModel = makeViewModel(apiService: apiService)
        viewModel.apply(.onAppear, completion: {})
        XCTAssertTrue(viewModel.isErrorShown)
    }

    // MARK: - OnRefresh
    func test_updateCurrentWeatherWhenOnRefresh() {
        let apiService = MockAPIService()
        apiService.stub(for: ForecastWeatherRequest.self) { _ in
            Result.Publisher(
                ForecastWeatherResponse(hours: [.init(id: Int64(13),
                                                      date: Date(),
                                                      temp: Temp(value: 19.9),
                                                      weather: [Weather(id: 12, description: "clear", icon: WeatherIcon.clear)])
                    ])
            ).eraseToAnyPublisher()
        }
        let viewModel = makeViewModel(apiService: apiService)
        viewModel.apply(.onRefresh, completion: {})
        XCTAssertTrue(!viewModel.hours.isEmpty)
    }

    func test_serviceErrorWhenOnRefresh() {
        let apiService = MockAPIService()
        apiService.stub(for: ForecastWeatherRequest.self) { _ in
            Result.Publisher(
                ServiceError.networkError
            ).eraseToAnyPublisher()
        }
        let viewModel = makeViewModel(apiService: apiService)
        viewModel.apply(.onRefresh, completion: {})
        XCTAssertTrue(viewModel.isErrorShown)
    }

    private func makeViewModel(
        apiService: APIServiceType = MockAPIService()) -> ForecastWeatherListViewModel {
        let id = 5341
        let name = "Paris"
        let weathers = [Weather(id: 10, description: "clear", icon: .clear)]
        let temp = Temp(value: 10.0)

        // WHEN
        let city = City(id: id, name: name, weather: weathers, temp: temp)
        return ForecastWeatherListViewModel(city: city, apiService: apiService)
    }
}
