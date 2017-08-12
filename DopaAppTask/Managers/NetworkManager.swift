//
//  NetworkManager.swift
//  DopaAppTask
//
//  Created by Mostafa Elbutch on 8/12/17.
//  Copyright © 2017 Mostafa Elbutch. All rights reserved.
//

import UIKit
import Alamofire

class NetworkManager: NSObject {
    
    let BASE_URL = "https://api.stylight.com/rest/brands"
    let API_KEY = "C6490912AB3211E680F576304DEC7EB7"
    
    func fetchBrands (_ parameters:[String:Any]?,completionHandler: @escaping ([String: Any]?,Error?) -> Void) {
        
        var parameters : [String : Any] = [:]
        parameters["apiKey"] = API_KEY
        
        getRequest(BASE_URL, parameters: parameters, headers: nil, completionHandler: completionHandler)
    }
    
    
    func getRequest(_ path :String , parameters:[String:Any]?, headers:[String:Any]?  ,completionHandler: @escaping ([String: Any]?,Error?) -> Void) {
        
        Alamofire.request(BASE_URL, method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON{ response in
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
                
                if let jsonResponse = JSON as? [String: Any] {
                    completionHandler(jsonResponse,nil)
                }
                else {
                    completionHandler(nil,response.result.error)
                }
            }
            else {
                completionHandler(nil,response.result.error)
            }
        }
    }
}
