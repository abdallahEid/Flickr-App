//
//  APIClient.swift
//  Flickr-App
//
//  Created by Abdallah Eid on 6/21/19.
//  Copyright © 2019 Abdallah Eid. All rights reserved.
//

import Foundation
import os

class APIClient {
    
    static let apiKey = "d4176fa5955dfda9aef2827062021228"

    func clientURLRequest(url: URL, method: HTTPMethod, jsonData: Data? = nil, ParametersForGetRequests : [String:String]? = nil, completionHandler: @escaping ( Data?, Error?) -> ()){
        
        os_log("clientURLRequest function in APIClient is called", log: OSLog.default, type: .info)
        
        // url
        var request = URLRequest(url: url)
        
        // method
        request.httpMethod = method.rawValue
        
        // parameters & body
        if method == .get {
            
            if let parameters = ParametersForGetRequests {

                guard let urlComponents = NSURLComponents(string: url.absoluteString) else {
                    return
                }

                urlComponents.queryItems = []
                for parameter in parameters {
                    urlComponents.queryItems?.append(URLQueryItem(name: parameter.key, value: parameter.value))
                    //print("LALALA: " , parameter,  " "  , " " )
                }
                
                
                if let url = urlComponents.url {
                    request = URLRequest(url: url)
                }
            }
            
        } else {
            request.httpBody = jsonData
        }
        
        // headers
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        headers["Accept"] = "application/json"

        request.allHTTPHeaderFields = headers
        
        // calling the API
        let session = URLSession(configuration: URLSessionConfiguration.default)
        session.dataTask(with: request) { (data, response, error) -> Void in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
//                print("DATA IN APIClient:", String(data: data, encoding: .utf8), httpResponse.statusCode)
                if httpResponse.statusCode == 204 || httpResponse.statusCode == 200 {
                    completionHandler(data ,nil)
                } else {
                    // if error
                    completionHandler(nil ,error)

                }
            }
        }.resume()
        
    }
    
    class func sharedInstance() -> APIClient {
        os_log("sharedInstance function in APIClient is called", log: OSLog.default, type: .info)

        
        struct singleton {
            static let sharedInstance = APIClient()
        }
        return singleton.sharedInstance
    }
}
