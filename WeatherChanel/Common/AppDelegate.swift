//
//  AppDelegate.swift
//  WeatherChanel
//
//  Created by Hugo Schouman on 13/12/2019.
//  Copyright © 2019 CocoaConsulting. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let service = WeatherService()
        service.weather(cityIds: [.paris, .london, .barcelona]) { (result) in
            switch result {
            case .success(let cityList):
                print(cityList.cities)
            case .failure(let error):
                print("Error fetching city weathers : \(error)")
            }
        }
        return true
    }
}

