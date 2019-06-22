//
//  FlickrViewController+UISearchBarDelegate.swift
//  Flickr-App
//
//  Created by Abdallah Eid on 6/22/19.
//  Copyright © 2019 Abdallah Eid. All rights reserved.
//

import Foundation
import UIKit

extension FlickrViewController: UISearchBarDelegate{
    
    // MARK: Functions
    
    func configureSearchBar(){
        searchBar.delegate = self
    }
    
    // MARK: Delegate Functions
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text{
            if selectedTab == "images" {
                presenter.getImages(text: text, page: page)
            } else {
                presenter.getGroups(text: text, page: page)
            }
            self.view.endEditing(true)
        }
    }
}
