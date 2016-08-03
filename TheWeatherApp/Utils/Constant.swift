//
//  Constant.swift
//  TheWeatherApp
//
//  Created by Raphael Araújo on 8/2/16.
//  Copyright © 2016 Raphael Araújo. All rights reserved.
//

import Foundation

struct ServerURL {
    static let nearbyCities = "http://api.openweathermap.org/data/2.5/find?lat=%f&lon=%f&cnt=%d&APPID=\(AppConfig.appId)&units=\(AppConfig.unitsSystem)"
}

struct AppConfig {
    static let appId = "951ab2c7ff821d0f8989f94567ab2863"
    static let unitsSystem = "metric"
}