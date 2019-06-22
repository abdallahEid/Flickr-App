//
//  ViewController.swift
//  Flickr-App
//
//  Created by Abdallah Eid on 6/21/19.
//  Copyright © 2019 Abdallah Eid. All rights reserved.
//

import UIKit
import os

class FlickrViewController: UIViewController {

    // MARK: Outlets & Properties

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var presenter: FlickrViewControllerPresenter!
    var selectedTab: String = "images"
    var page: Int = 0
    
    // MARK: View Controller LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        os_log("viewDidLoad function in FlickrViewController is called", log: OSLog.default, type: .info)
        
        // There is an extension for table in Extensions Folder
        configureTableView()
        configureSearchBar()
        determineTableCell(type: "ImageTableViewCell")
        presenter = FlickrViewControllerPresenter(delegate: self)
    }

    // MARK: Actions & Functions 

    @IBAction func segmentedControlChanged(_ sender: Any) {
        
        os_log("segmented control change action in FlickrViewController is called", log: OSLog.default, type: .info)
        
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            selectedTab = "images"
            determineTableCell(type: "ImageTableViewCell")
        case 1:
            selectedTab = "groups"
            determineTableCell(type: "GroupTableViewCell")
        default:
            break
        }
        searchBar.text = ""
        self.view.endEditing(true)
        tableView.reloadData()
    }

}

