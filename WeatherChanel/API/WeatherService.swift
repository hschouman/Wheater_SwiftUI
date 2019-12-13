//
//  WeatherService.swift
//  WeatherChanel
//
//  Created by Hugo Schouman on 13/12/2019.
//  Copyright © 2019 CocoaConsulting. All rights reserved.
//

import Foundation

struct WeatherService: Service {

    var path = "/group"

    // MARK: - Constant
    enum Params: String {
        case cityIDParam = "id"
        case metricParam = "units"
    }

    enum Constant: String {
        case metricValue = "metric"
    }

    // MARK: - Var
    let service = AppService()

    // MARK: - Func
    func weather(cityIds: [CityId], completion: @escaping (Result<CityList, ServiceError>) -> ()) {

        let ids = cityIds.map({ "\($0.rawValue)" }).joined(separator: ",")

        let params = [
            Params.cityIDParam.rawValue: ids,
            Params.metricParam.rawValue: Constant.metricValue.rawValue
        ]

        service.fetch(onPath: path, withParams: params, shouldUseAppId: true, completion: completion)
    }
}
