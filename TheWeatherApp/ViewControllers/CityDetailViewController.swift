//
//  CityDetailViewController.swift
//  TheWeatherApp
//
//  Created by Raphael Araújo on 8/3/16.
//  Copyright © 2016 Raphael Araújo. All rights reserved.
//

import UIKit

class CityDetailViewController: UIViewController {
    @IBOutlet weak var cityNameLabel : UILabel!
    @IBOutlet weak var weatherDescriptionLabel : UILabel!
    @IBOutlet weak var minTempLabel : UILabel!
    @IBOutlet weak var maxTempLabel : UILabel!
    @IBOutlet weak var tempLabel : UILabel!
    var city : City?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cityNameLabel.text = city!.name
        self.weatherDescriptionLabel.text = city!.weather!.weatherDescription
        self.minTempLabel.text = "\(city!.weather!.minTemp)"
        self.maxTempLabel.text = "\(city!.weather!.maxTemp)"
        self.tempLabel.text = "\(city!.weather!.temp)"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: IBAction Methods
    @IBAction func closeButtonTapped(sender : UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
