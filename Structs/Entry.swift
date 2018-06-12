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
        journal_title = "Tractor Factory Photos"
        description = "Parsing HTML failed!"
        description_html = "Lorem ipsum dolor amet <b>subway</b> tile gochujang <a href='https://www.google.com'>flat white<a> synth. Small batch hot chicken meggings, literally palo santo vexillologist drinking vinegar meditation godard next level. Synth VHS meh, lyft offal blog bicycle rights man braid skateboard freegan truffaut sartorial selfies jianbing viral. PBR&B bicycle rights meh, messenger bag YOLO ethical meditation typewriter godard squid microdosing glossier kinfolk swag single-origin coffee. Tofu squid echo park skateboard pitchfork hoodie mustache marfa artisan banh mi narwhal. Brunch asymmetrical master cleanse, pitchfork kinfolk af mumblecore neutra hella. Man braid etsy lomo quinoa street art scenester neutra kickstarter franzen +1 iceland.<br /><br />Pop-up fanny pack shabby chic, kale chips live-edge glossier cardigan cornhole fixie YOLO waistcoat literally. Narwhal pickled snackwave ethical food truck bicycle rights. Pabst af keffiyeh chartreuse leggings aesthetic health goth subway tile hell of succulents marfa bespoke sustainable. Cardigan ramps brooklyn offal, roof party neutra literally +1 kale chips air plant affogato actually messenger bag austin poke. Gastropub bespoke freegan lomo pitchfork meggings helvetica synth sriracha actually cloud bread occupy mlkshk. Health goth keffiyeh pork belly, normcore chia brooklyn disrupt activated charcoal schlitz green juice tote bag vegan blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah."
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
    
    static func from(data : Data) -> EntryResponse {
        var response : EntryResponse? = nil
        do {
            response = try JSONDecoder().decode(EntryResponse.self, from: data)
        } catch {}
        return response!
    }
    
}

struct EntryRecord : Codable {
    
    var fetchStatus : EntryManager.FetchStatus
    var dataStatus : EntryManager.DataStatus
    var response : EntryResponse?
    
}


struct Fuck : Codable {
 
    var entry : FuckSummary
    
}

struct FuckSummary : Codable {
    
    var entry_id : Int
    
}
