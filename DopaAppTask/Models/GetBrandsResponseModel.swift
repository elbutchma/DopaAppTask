//
//  GetBrandsResponseModel.swift
//  DopaAppTask
//
//  Created by Mostafa Elbutch on 8/12/17.
//  Copyright © 2017 Mostafa Elbutch. All rights reserved.
//

import UIKit
import ObjectMapper

class GetBrandsResponseModel: Mappable {

    var start : Int?
    var count : Int?
    var totalResults : Int?
    var next  = -1
    var brands : [BrandModel]?
    
    
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        start <-  map["start"]
        count <- map["count"]
        totalResults <- map["totalResults"]
        next <- map["next"]
        brands <- map["brands"]
    }
}
