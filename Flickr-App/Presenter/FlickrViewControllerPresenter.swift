//
//  ViewControllerPresenter.swift
//  Flickr-App
//
//  Created by Abdallah Eid on 6/22/19.
//  Copyright © 2019 Abdallah Eid. All rights reserved.
//

import Foundation

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
        return images.count
    }
    
    func getGroups(text: String, page: Int){
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
        return groups.count
    }
    
    func configureImageCell(cell: ImageTableViewCellDelegate, index: Int){
        let url = ImagesServices.Endpoints.getImage(images[index])
        cell.displayImage(url: url.stringValue)
    }
    
    func configureGroupCell(cell: GroupTableViewCellDelegate, index: Int){
        cell.displayGroupName(name: groups[index].name)
        cell.displayGroupMembersNumber(number: groups[index].members)
    }
}
