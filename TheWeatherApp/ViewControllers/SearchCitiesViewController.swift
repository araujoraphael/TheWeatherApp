//
//  SearchCitiesViewController.swift
//  TheWeatherApp
//
//  Created by Raphael Araújo on 8/2/16.
//  Copyright © 2016 Raphael Araújo. All rights reserved.
//

import UIKit
import MapKit
import SVProgressHUD
@objc protocol SearchCitiesDelegate {
    optional func maskViewTapped()
}

class SearchCitiesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var tableView : UITableView!
    var maskView : UIView!
    var delegate : SearchCitiesDelegate?
    var coordinate : CLLocationCoordinate2D!
    var cities = [City]()
    var isLoadingData = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupMaskView()
        self.setupTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: TableView DataSource Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell")!
        let city = cities[indexPath.row]
        cell.textLabel!.text = city.name!
        return cell
    }
    
    // MARK: TableView Delegate Methods
    // MARK: - Setups
    
    func setupMaskView() {
        self.maskView = UIView(frame: self.view.frame)
        self.maskView.backgroundColor = UIColor.blackColor()
        self.maskView.alpha = 0.7
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(maskViewTapped))
        self.maskView.addGestureRecognizer(tapGesture)
        self.view.addSubview(self.maskView)
    }
    
    func setupTableView() {
        let viewFrame = self.view.frame
        let tableViewFrame = CGRectMake(viewFrame.origin.x + 30, viewFrame.origin.y + 68, viewFrame.size.width - 60, viewFrame.size.height - 140)
        self.tableView = UITableView(frame: tableViewFrame)
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.showsVerticalScrollIndicator = true
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.hidden = true
        self.view.addSubview(self.tableView)
    }
    
    // MARK: Call Delegate Methods
    func maskViewTapped(gestureRecognizer : UIGestureRecognizer) {
        if(isLoadingData == false) {
            self.delegate!.maskViewTapped!()
        }
    }
    
    func loadData() {
        if(self.tableView != nil) {
            self.tableView.hidden = true
            self.cities.removeAll()
            self.tableView.reloadData()
        }
        isLoadingData = true
        SVProgressHUD.showWithStatus("Finding nearby cities...")
        City.getNearbyCities(self.coordinate.latitude, log: self.coordinate.longitude, cnt: 15) { (response) in
            if(response.count > 0) {
                self.cities = response
                self.tableView.reloadData()
                self.tableView.hidden = false
            }
            self.isLoadingData = false
            SVProgressHUD.dismiss()
        }
    }
}