//
//  SearchCitiesViewController.swift
//  TheWeatherApp
//
//  Created by Raphael Araújo on 8/2/16.
//  Copyright © 2016 Raphael Araújo. All rights reserved.
//

import UIKit
import MapKit
@objc protocol SearchCitiesDelegate {
    optional func maskViewTapped()
}

class SearchCitiesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var tableView : UITableView!
    var maskView : UIView!
    var delegate : SearchCitiesDelegate?
    var coordinate : CLLocationCoordinate2D!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupMaskView()
        self.setupTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: TableView DataSource Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell")!
        cell.textLabel!.text = "Cidade \(indexPath.row+1)"
        return cell
    }
    
    // MARK: TableView Delegate Methods
    // MARK: - Setups
    
    func setupMaskView() {
        self.maskView = UIView(frame: self.view.frame)
        self.maskView.backgroundColor = UIColor.blackColor()
        self.maskView.alpha = 0.5
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(maskViewTapped))
        self.maskView.addGestureRecognizer(tapGesture)
        self.view.addSubview(self.maskView)
    }
    
    func setupTableView() {
        let viewFrame = self.view.frame
        let tableViewFrame = CGRectMake(viewFrame.origin.x + 30, viewFrame.origin.y + 60, viewFrame.size.width - 60, viewFrame.size.height - 120)
        self.tableView = UITableView(frame: tableViewFrame)
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.showsVerticalScrollIndicator = true
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
    }
    
    // MARK: Call Delegate Methods
    func maskViewTapped(gestureRecognizer : UIGestureRecognizer) {
        self.delegate!.maskViewTapped!()
    }
    
    func loadData() {
        
    }

}
