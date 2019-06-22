//
//  ViewController+TableView.swift
//  Flickr-App
//
//  Created by Abdallah Eid on 6/21/19.
//  Copyright © 2019 Abdallah Eid. All rights reserved.
//

import Foundation
import UIKit

extension FlickrViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Functions
    
    func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    func determineTableCell(type: String){
        tableView.register(UINib(nibName: type, bundle: nil), forCellReuseIdentifier: type)
    }
    
    // MARK: Delegate Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let presenter = presenter {
            if selectedTab == "images" {
                return presenter.getImagesCount()
            }
            else {
                return presenter.getGroupsCount()
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if selectedTab == "images" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTableViewCell") as! ImageTableViewCell
            presenter.configureImageCell(cell: cell, index: indexPath.row)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "GroupTableViewCell") as! GroupTableViewCell
            presenter.configureGroupCell(cell: cell, index: indexPath.row)
            return cell
        }
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if selectedTab == "images" {
            return 200.0
        } else {
            return 100.0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastImage = presenter.getImagesCount() - 1
        let lastGroup = presenter.getGroupsCount() - 1

        if indexPath.row == lastImage && selectedTab == "images"{
            page += 1
            if let text = searchBar.text{
                presenter.getImages(text: text, page: page)
            }
        }
        if indexPath.row == lastGroup && selectedTab == "groups"{
            page += 1
            if let text = searchBar.text{
                presenter.getGroups(text: text, page: page)
            }
        }
    }
    
}
