//
//  CityIds.swift
//  WeatherChanel
//
//  Created by Hugo Schouman on 13/12/2019.
//  Copyright © 2019 CocoaConsulting. All rights reserved.
//

import Foundation

enum CityId: Int {
    case caen = 6427109
    case dijon = 3021372
    case lannion = 3007609
    case leHavre = 3003796
    case lens = 3003093
    case lorient = 2997577
    case martigues = 2995387
    case massy = 2995206
    case maubeuge = 2995150
    case paris = 6455259
    case villersSurMer = 6427562

    static var allJoined: String {
        return ([.caen, .dijon, .lannion, .leHavre, .lens, .lorient, .martigues, .massy, .maubeuge, .paris, .villersSurMer] as [Self])
            .map({ "\($0.rawValue)" })
            .joined(separator: ",")
    }
}
