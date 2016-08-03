//
//  City.swift
//  TheWeatherApp
//
//  Created by Raphael Araújo on 8/2/16.
//  Copyright © 2016 Raphael Araújo. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class City: NSObject {
    var name : String!
    var weather : Weather!
    
    init(json: JSON) {
        name = json["name"].stringValue
        let mainJson = json["main"]
        let weatherJson = json["weather"]
        weather = Weather(minTemp: mainJson["temp_min"].floatValue,
                          maxTemp: mainJson["temp_max"].floatValue,
                          weatherDescription: weatherJson["description"].stringValue)
        super.init()
    }
    
    static func getNearbyCities(lat: Double, log: Double, cnt: Int, callback: (response: [City]) -> Void) {
        var cities = [City]()
        print(String(format: ServerURL.nearbyCities, lat, log, cnt))
        Alamofire.request(.GET, String(format: ServerURL.nearbyCities, lat, log, cnt), parameters: nil, encoding: .JSON, headers: ["Content-type": "application/json", "Accept application" : "json"]).responseJSON { response in
            print(">>>> Cities \(response.result.value)")
            if let responseValue = response.result.value {
                let responseJson = JSON(responseValue)
                let citiesJSON = responseJson["list"].arrayValue
                
                for cityJSON in citiesJSON {
                    let city = City.init(json: cityJSON)
                    cities.append(city)
                }
            }
            callback(response: cities)
        }
    }

    
    
}