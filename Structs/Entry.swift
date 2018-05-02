//
//  Entry.swift
//  Blipperific
//
//  Created by Graham on 27/04/2018.
//  Copyright © 2018 GMB Technology. All rights reserved.
//

import Foundation

struct EntrySummary : Codable {
    
    var entry_id : Int
    var date_stamp : Int
    var title : String
    var username : String
    var thumbnail_url : String
    var image_url : String
    var image_aspect_ratio : Double?
}

struct EntryDetails : Codable {
    var journal_title : String
    var description : String
    var description_html : String
    var tags : [String]
    var views : [String : Int]
    var stars : [String : Int]
    var favourites : [String : Int]
    var comments : [String : Int]
    
    init() {
        journal_title = "Test"
        description = "this is a test"
        description_html = "This is a test"
        tags = ["tagA", "tagB"]
        views = ["total" : 3096]
        stars = ["total" : 6, "starred" : 1]
        favourites = ["total" : 0, "favourited" : 0]
        comments = ["total" : 8]
    }
}

struct EntryResponse : Codable {
    
    var entry : EntrySummary
    var details : EntryDetails?
    
}
