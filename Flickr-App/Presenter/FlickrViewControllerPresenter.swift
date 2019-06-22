//
//  ViewControllerPresenter.swift
//  Flickr-App
//
//  Created by Abdallah Eid on 6/22/19.
//  Copyright © 2019 Abdallah Eid. All rights reserved.
//

import Foundation
import os

protocol FlickrViewDelegate: class{
    func showIndicator()
    func dismissIndicator()
    func fetchingDataSuccessfully()
    func showError(error: String)
}

protocol ImageTableViewCellDelegate {
    func displayImage(url: String)
}

protocol GroupTableViewCellDelegate {
    func displayGroupName(name: String)
    func displayGroupMembersNumber(number: String)
}

class FlickrViewControllerPresenter {
    
    private weak var delegate: FlickrViewDelegate?
    private let imageServices = ImagesServices()
    private let groupServices = GroupServices()
    
    private var images = [Image]()
    private var groups = [Group]()
    
    init(delegate: FlickrViewDelegate) {
        self.delegate = delegate
    }
    
    func getImages(text: String, page: Int){
        os_log("getImages function in FlickrControllerViewPresenter is called", log: OSLog.default, type: .info)
    
        delegate?.showIndicator()
        imageServices.searchImages(text: text, page: page) { (images, error) in
            self.delegate?.dismissIndicator()
            guard let images = images else {
                if let error = error {
                    self.delegate?.showError(error: error.localizedDescription)
                }
                return
            }
            
            self.images += images
            self.delegate?.fetchingDataSuccessfully()
            
        }
    }
    
    func getImagesCount() -> Int{
        os_log("getImagesCount function in FlickrControllerViewPresenter is called", log: OSLog.default, type: .info)
        
        return images.count
    }
    
    func getGroups(text: String, page: Int){
        os_log("getGroups function in FlickrControllerViewPresenter is called", log: OSLog.default, type: .info)
        delegate?.showIndicator()
        groupServices.searchGroups(text: text, page: page) { (groups, error) in
            self.delegate?.dismissIndicator()
            guard let groups = groups else {
                if let error = error {
                    self.delegate?.showError(error: error.localizedDescription)
                }
                return
            }
            
            self.groups += groups
            self.delegate?.fetchingDataSuccessfully()
            
        }
    }
    
    func getGroupsCount() -> Int{
        os_log("getGroupsCount function in FlickrControllerViewPresenter is called", log: OSLog.default, type: .info)
        return groups.count
    }
    
    func configureImageCell(cell: ImageTableViewCellDelegate, index: Int){
        os_log("configureImageCell function in FlickrControllerViewPresenter is called", log: OSLog.default, type: .info)
        let url = ImagesServices.Endpoints.getImage(images[index])
        cell.displayImage(url: url.stringValue)
    }
    
    func configureGroupCell(cell: GroupTableViewCellDelegate, index: Int){
        os_log("configureGroupCell function in FlickrControllerViewPresenter is called", log: OSLog.default, type: .info)
        cell.displayGroupName(name: groups[index].name)
        cell.displayGroupMembersNumber(number: groups[index].members)
    }
}
