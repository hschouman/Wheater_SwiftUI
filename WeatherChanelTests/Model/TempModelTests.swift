//
//  TempTests.swift
//  WeatherChanelTests
//
//  Created by Hugo Schouman on 14/12/2019.
//  Copyright © 2019 CocoaConsulting. All rights reserved.
//

import XCTest
@testable import WeatherChanel

class TempModelTests: XCTestCase {

    // MARK: - Temp Init
    func testTempInit() {

        // GIVEN
        let value = 10.0

        // WHEN
        let temp = Temp(value: value)

        // THEN
        XCTAssert(temp.value == value)
    }

    func testTempInitFromJSON() {
        // GIVEN
        let value = 10.0

        // WHEN
        let object = try? JSONDecoder().decode(Temp.self, from: goodFixture)

        // THEN
        XCTAssert(object?.value == value)
    }

    func testTempBadInitFromJSON() {
        // GIVEN
        // WHEN
        let object = try? JSONDecoder().decode(Temp.self, from: badFixture)

        // THEN
        XCTAssert(object == nil)
    }


    // MARK: - Fixtures
    private let goodFixture = Data("""
    {
      "temp" : 10.0
    }
    """.utf8)

    private let badFixture = Data("""
    {
      "otherKey" : 10.0
    }
    """.utf8)
}
