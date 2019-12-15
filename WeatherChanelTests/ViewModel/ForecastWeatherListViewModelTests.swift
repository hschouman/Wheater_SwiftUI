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
        XCTAssertTrue(!viewModel.days.isEmpty)
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
        XCTAssertTrue(!viewModel.days.isEmpty)
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


    func test_computeDays() {
        let apiService = MockAPIService()
        let date = Date()
        let tempValue = 19.9
        apiService.stub(for: ForecastWeatherRequest.self) { _ in
            Result.Publisher(
                ForecastWeatherResponse(hours: [.init(id: Int64(13),
                                                      date: date,
                                                      temp: Temp(value: tempValue),
                                                      weather: [Weather(id: 12, description: "clear", icon: WeatherIcon.clear)])
                ])
            ).eraseToAnyPublisher()
        }
        let viewModel = makeViewModel(apiService: apiService)
        viewModel.apply(.onAppear, completion: {})
        XCTAssertTrue(!viewModel.days.isEmpty)
        XCTAssertTrue(viewModel.days[0].date == date)
        XCTAssertTrue(viewModel.days[0].hours[0].temp.value == tempValue)
    }

    func test_computeOneDayWithSeveralHours() {
        let apiService = MockAPIService()
        let date = Date()
        let date2 = date.addingTimeInterval(1) // same day date
        let tempValue = 19.9
        apiService.stub(for: ForecastWeatherRequest.self) { _ in
            Result.Publisher(
                ForecastWeatherResponse(hours: [
                    .init(id: Int64(13),
                          date: date,
                          temp: Temp(value: tempValue),
                          weather: [Weather(id: 12, description: "clear", icon: WeatherIcon.clear)]),
                    .init(id: Int64(12),
                          date: date2,
                          temp: Temp(value: tempValue),
                          weather: [Weather(id: 12, description: "clear", icon: WeatherIcon.clear)])
                ])
            ).eraseToAnyPublisher()
        }
        let viewModel = makeViewModel(apiService: apiService)
        viewModel.apply(.onAppear, completion: {})
        XCTAssertTrue(viewModel.days.count == 1) // one element
        XCTAssertTrue(viewModel.days[0].date == date)
        XCTAssertTrue(viewModel.days[0].hours[0].temp.value == tempValue)
    }

    func test_computeSeveralDays() {
        let apiService = MockAPIService()
        let date = Date()
        let date2 = date.addingTimeInterval(80000) // different day date
        let tempValue = 19.9
        apiService.stub(for: ForecastWeatherRequest.self) { _ in
            Result.Publisher(
                ForecastWeatherResponse(hours: [
                    .init(id: Int64(13),
                          date: date,
                          temp: Temp(value: tempValue),
                          weather: [Weather(id: 12, description: "clear", icon: WeatherIcon.clear)]),
                    .init(id: Int64(12),
                          date: date2,
                          temp: Temp(value: tempValue),
                          weather: [Weather(id: 12, description: "clear", icon: WeatherIcon.clear)])
                ])
            ).eraseToAnyPublisher()
        }
        let viewModel = makeViewModel(apiService: apiService)
        viewModel.apply(.onAppear, completion: {})
        XCTAssertTrue(viewModel.days.count == 2) // several elements
        XCTAssertTrue(viewModel.days[0].date == date)
        XCTAssertTrue(viewModel.days[0].hours[0].temp.value == tempValue)
    }

    func test_computeDaySort() {
        let apiService = MockAPIService()
        let date = Date()
        let date2 = date.addingTimeInterval(-80000)
        let tempValue = 19.9
        apiService.stub(for: ForecastWeatherRequest.self) { _ in
            Result.Publisher(
                ForecastWeatherResponse(hours: [
                    .init(id: Int64(13),
                          date: date,
                          temp: Temp(value: tempValue),
                          weather: [Weather(id: 12, description: "clear", icon: WeatherIcon.clear)]),
                    .init(id: Int64(12),  // second day in array should comes first by date
                          date: date2,
                          temp: Temp(value: tempValue),
                          weather: [Weather(id: 12, description: "clear", icon: WeatherIcon.clear)])
                ])
            ).eraseToAnyPublisher()
        }
        let viewModel = makeViewModel(apiService: apiService)
        viewModel.apply(.onAppear, completion: {})
        XCTAssertTrue(viewModel.days.count == 2)
        XCTAssertTrue(viewModel.days[0].date == date2)
    }

    func test_hoursSort() {
        let apiService = MockAPIService()
        let date = Date()
        let date2 = date.addingTimeInterval(-1) // same day date but bad order
        let tempValue = 19.9
        apiService.stub(for: ForecastWeatherRequest.self) { _ in
            Result.Publisher(
                ForecastWeatherResponse(hours: [
                    .init(id: Int64(13),
                          date: date,
                          temp: Temp(value: tempValue),
                          weather: [Weather(id: 12, description: "clear", icon: WeatherIcon.clear)]),
                    .init(id: Int64(12),  // second day in array should comes first by date
                          date: date2,
                          temp: Temp(value: tempValue),
                          weather: [Weather(id: 12, description: "clear", icon: WeatherIcon.clear)])
                ])
            ).eraseToAnyPublisher()
        }
        let viewModel = makeViewModel(apiService: apiService)
        viewModel.apply(.onAppear, completion: {})
        XCTAssertTrue(viewModel.days.count == 1)
        XCTAssertTrue(viewModel.days[0].hours[0].date == date2)
        XCTAssertTrue(viewModel.days[0].hours[1].date == date)
    }


    // MARK: - Private funcs
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
