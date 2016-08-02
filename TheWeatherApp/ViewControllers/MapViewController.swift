//
//  SearchCitiesViewController.swift
//  TheWeatherApp
//
//  Created by Raphael Araújo on 8/1/16.
//  Copyright © 2016 Raphael Araújo. All rights reserved.
//

import UIKit
import MapKit

class Annotation: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let title : String?
    
    init(title: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
        
        super.init()
    }
}

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, SearchCitiesDelegate {
    @IBOutlet weak var searchButton : UIButton!
    @IBOutlet weak var mapView:MKMapView!
    var locationManager = CLLocationManager()
    let radius: CLLocationDistance = 5
    var firstLocation = CLLocation(latitude: 17.2239783, longitude: -89.6508839)
    var isWaitingForUserLocation = true
    var searchViewController : SearchCitiesViewController!
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.requestLocationAuthorization()
        self.addMapTapGestureRecognizer()
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
    
    func addPin(gestureRecognizer: UIGestureRecognizer) {
        if gestureRecognizer.state == .Began {
            let touchedPoint = gestureRecognizer.locationInView(mapView)
            let touchedCoordinate = self.mapView.convertPoint(touchedPoint, toCoordinateFromView: mapView)
            let annotation = Annotation(title: "Nearby cities will be searched from here", coordinate: touchedCoordinate)
            self.mapView.removeAnnotations(self.mapView.annotations)
            self.mapView.addAnnotation(annotation)
            self.searchButton.enabled = true
            self.searchButton.backgroundColor = UIColor.searchButtonEnabledColor()
        }
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
    
    // MARK: Gestures Recognizers
    
    func addMapTapGestureRecognizer() {
        let longTap = UILongPressGestureRecognizer(target: self, action: #selector(addPin))
        longTap.minimumPressDuration = 0.5;
        self.mapView.addGestureRecognizer(longTap)
    }
    
    // MARK: IBAction Methods
    @IBAction func searchButtonTapped(sender : UIButton) {
        self.searchViewController = SearchCitiesViewController()
        self.addChildViewController(searchViewController)
        self.view.addSubview(searchViewController.view)
        searchViewController.didMoveToParentViewController(self)
        searchViewController.delegate = self
    }
    
    // MARK: SearchCities Delegate Methods
    func maskViewTapped() {
        self.searchViewController.removeFromParentViewController()
        self.searchViewController.view.removeFromSuperview()
    }
}