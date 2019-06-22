//
//  GroupServices.swift
//  Flickr-App
//
//  Created by Abdallah Eid on 6/21/19.
//  Copyright © 2019 Abdallah Eid. All rights reserved.
//

import Foundation
import os

class GroupServices {
    enum Endpoints {
        
        case searchGroups(String, Int)
        
        var stringValue: String {
            switch self {
                
            case .searchGroups(let text, let page):
                return "https://www.flickr.com/services/rest/?method=flickr.groups.search&api_key=\(APIClient.apiKey)&text=\(text)&per_page=50&page=\(page)&format=json&nojsoncallback=1"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    func searchGroups(text: String, page: Int, completionHandler: @escaping ([Group]?, Error?)-> ()){
        os_log("searchGroups function in GroupServices is called", log: OSLog.default, type: .info)

        APIClient.sharedInstance().clientURLRequest(url: Endpoints.searchGroups(text, page).url, method: .get) { (data, error) in
            guard let data = data else {
                completionHandler(nil,error)
                return
            }
            
            // TODO: Refactor 
            do {
                if let object = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let photos = object["groups"] as? [String: Any]{
                        if let photo = photos["group"] {
                            guard let data = try? JSONSerialization.data(withJSONObject: photo, options: []) else {
                                return
                            }
                            let decoder = JSONDecoder()
                            do{
                                let groups = try decoder.decode([Group].self, from: data)
                                completionHandler(groups,nil)
                            }catch {
                                completionHandler(nil,error)
                                return
                            }
                        }
                    }
                }
            } catch {
                completionHandler(nil,error)
            }
            
        }
        
    }
    
    class func sharedInstance() -> GroupServices {
        os_log("sharedInstance function in GroupServices is called", log: OSLog.default, type: .info)

        struct singleton {
            static let sharedInstance = GroupServices()
        }
        return singleton.sharedInstance
    }

}

