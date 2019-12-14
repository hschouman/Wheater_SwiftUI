//
//  UnidirectionalDataFlowType.swift
//  WeatherChanel
//
//  Created by Hugo Schouman on 13/12/2019.
//  Copyright © 2019 CocoaConsulting. All rights reserved.
//

import Foundation

protocol UnidirectionalDataFlowType {
    associatedtype InputType

    func apply(_ input: InputType, completion: () -> ())
}
