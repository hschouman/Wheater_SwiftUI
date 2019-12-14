//
//  WeatherTests.swift
//  WeatherChanelTests
//
//  Created by Hugo Schouman on 14/12/2019.
//  Copyright © 2019 CocoaConsulting. All rights reserved.
//

import Foundation

import XCTest
@testable import WeatherChanel

class WeatherModelTests: XCTestCase {

    // MARK: - Init
    func testWeatherInit() {
        // Given
        let id = 12
        let description = "clear"
        let icon = WeatherIcon.clear

        // When
        let weather = Weather(id: id, description: description, icon: icon)

        // Then
        XCTAssert(weather.id == id)
        XCTAssert(weather.description == description)
        XCTAssert(weather.icon == icon)
    }

    func testWeatherInitFromJSON() {
        // GIVEN
        let id = 12
        let description = "clear"
        let icon = WeatherIcon.clear

        // WHEN
        let weather = try? JSONDecoder().decode(Weather.self, from: goodFixture)

        // THEN
        XCTAssert(weather?.id == id)
        XCTAssert(weather?.description == description)
        XCTAssert(weather?.icon == icon)
    }

    func testWeatherBadInitFromJSONNoId() {
        // GIVEN
        // WHEN
        let weather = try? JSONDecoder().decode(Weather.self, from: badFixtureId)

        // THEN
        XCTAssert(weather == nil)
    }

    func testWeatherBadInitFromJSONNoDescription() {
        // GIVEN
        // WHEN
        let weather = try? JSONDecoder().decode(Weather.self, from: badFixtureDescription)

        // THEN
        XCTAssert(weather == nil)
    }

    func testWeatherBadInitFromJSONNoIcon() {
        // GIVEN
        // WHEN
        let weather = try? JSONDecoder().decode(Weather.self, from: badFixtureIcon)

        // THEN
        XCTAssert(weather == nil)
    }

    // MARK: - Fixtures
    private let goodFixture = Data("""
    {
        "id" : 12,
        "description": "clear",
        "icon": "01d"
    }
    """.utf8)

    private let badFixtureId = Data("""
    {
      "other_key_id" : 12,
      "description": "clear",
      "icon": "01d"
    }
    """.utf8)

    private let badFixtureDescription = Data("""
    {
      "id" : 12,
      "other_key_description": "clear",
      "icon": "01d"
    }
    """.utf8)

    private let badFixtureIcon = Data("""
    {
      "other_key_id" : 12,
      "description": "clear",
      "other_key_icon": "01d"
    }
    """.utf8)
}
