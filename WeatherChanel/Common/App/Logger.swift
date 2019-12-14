//
//  Logger.swift
//  WeatherChanel
//
//  Created by Hugo Schouman on 14/12/2019.
//  Copyright © 2019 CocoaConsulting. All rights reserved.
//

import Foundation
import os

enum LogLevel {
    case info
    case debug
    case error
    case fault
}

struct Logger {

    static func log(text: StaticString, param: String? = nil, level: LogLevel = .debug) {

        if !Environement.isProduction() {
            switch (level, param) {
            case (.info, .none):
                os_log(text, type: .info)
            case (.info, .some(let param)):
                os_log(text, type: .info, param)
            case (.debug, .none):
                os_log(text, type: .debug)
            case (.debug, .some(let param)):
                os_log(text, type: .debug, param)
            case (.error, .none):
                os_log(text, type: .error)
            case (.error, .some(let param)):
                os_log(text, type: .error, param)
            case (.fault, .none):
                os_log(text, type: .fault)
            case (.fault, .some(let param)):
                os_log(text, type: .fault, param)
            }
        }
    }
}
