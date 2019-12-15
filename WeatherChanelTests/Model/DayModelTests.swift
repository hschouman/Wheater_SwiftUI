//
//  DayModelTests.swift
//  WeatherChanelTests
//
//  Created by Hugo Schouman on 15/12/2019.
//  Copyright © 2019 CocoaConsulting. All rights reserved.
//

import Foundation

import XCTest
@testable import WeatherChanel

class DayModelTests: XCTestCase {

    // MARK: - Temp Init
    func testDayInit() {
        // Given
        let id = Int64(12)
        let date = Date()
        let temp = Temp(value: 10.0)
        let weathers = [Weather(id: 10, description: "clear", icon: WeatherIcon.clear)]
        let hour = Hour(id: id, date: date, temp: temp, weather: weathers)
        // When
        let day = Day(date: date, hours: [hour])
        // Then
        XCTAssert(day.date == date)
        XCTAssert(day.hours[0].id == id)
        XCTAssert(day.hours[0].date == date)
        XCTAssert(day.hours[0].temp.value == temp.value)
        XCTAssert(day.hours[0].weather[0].id == weathers[0].id)
        XCTAssert(day.hours[0].weather[0].description == weathers[0].description)
        XCTAssert(day.hours[0].weather[0].icon == weathers[0].icon)
    }
}
