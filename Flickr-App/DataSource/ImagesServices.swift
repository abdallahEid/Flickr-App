//
//  ImagesServices.swift
//  Flickr-App
//
//  Created by Abdallah Eid on 6/21/19.
//  Copyright © 2019 Abdallah Eid. All rights reserved.
//

import Foundation

class ImagesServices {
    
    enum Endpoints {
    
        case searchImages(String)
        case getImage(Image)
        
        var stringValue: String {
            switch self {
                
            case .searchImages(let text):
                return "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(APIClient.apiKey)&text=\(text)&format=json&nojsoncallback=1"

            case .getImage(let image):
                return "https://farm\(image.farm).staticflickr.com/\(image.server)/\(image.id)_\(image.secret).jpg"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    func searchImages(text: String, completionHandler: @escaping ([Image]?, Error?)-> ()){
        
        APIClient.sharedInstance().clientURLRequest(url: Endpoints.searchImages(text).url, method: .get) { (data, error) in
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
    
    class func sharedInstance() -> ImagesServices {
        struct singleton {
            static let sharedInstance = ImagesServices()
        }
        return singleton.sharedInstance
    }
    
}
