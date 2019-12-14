//
//  CurrentWeatherResponseTests.swift
//  WeatherChanelTests
//
//  Created by Hugo Schouman on 14/12/2019.
//  Copyright © 2019 CocoaConsulting. All rights reserved.
//

import Foundation

import XCTest
@testable import WeatherChanel

class CurrentWeatherResponseTests: XCTestCase {

    // MARK: - Temp Init
    func testCurrentWeatherResponseInit() {
        // Given
        let id = 5341
        let name = "Paris"
        let weathers = [Weather(id: 10, description: "clear", icon: .clear)]
        let temp = Temp(value: 10.0)
        let id2 = 5342
        let name2 = "London"
        let weathers2 = [Weather(id: 109, description: "clear", icon: .clear)]
        let temp2 = Temp(value: 12.0)
        let cities = [City(id: id, name: name, weather: weathers, temp: temp), City(id: id2, name: name2, weather: weathers2, temp: temp2)]
        // When
        let currentWeatherResponse = CurrentWeatherResponse(cities: cities)
        // Then
        XCTAssert(currentWeatherResponse.cities.count == 2)
        XCTAssert(currentWeatherResponse.cities[0].id == id)
        XCTAssert(currentWeatherResponse.cities[0].name == name)
        XCTAssert(currentWeatherResponse.cities[0].weather[0].id == weathers[0].id)
        XCTAssert(currentWeatherResponse.cities[0].weather[0].description == weathers[0].description)
        XCTAssert(currentWeatherResponse.cities[0].weather[0].icon == weathers[0].icon)
        XCTAssert(currentWeatherResponse.cities[0].temp.value == temp.value)
        XCTAssert(currentWeatherResponse.cities[1].id == id2)
        XCTAssert(currentWeatherResponse.cities[1].name == name2)
        XCTAssert(currentWeatherResponse.cities[1].weather[0].id == weathers2[0].id)
        XCTAssert(currentWeatherResponse.cities[1].weather[0].description == weathers2[0].description)
        XCTAssert(currentWeatherResponse.cities[1].weather[0].icon == weathers2[0].icon)
        XCTAssert(currentWeatherResponse.cities[1].temp.value == temp2.value)
    }

    func testCurrentWeatherResponseInitFromJSON() {
        // GIVEN
        let id = 5341
        let name = "Paris"
        let weathers = [Weather(id: 10, description: "clear", icon: .clear)]
        let temp = Temp(value: 10.0)
        let id2 = 5342
        let name2 = "London"
        let weathers2 = [Weather(id: 109, description: "clear", icon: .clear)]
        let temp2 = Temp(value: 12.0)

        // WHEN
        let currentWeatherResponse = try? JSONDecoder().decode(CurrentWeatherResponse.self, from: goodFixture)

        // THEN
        XCTAssert(currentWeatherResponse?.cities.count == 2)
        XCTAssert(currentWeatherResponse?.cities[0].id == id)
        XCTAssert(currentWeatherResponse?.cities[0].name == name)
        XCTAssert(currentWeatherResponse?.cities[0].weather[0].id == weathers[0].id)
        XCTAssert(currentWeatherResponse?.cities[0].weather[0].description == weathers[0].description)
        XCTAssert(currentWeatherResponse?.cities[0].weather[0].icon == weathers[0].icon)
        XCTAssert(currentWeatherResponse?.cities[0].temp.value == temp.value)
        XCTAssert(currentWeatherResponse?.cities[1].id == id2)
        XCTAssert(currentWeatherResponse?.cities[1].name == name2)
        XCTAssert(currentWeatherResponse?.cities[1].weather[0].id == weathers2[0].id)
        XCTAssert(currentWeatherResponse?.cities[1].weather[0].description == weathers2[0].description)
        XCTAssert(currentWeatherResponse?.cities[1].weather[0].icon == weathers2[0].icon)
        XCTAssert(currentWeatherResponse?.cities[1].temp.value == temp2.value)
    }

    func testCurrentWeatherResponseInitFromJSONNoList() {
        // GIVEN
        // WHEN
        let currentWeatherResponse = try? JSONDecoder().decode(CurrentWeatherResponse.self, from: badFixtureNoList)

        // THEN
        XCTAssert(currentWeatherResponse == nil)
    }

    // MARK: - Fixtures
    // MARK: - Good
    private let goodFixture = Data("""
    {
        "list": [{
            "id": 5341,
            "name": "Paris",
            "main": {
                "temp" : 10.0
            },
            "weather": [{
                "id" : 10,
                "description": "clear",
                "icon": "01d"
            }]
        },
        {
            "id": 5342,
            "name": "London",
            "main": {
                "temp" : 12.0
            },
            "weather": [{
                "id" : 109,
                "description": "clear",
                "icon": "01d"
            }]
        }]
    }
    """.utf8)

    // MARK: - Bad
    private let badFixtureNoList = Data("""
    {
        "other_key_list": [{
            "id": 5341,
            "name": "Paris",
            "main": {
                "temp" : 10.0
            },
            "weather": [{
                "id" : 10,
                "description": "clear",
                "icon": "01d"
            }]
        },
        {
            "id": 5342,
            "name": "London",
            "main": {
                "temp" : 12.0
            },
            "weather": [{
                "id" : 109,
                "description": "clear",
                "icon": "01d"
            }]
        }]
    }
    """.utf8)
}
