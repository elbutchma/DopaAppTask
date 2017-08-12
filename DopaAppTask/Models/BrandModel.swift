//
//  BrandModel.swift
//  DopaAppTask
//
//  Created by Mostafa Elbutch on 8/12/17.
//  Copyright © 2017 Mostafa Elbutch. All rights reserved.
//

import UIKit
import ObjectMapper

class BrandModel: Mappable {
    
    var brandId   : Int?
    var brandLogo : String?
    var brandName : String?
    
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        brandId   <- map["id"]
        brandLogo <- map["logo"]
        brandName <- map["name"]
    }
}
