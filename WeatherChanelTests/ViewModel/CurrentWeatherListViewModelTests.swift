//
//  CurrentWeatherListViewModelTests.swift
//  WeatherChanelTests
//
//  Created by Hugo Schouman on 14/12/2019.
//  Copyright © 2019 CocoaConsulting. All rights reserved.
//

import Foundation
import Combine
import XCTest
@testable import WeatherChanel

final class CurrentWeatherListViewModelTests: XCTestCase {


    // MARK: - OnAppear
    func test_updateCurrentWeatherWhenOnAppear() {
        let apiService = MockAPIService()
        apiService.stub(for: CurrentWeatherRequest.self) { _ in
            Result.Publisher(
                CurrentWeatherResponse(cities: [.init(id: 10,
                                                      name: "Paris",
                                                      weather: [Weather(id: 12, description: "clear", icon: WeatherIcon.clear)],
                                                      temp: Temp(value: 10.0))]
                )
            ).eraseToAnyPublisher()
        }
        let viewModel = makeViewModel(apiService: apiService)
        viewModel.apply(.onAppear, completion: {})
        XCTAssertTrue(!viewModel.cities.isEmpty)
    }

    func test_serviceErrorWhenOnAppear() {
        let apiService = MockAPIService()
        apiService.stub(for: CurrentWeatherRequest.self) { _ in
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
        apiService.stub(for: CurrentWeatherRequest.self) { _ in
            Result.Publisher(
                CurrentWeatherResponse(cities: [.init(id: 10,
                                                      name: "Paris",
                                                      weather: [Weather(id: 12, description: "clear", icon: WeatherIcon.clear)],
                                                      temp: Temp(value: 10.0))]
                )
            ).eraseToAnyPublisher()
        }
        let viewModel = makeViewModel(apiService: apiService)
        viewModel.apply(.onRefresh, completion: {})
        XCTAssertTrue(!viewModel.cities.isEmpty)
    }

    func test_serviceErrorWhenOnRefresh() {
        let apiService = MockAPIService()
        apiService.stub(for: CurrentWeatherRequest.self) { _ in
            Result.Publisher(
                ServiceError.networkError
            ).eraseToAnyPublisher()
        }
        let viewModel = makeViewModel(apiService: apiService)
        viewModel.apply(.onRefresh, completion: {})
        XCTAssertTrue(viewModel.isErrorShown)
    }

    private func makeViewModel(
        apiService: APIServiceType = MockAPIService()) -> CurrentWeatherListViewModel {
        return CurrentWeatherListViewModel(apiService: apiService)
    }
}
