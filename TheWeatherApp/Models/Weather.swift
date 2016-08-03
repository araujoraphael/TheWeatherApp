//
//  Weather.swift
//  TheWeatherApp
//
//  Created by Raphael Araújo on 8/2/16.
//  Copyright © 2016 Raphael Araújo. All rights reserved.
//

import UIKit

class Weather: NSObject {
    let minTemp : Int!
    let maxTemp : Int!
    let temp : Int!
    let weatherDescription : String!
    
    init(minTemp: Int, maxTemp: Int, temp: Int, weatherDescription: String) {
        self.minTemp = minTemp
        self.maxTemp = maxTemp
        self.temp = temp
        self.weatherDescription = weatherDescription
        
        super.init()
    }
}
