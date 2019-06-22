//
//  ImagesServices.swift
//  Flickr-App
//
//  Created by Abdallah Eid on 6/21/19.
//  Copyright © 2019 Abdallah Eid. All rights reserved.
//

import Foundation
import os

class ImagesServices {
    
    enum Endpoints {
    
        case searchImages(String, Int)
        case getImage(Image)
        
        var stringValue: String {
            switch self {
                
            case .searchImages(let text, let page):
                return "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(APIClient.apiKey)&text=\(text)&per_page=50&page=\(page)&format=json&nojsoncallback=1"

            case .getImage(let image):
                return "https://farm\(image.farm).staticflickr.com/\(image.server)/\(image.id)_\(image.secret).jpg"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    func searchImages(text: String, page: Int, completionHandler: @escaping ([Image]?, Error?)-> ()){
        
        os_log("searchImages function in ImagesServices is called", log: OSLog.default, type: .info)

        APIClient.sharedInstance().clientURLRequest(url: Endpoints.searchImages(text,page).url, method: .get) { (data, error) in
            guard let data = data else {
                completionHandler(nil,error)
                return
            }
            
            // TODO: Refactor
            do {
                if let object = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let photos = object["photos"] as? [String: Any]{
                        if let photo = photos["photo"] {
                            guard let data = try? JSONSerialization.data(withJSONObject: photo, options: []) else {
                                return
                            }
                            let decoder = JSONDecoder()
                            do{
                                let images = try decoder.decode([Image].self, from: data)
                                completionHandler(images,nil)
                            }catch {
                                os_log("%@", log: OSLog.default, type: .error, error.localizedDescription)
                                completionHandler(nil,error)
                                return
                            }
                        }
                    }
                }
            } catch {
                os_log("%@", log: OSLog.default, type: .error, error.localizedDescription)
                completionHandler(nil,error)
            }
        }

    }
    
    class func sharedInstance() -> ImagesServices {
        os_log("sharedInstance function in ImagesServices is called", log: OSLog.default, type: .info)

        struct singleton {
            static let sharedInstance = ImagesServices()
        }
        return singleton.sharedInstance
    }
    
}
