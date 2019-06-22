//
//  ViewController.swift
//  Flickr-App
//
//  Created by Abdallah Eid on 6/21/19.
//  Copyright © 2019 Abdallah Eid. All rights reserved.
//

import UIKit

class FlickrViewController: UIViewController {

    // MARK: Outlets & Properties

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var presenter: FlickrViewControllerPresenter!
    var selectedTab: String = "Images"
    
    // MARK: View Controller LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // There is an extension for table in Extensions Folder
        configureTableView()
        configureSearchBar()
        determineTableCell(type: "ImageTableViewCell")
        presenter = FlickrViewControllerPresenter(delegate: self)
    
    }

    // MARK: Actions & Functions 

    @IBAction func segmentedControlChanged(_ sender: Any) {
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
        tableView.reloadData()
    }

}

