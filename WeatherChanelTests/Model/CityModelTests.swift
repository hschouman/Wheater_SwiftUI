//
//  CityModelTests.swift
//  WeatherChanelTests
//
//  Created by Hugo Schouman on 14/12/2019.
//  Copyright © 2019 CocoaConsulting. All rights reserved.
//

import XCTest
@testable import WeatherChanel

class CityModelTests: XCTestCase {

    // MARK: - Temp Init
    func testCityInit() {

        // GIVEN
        let id = 5341
        let name = "Paris"
        let weathers = [Weather(id: 10, description: "clear", icon: .clear)]
        let temp = Temp(value: 10.0)

        // WHEN
        let city = City(id: id, name: name, weather: weathers, temp: temp)

        // THEN
        XCTAssert(city.id == id)
        XCTAssert(city.name == name)
        XCTAssert(city.temp.value == temp.value)
        XCTAssert(city.weather[0].id == weathers[0].id)
        XCTAssert(city.weather[0].description == weathers[0].description)
        XCTAssert(city.weather[0].icon == weathers[0].icon)
    }

    func testCityInitFromJSON() {
        // GIVEN
        let id = 5341
        let name = "Paris"
        let weathers = [Weather(id: 10, description: "clear", icon: .clear)]
        let temp = Temp(value: 10.0)

        // WHEN
        let city = try? JSONDecoder().decode(City.self, from: goodFixture)

        // THEN
        XCTAssert(city?.id == id)
        XCTAssert(city?.name == name)
        XCTAssert(city?.temp.value == temp.value)
        XCTAssert(city?.weather[0].id == weathers[0].id)
        XCTAssert(city?.weather[0].description == weathers[0].description)
        XCTAssert(city?.weather[0].icon == weathers[0].icon)
    }

    func testCityBadInitFromJSONNoId() {
        // GIVEN
        // WHEN
        let city = try? JSONDecoder().decode(City.self, from: badFixtureId)

        // THEN
        XCTAssert(city == nil)
    }

    func testCityBadInitFromJSONNoName() {
        // GIVEN
        // WHEN
        let city = try? JSONDecoder().decode(City.self, from: badFixtureName)

        // THEN
        XCTAssert(city == nil)
    }

    func testCityBadInitFromJSONNoTemp() {
        // GIVEN
        // WHEN
        let city = try? JSONDecoder().decode(City.self, from: badFixtureTemp)

        // THEN
        XCTAssert(city == nil)
    }

    func testCityBadInitFromJSONNoWeather() {
        // GIVEN
        // WHEN
        let city = try? JSONDecoder().decode(City.self, from: badFixtureWeather)

        // THEN
        XCTAssert(city == nil)
    }

    // MARK: - Fixtures
    // MARK: - Good
    private let goodFixture = Data("""
    {
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
    }
    """.utf8)

    // MARK: - Bad
    private let badFixtureId = Data("""
    {
        "other_key_id": 5341,
        "name": "Paris",
        "main": {
            "temp" : 10.0
        },
        "weather": [{
            "id" : 10,
            "description": "clear",
            "icon": "01d"
        }]
    }
    """.utf8)

    private let badFixtureName = Data("""
    {
        "id": 5341,
        "other_key_name": "Paris",
        "main": {
            "temp" : 10.0
        },
        "weather": [{
            "id" : 10,
            "description": "clear",
            "icon": "01d"
        }]
    }
    """.utf8)

    private let badFixtureTemp = Data("""
    {
        "id": 5341,
        "name": "Paris",
        "other_key_main": {
            "temp" : 10.0
        },
        "weather": [{
            "id" : 10,
            "description": "clear",
            "icon": "01d"
        }]
    }
    """.utf8)

    private let badFixtureWeather = Data("""
    {
        "id": 5341,
        "name": "Paris",
        "main": {
            "temp" : 10.0
        },
        "other_key_weather": [{
            "id" : 10,
            "description": "clear",
            "icon": "01d"
        }]
    }
    """.utf8)
}
