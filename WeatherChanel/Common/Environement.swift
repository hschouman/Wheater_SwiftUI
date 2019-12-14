//
//  Environement.swift
//  WeatherChanel
//
//  Created by Hugo Schouman on 14/12/2019.
//  Copyright © 2019 CocoaConsulting. All rights reserved.
//

import Foundation

struct Environement {

    private static let production : Bool = {
        #if DEBUG
            return false
        #elseif STAGING
            return false
        #else
            return true
        #endif
    }()

    static func isProduction () -> Bool {
        return self.production
    }

}
