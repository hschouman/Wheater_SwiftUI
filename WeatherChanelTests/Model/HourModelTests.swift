//
//  HourModelTests.swift
//  WeatherChanelTests
//
//  Created by Hugo Schouman on 14/12/2019.
//  Copyright © 2019 CocoaConsulting. All rights reserved.
//

import Foundation

import XCTest
@testable import WeatherChanel

class HourModelTests: XCTestCase {

    // MARK: - Temp Init
    func testHourInit() {
        // Given
        let id = Int64(12)
        let date = Date()
        let temp = Temp(value: 10.0)
        let weathers = [Weather(id: 10, description: "clear", icon: WeatherIcon.clear)]
        // When
        let hour = Hour(id: id, date: date, temp: temp, weather: weathers)
        // Then
        XCTAssert(hour.id == id)
        XCTAssert(hour.date == date)
        XCTAssert(hour.temp.value == temp.value)
        XCTAssert(hour.weather[0].id == weathers[0].id)
        XCTAssert(hour.weather[0].description == weathers[0].description)
        XCTAssert(hour.weather[0].icon == weathers[0].icon)
    }

    func testHourInitFromJSON() {
        // GIVEN
        let id = Int64(1576335600)
        let date = Date(timeIntervalSince1970: 1576335600)
        let temp = Temp(value: 10.0)
        let weathers = [Weather(id: 12, description: "clear", icon: WeatherIcon.clear)]

        // WHEN
        let hour = try? JSONDecoder().decode(Hour.self, from: goodFixture)

        // THEN
        XCTAssert(hour?.id == id)
        XCTAssert(hour?.date == date)
        XCTAssert(hour?.temp.value == temp.value)
        XCTAssert(hour?.weather[0].id == weathers[0].id)
        XCTAssert(hour?.weather[0].description == weathers[0].description)
        XCTAssert(hour?.weather[0].icon == weathers[0].icon)
    }

    func testHourBadInitFromJSONNoDate() {
        // GIVEN
        // WHEN
        let hour = try? JSONDecoder().decode(Hour.self, from: badFixtureDate)

        // THEN
        XCTAssert(hour == nil)
    }

    func testHourBadInitFromJSONNoTemp() {
        // GIVEN
        // WHEN
        let hour = try? JSONDecoder().decode(Hour.self, from: badFixtureTemp)

        // THEN
        XCTAssert(hour == nil)
    }

    func testHourBadInitFromJSONNoWeather() {
        // GIVEN
        // WHEN
        let hour = try? JSONDecoder().decode(Hour.self, from: badFixtureTemp)

        // THEN
        XCTAssert(hour == nil)
    }


    // MARK: - Fixtures
    // MARK: - Good
    private let goodFixture = Data("""
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
    """.utf8)


    // MARK: - Bad
    private let badFixtureDate = Data("""
    {
        "other_key_dt": 1576335600,
        "main": {
            "temp" : 10.0
        },
        "weather": [{
            "id" : 12,
            "description": "clear",
            "icon": "01d"
        }]
    }
    """.utf8)

    private let badFixtureTemp = Data("""
    {
        "dt": 1576335600,
        "other_key_main": {
            "temp" : 10.0
        },
        "weather": [{
            "id" : 12,
            "description": "clear",
            "icon": "01d"
        }]
    }
    """.utf8)

    private let badFixtureWeather = Data("""
    {
        "dt": 1576335600,
        "main": {
            "temp" : 10.0
        },
        "other_key_weather": [{
            "id" : 12,
            "description": "clear",
            "icon": "01d"
        }]
    }
    """.utf8)
}
