//
//  ViewController.swift
//  Flickr-App
//
//  Created by Abdallah Eid on 6/21/19.
//  Copyright © 2019 Abdallah Eid. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBAction func segmentedControlChanged(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            determineTableCell(type: "ImageTableViewCell")
        case 1:
            determineTableCell(type: "GroupTableViewCell")
        default:
            break
        }
        tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // There is an extension for table in Extensions Folder
        configureTableView()
        determineTableCell(type: "ImageTableViewCell")
    }

}

