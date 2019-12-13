//
//  WeatherChanelTests.swift
//  WeatherChanelTests
//
//  Created by Hugo Schouman on 13/12/2019.
//  Copyright © 2019 CocoaConsulting. All rights reserved.
//

import XCTest
@testable import WeatherChanel

class URLManagerTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


    // MARK: - URLManager
    func testURLManager_createURL_baseURL() {

        // GIVEN
        let baseURLString = "http://www.test.com"
        guard let baseURL = URL(string: baseURLString) else {
            XCTAssert(false)
            return
        }

        // WHEN
        let result = URLManager.createURL(from: baseURL, basePath: nil, path: nil, params: nil)

        // THEN
        XCTAssert(result?.absoluteString == baseURLString)
    }

    func testURLManager_createURL_path() {

        // GIVEN
        let baseURLString = "http://www.test.com"
        guard let baseURL = URL(string: baseURLString) else {
            XCTAssert(false)
            return
        }
        let path = "/pathExemple"

        // WHEN
        let result = URLManager.createURL(from: baseURL, basePath: nil, path: path, params: nil)

        // THEN
        XCTAssert(result?.absoluteString == baseURLString+path)
    }

    func testURLManager_createURL_basePath() {

        // GIVEN
        let baseURLString = "http://www.test.com"
        guard let baseURL = URL(string: baseURLString) else {
            XCTAssert(false)
            return
        }
        let basePath = "/basePath"
        let path = "/pathExemple"

        // WHEN
        let result = URLManager.createURL(from: baseURL, basePath: basePath, path: path, params: nil)

        // THEN
        XCTAssert(result?.absoluteString == baseURLString+basePath+path)
    }

    func testURLManager_createURL_params() {

        // GIVEN
        let baseURLString = "http://www.test.com"
        guard let baseURL = URL(string: baseURLString) else {
            XCTAssert(false)
            return
        }
        let path = "/pathExemple"
        let params = ["key1":"value1", "key2": "value2"]

        // WHEN
        let result = URLManager.createURL(from: baseURL, basePath: nil, path: path, params: params)

        // THEN
        XCTAssert(result?.absoluteString.contains(baseURLString) ?? false)
        XCTAssert(result?.absoluteString.contains("key1") ?? false)
        XCTAssert(result?.absoluteString.contains("value1") ?? false)
        XCTAssert(result?.absoluteString.contains("key2") ?? false)
        XCTAssert(result?.absoluteString.contains("value2") ?? false)
    }

}
