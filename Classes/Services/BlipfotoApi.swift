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
            "Authorization" : "Bearer " + appDelegate.env("BLIPFOTO_API_ACCESS_TOKEN")
        ]
    }
    
    override class func successResponseToPayload(response : DataResponse<Any>) -> [String : Any?] {
        
        var apiError : ApiError? = nil
        var data : Data?
        
        // Convert the JSON response to a dictionary.
        let json : [String : Any] = response.result.value as! Dictionary
        
        // The Blipfoto API returns everything as 200 OK, even if there's an underlying error (wtf). So check to see if there's an error object.
        if let error = json["error"] as? [String : Any] {
            apiError = ApiError(json: error)
        } else {
            
            // If not, we want to extract the data payload and reserialize it. Urgh.
            do {
                data = try JSONSerialization.data(withJSONObject: json["data"]!, options: [])
            } catch {
                apiError = ApiError(code : 0, message : "Malformed data payload")
            }
        }
        
        return ["data" : data, "apiError" : apiError]
    }
    
}
