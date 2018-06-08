//
//  BlipfotoApi.swift
//  Blipperific
//
//  Created by Graham on 08/06/2018.
//  Copyright © 2018 GMB Technology. All rights reserved.
//

import Foundation
import Alamofire

class BlipfotoApi : JSONApi {
    
    override class func url() -> String {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.env("BLIPFOTO_API_URL")
    }
    
    override class func headers() -> HTTPHeaders {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return [
            "Accept": "application/json",
            "Bearer" : appDelegate.env("BLIPFOTO_API_ACCESS_TOKEN")
        ]
    }
    
}
