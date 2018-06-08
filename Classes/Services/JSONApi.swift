//
//  Api.swift
//  Blipperific
//
//  Created by Graham on 08/06/2018.
//  Copyright © 2018 GMB Technology. All rights reserved.
//

import Foundation
import Alamofire

class JSONApi {
    
    class func url() -> String {
        return ""
    }
    
    class func headers() -> HTTPHeaders {
        return [:]
    }
    
    static func get(resource : String, callback: ((Data, ApiError?) -> Void)? = nil) {
        self.request(resource: resource, method: HTTPMethod.get, params : nil, callback: callback)
    }
    
    static func get(resource : String, params : Dictionary<String, Any>, callback: ((Data, ApiError?) -> Void)? = nil) {
        self.request(resource: resource, method: HTTPMethod.get, params : params, callback: callback)
    }
    
    static func post(resource : String, callback: ((Data, ApiError?) -> Void)? = nil) {
        self.request(resource: resource, method: HTTPMethod.post, params : nil, callback: callback)
    }
    
    static func post(resource : String, params : Dictionary<String, Any>, callback: ((Data, ApiError?) -> Void)? = nil) {
        self.request(resource: resource, method: HTTPMethod.post, params : params, callback: callback)
    }
    
    static func put(resource : String, callback: ((Data, ApiError?) -> Void)? = nil) {
        self.request(resource: resource, method: HTTPMethod.put, params : nil, callback: callback)
    }
    
    static func put(resource : String, params : Dictionary<String, Any>, callback: ((Data, ApiError?) -> Void)? = nil) {
        self.request(resource: resource, method: HTTPMethod.put, params : params, callback: callback)
    }
    
    static func delete(resource : String, callback: ((Data, ApiError?) -> Void)? = nil) {
        self.request(resource: resource, method: HTTPMethod.delete, params : nil, callback: callback)
    }
    
    static func delete(resource : String, params : Dictionary<String, Any>, callback: ((Data, ApiError?) -> Void)? = nil) {
        self.request(resource: resource, method: HTTPMethod.delete, params : params, callback: callback)
    }
    
    static func request(resource : String, method : HTTPMethod, params : Dictionary<String, Any>?, callback: ((Data, ApiError?) -> Void)? = nil) {
        
        let encoding : ParameterEncoding = method == HTTPMethod.get || method == HTTPMethod.delete ? URLEncoding.default : JSONEncoding.default
        let headers = self.headers()
        
        print("Sending \(method.rawValue) request to", self.url() + resource, headers)
        
        Alamofire.request(self.url() + resource, method : method, parameters : params, encoding : encoding, headers : headers).validate().responseString { response in
            
            var apiError : ApiError? = nil
            
            switch (response.result) {
            case .success:
                break
            case .failure:
                do {
                    // See if this is an error that's actually returned by the API.
                    apiError = try JSONDecoder().decode(ApiError.self, from: response.data!)
                } catch {
                    apiError = ApiError(code : response.response?.statusCode ?? 0, message : response.result.error?.localizedDescription ?? "An unknown error occurred.")
                }
            }
            
            if (callback != nil) {
                callback!(response.data!, apiError)
            }
        }
        
    }
    
}
