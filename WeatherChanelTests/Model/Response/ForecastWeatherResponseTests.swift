//
//  ForecastWeatherResponseTests.swift
//  WeatherChanelTests
//
//  Created by Hugo Schouman on 14/12/2019.
//  Copyright © 2019 CocoaConsulting. All rights reserved.
//

import Foundation

import XCTest
@testable import WeatherChanel

class ForecastWeatherResponseTests: XCTestCase {

    // MARK: - Temp Init
    func testForecastWeatherResponseInit() {
        // Given
        let id = Int64(1576335600)
        let date = Date(timeIntervalSince1970: 1576335600)
        let temp = Temp(value: 10.0)
        let weathers = [Weather(id: 12, description: "clear", icon: WeatherIcon.clear)]
        let hours = [Hour(id: id, date: date, temp: temp, weather: weathers)]

        // When
        let forecastWeatherResponse = ForecastWeatherResponse(hours: hours)
        // Then
        XCTAssert(forecastWeatherResponse.hours[0].id == id)
        XCTAssert(forecastWeatherResponse.hours[0].date == date)
        XCTAssert(forecastWeatherResponse.hours[0].temp.value == temp.value)
        XCTAssert(forecastWeatherResponse.hours[0].weather[0].id == weathers[0].id)
        XCTAssert(forecastWeatherResponse.hours[0].weather[0].description == weathers[0].description)
        XCTAssert(forecastWeatherResponse.hours[0].weather[0].icon == weathers[0].icon)
    }

    func testCurrentWeatherResponseInitFromJSON() {
        // GIVEN
        let id = Int64(1576335600)
        let date = Date(timeIntervalSince1970: 1576335600)
        let temp = Temp(value: 10.0)
        let weathers = [Weather(id: 12, description: "clear", icon: WeatherIcon.clear)]

        // WHEN
        let forecastWeatherResponse = try? JSONDecoder().decode(ForecastWeatherResponse.self, from: goodFixture)

        // THEN
        XCTAssert(forecastWeatherResponse?.hours[0].id == id)
        XCTAssert(forecastWeatherResponse?.hours[0].date == date)
        XCTAssert(forecastWeatherResponse?.hours[0].temp.value == temp.value)
        XCTAssert(forecastWeatherResponse?.hours[0].weather[0].id == weathers[0].id)
        XCTAssert(forecastWeatherResponse?.hours[0].weather[0].description == weathers[0].description)
        XCTAssert(forecastWeatherResponse?.hours[0].weather[0].icon == weathers[0].icon)
    }

    func testCurrentWeatherResponseInitFromJSONNoList() {
        // GIVEN
        // WHEN
        let forecastWeatherResponse = try? JSONDecoder().decode(ForecastWeatherResponse.self, from: badFixtureNoList)

        // THEN
        XCTAssert(forecastWeatherResponse == nil)
    }

    // MARK: - Fixtures
    // MARK: - Good
    private let goodFixture = Data("""
    {
        "list":
            [
                {
                    "dt": 1576335600,
                    "main": {
                        "temp" : 10.0
                    },
                    "weather": [{
                        "id" : 12,
                        "description": "clear",
                        "icon": "01d"
                    }]
                },
                {
                    "dt": 1576335600,
                    "main": {
                        "temp" : 10.0
                    },
                    "weather": [{
                        "id" : 12,
                        "description": "clear",
                        "icon": "01d"
                    }]
                }
            ]
    }
    """.utf8)

    // MARK: - Bad
    private let badFixtureNoList = Data("""
    {
        "other_key_list":
            [
                {
                    "dt": 1576335600,
                    "main": {
                        "temp" : 10.0
                    },
                    "weather": [{
                        "id" : 12,
                        "description": "clear",
                        "icon": "01d"
                    }]
                },
                {
                    "dt": 1576335600,
                    "main": {
                        "temp" : 10.0
                    },
                    "weather": [{
                        "id" : 12,
                        "description": "clear",
                        "icon": "01d"
                    }]
                }
            ]
    }
    """.utf8)
}
