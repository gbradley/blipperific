//
//  Entry.swift
//  Blipperific
//
//  Created by Graham on 27/04/2018.
//  Copyright © 2018 GMB Technology. All rights reserved.
//

import Foundation

struct Entry : Codable {
    
    var entry_id : Int
    var date_stamp : Int
    var title : String
    var username : String
    var thumbnail_url : String
    var image_url : String
    var image_aspect_ratio : Double?
}
