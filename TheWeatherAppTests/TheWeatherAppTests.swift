//
//  TheWeatherAppTests.swift
//  TheWeatherAppTests
//
//  Created by Raphael Araújo on 8/3/16.
//  Copyright © 2016 Raphael Araújo. All rights reserved.
//

import XCTest
@testable import TheWeatherApp
@testable import SwiftyJSON
class TheWeatherAppTests: XCTestCase {
    var mapViewController : MapViewController!
    var cityDetailViewController : CityDetailViewController!
    
    let jsonCity = JSON(arrayLiteral: ["name": "Recife",
        "main": [
            "min_temp": "29.23",
            "max_temp": "32.49",
            "temp": "30.52"
        ],
        "weather": ([
            "description": "Most Cloudy"
        ])])
    var city : City?
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        mapViewController = storyboard.instantiateViewControllerWithIdentifier("MapViewController") as! MapViewController
        cityDetailViewController = storyboard.instantiateViewControllerWithIdentifier("CityDetailViewController") as! CityDetailViewController
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCityDetailLabels() {
//        cityDetailViewController.cityNameLabel.text == city!.name
        
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
//
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measureBlock {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
}
