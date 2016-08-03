//
//  Weather.swift
//  TheWeatherApp
//
//  Created by Raphael Araújo on 8/2/16.
//  Copyright © 2016 Raphael Araújo. All rights reserved.
//

import UIKit

class Weather: NSObject {
    let minTemp : Float!
    let maxTemp : Float!
    let weatherDescription : String!
    
    init(minTemp: Float, maxTemp: Float, weatherDescription: String) {
        self.minTemp = minTemp
        self.maxTemp = maxTemp
        self.weatherDescription = weatherDescription
        
        super.init()
    }
}
