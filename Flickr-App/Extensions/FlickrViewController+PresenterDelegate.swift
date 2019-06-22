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
            self.tableView.reloadData()
        }
    }
    
    func showError(error: String) {
        os_log("showError function in FlickrViewController+PresenterDelegate extension is called", log: OSLog.default, type: .info)
        
        print(error)
    }
    
}
