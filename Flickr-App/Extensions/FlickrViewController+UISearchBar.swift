//
//  FlickrViewController+UISearchBarDelegate.swift
//  Flickr-App
//
//  Created by Abdallah Eid on 6/22/19.
//  Copyright © 2019 Abdallah Eid. All rights reserved.
//

import Foundation
import UIKit
import os

extension FlickrViewController: UISearchBarDelegate{
    
    // MARK: Functions
    
    func configureSearchBar(){
        
        os_log("configureSearchBar function in FlickrViewController+PresenterDelegate extension is called", log: OSLog.default, type: .info)
        
        searchBar.delegate = self
    }
    
    // MARK: Delegate Functions
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            if text != "" {
                if selectedTab == "images" {
                    presenter.getImages(text: text, page: 1)
                } else {
                    presenter.getGroups(text: text, page: 1)
                }
                self.view.endEditing(true)
            }
        }
    }
}
