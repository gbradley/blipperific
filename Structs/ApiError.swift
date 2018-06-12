//
//  ApiError.swift
//  Blipperific
//
//  Created by Graham on 08/06/2018.
//  Copyright © 2018 GMB Technology. All rights reserved.
//

import Foundation

struct ApiError : Codable {
    
    let code: Int
    let message: String
    
    init(code : Int, message : String) {
        self.code = code
        self.message = message
    }
    
    init(json : [String : Any]) {
        self.code = json["code"] as! Int
        self.message = json["message"] as! String
    }
}
