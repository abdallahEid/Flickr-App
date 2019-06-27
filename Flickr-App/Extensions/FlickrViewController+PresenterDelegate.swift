//
//  FlickrViewController+PresenterDelegate.swift
//  Flickr-App
//
//  Created by Abdallah Eid on 6/22/19.
//  Copyright © 2019 Abdallah Eid. All rights reserved.
//

import Foundation
import SVProgressHUD
import os

extension FlickrViewController: FlickrViewDelegate{

    func showIndicator() {
        os_log("showIndicator function in FlickrViewController+PresenterDelegate extension is called", log: OSLog.default, type: .info)
        
        SVProgressHUD.show()
    }
    
    func dismissIndicator() {
        os_log("dismissIndicator function in FlickrViewController+PresenterDelegate extension is called", log: OSLog.default, type: .info)
        
        SVProgressHUD.dismiss()
    }
    
    func fetchingDataSuccessfully() {
        os_log("fetchingDataSuccessfully function in FlickrViewController+PresenterDelegate extension is called", log: OSLog.default, type: .info)
        
        DispatchQueue.main.async {
            if let tableView = self.tableView {
                tableView.reloadData()
            }
        }
    }
    
    func showError(error: String) {
        os_log("showError function in FlickrViewController+PresenterDelegate extension is called", log: OSLog.default, type: .info)
        
        os_log("%@", log: OSLog.default, type: .error, error)
        
        print(error)
    }
    
    func hideResultLabel() {
        DispatchQueue.main.async {
            if let label = self.noResultsLabel {
                label.isHidden = true
            }
        }
    }
    
    func showResultLabel() {
        DispatchQueue.main.async {
            if let label = self.noResultsLabel {
                label.isHidden = false
            }
        }
    }
    
}
