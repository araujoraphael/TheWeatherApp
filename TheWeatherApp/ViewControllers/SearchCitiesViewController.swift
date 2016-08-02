//
//  SearchCitiesViewController.swift
//  TheWeatherApp
//
//  Created by Raphael Araújo on 8/1/16.
//  Copyright © 2016 Raphael Araújo. All rights reserved.
//

import UIKit
import MapKit

class SearchCitiesViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    @IBOutlet weak var mapView:MKMapView!
    var locationManager = CLLocationManager()
    let radius: CLLocationDistance = 5
    var firstLocation = CLLocation(latitude: 17.2239783, longitude: -89.6508839)
    var isWaitingForUserLocation = true
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.requestLocationAuthorization()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - MapView Configuration
    
    func requestLocationAuthorization() {
        locationManager.delegate = self
        mapView.delegate = self
        mapView.showsUserLocation = true

        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            if locationManager.location == firstLocation {
                firstLocation = locationManager.location!
            }
            locationManager.startUpdatingLocation()

        } else {
            locationManager.requestWhenInUseAuthorization()
        }
        
        centerMap(firstLocation)
    }
    
    func centerMap(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  radius, radius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    // MARK: - CLLocationManagerDelegate Methods
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15))
        
        if isWaitingForUserLocation {
            self.mapView.setRegion(region, animated: true)
            isWaitingForUserLocation = false
        }
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
}
