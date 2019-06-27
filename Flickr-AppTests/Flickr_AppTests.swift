//
//  Flickr_AppTests.swift
//  Flickr-AppTests
//
//  Created by Abdallah Eid on 6/21/19.
//  Copyright © 2019 Abdallah Eid. All rights reserved.
//

import XCTest
@testable import Flickr_App

class Flickr_AppTests: XCTestCase {

    var presenter: FlickrViewControllerPresenter!
    var viewController: FlickrViewController!
    var images = [Image]()
    var groups = [Group]()
    
    override func setUp() {
        viewController = FlickrViewController()
        presenter = FlickrViewControllerPresenter(delegate: viewController)
    }

    override func tearDown() {
        
    }

    func testExample() {

    }
    
    func testGetImages(){
        
        let text = "farm"
        let page = 1
        let exp1 = expectation(description: "getImages from API")
        let exp2 = expectation(description: "getImages from presenter")
        
        ImagesServices().searchImages(text: text, page: page) { (images, error) in
            if let images = images {
                self.images = images
                exp1.fulfill()
            }
        }
        wait(for: [exp1], timeout: 5.0)
        
        presenter.getImages(text: text, page: page, completion: {
            XCTAssert(self.presenter.getImagesCount() == self.images.count, "Error in calling getImages from presenter")
            exp2.fulfill()
        })
        wait(for: [exp2], timeout: 5.0)
    }
    
    func testGetGroups(){
        
        let text = "farm"
        let page = 1
        let exp1 = expectation(description: "getGroups from API")
        let exp2 = expectation(description: "getGroups from presenter")
        
        GroupServices().searchGroups(text: text, page: page) { (groups, error) in
            if let groups = groups {
                self.groups = groups
                exp1.fulfill()
            }
        }
        wait(for: [exp1], timeout: 5.0)
        
        presenter.getGroups(text: text, page: page, completion: {
            XCTAssert(self.presenter.getGroupsCount() == self.groups.count, "Error in calling getGroups from presenter")
            exp2.fulfill()
        })
        wait(for: [exp2], timeout: 5.0)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
