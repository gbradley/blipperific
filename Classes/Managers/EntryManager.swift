//
//  EntryManager.swift
//  Blipperific
//
//  Created by Graham on 07/06/2018.
//  Copyright © 2018 GMB Technology. All rights reserved.
//

import Foundation

class EntryManager {
    
    
    enum FetchStatus : Int, Codable {
        case None = 0
        case Pending = 1
        case Complete = 2
        case Failed = 3
    }
    
    enum DataStatus : Int, Codable {
        case None = 0
        case Partial = 1
        case Complete = 2
    }
    
    static let shared = EntryManager()
    
    private var records : [Int : EntryRecord] = [:]
    
    // Create a record given an entry response object, and returns its ID.
    func createRecord(from response : EntryResponse, overwrite : Bool = false) -> Int {
        let id = response.entry.entry_id
        
        if (overwrite || !self.hasCompleteRecord(for: id)) {
            records[id] = EntryRecord(fetchStatus: .Complete, dataStatus: response.details == nil ? .Partial : .Complete, response: response)
        }
        return id
    }
    
    // Return a record for an entry ID.
    func record (for id : Int) -> EntryRecord {
        
        var record = records[id]
        if (record == nil) {
            record = EntryRecord(fetchStatus: FetchStatus.None, dataStatus: DataStatus.None, response: nil)
        }
        
        return record!
    }
    
    // Return a record for an entry ID, and if needed, request updates.
    func updateRecord (for id : Int, overwrite : Bool = false) -> EntryRecord {
        let record = self.record(for: id)
        if (overwrite || record.dataStatus != .Complete && record.fetchStatus != .Pending) {
            self.fetchRecord(for: id)
        }
        
        return record
    }
    
    // Determine if the manager has a complete record for an ID.
    private func hasCompleteRecord(for id : Int) -> Bool {
        return records[id]?.dataStatus == .Complete
    }
    
    private func fetchRecord(for id : Int) {
        
        // Mark the record's fetch status as pending.
        var record = self.record(for: id)
        record.fetchStatus = .Pending
        
        // Fetch the data and send a notification when its done.
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
        
            let details = EntryDetails()
            record.response!.details = details
            _ = self.createRecord(from: record.response!, overwrite: true)
            
            NotificationCenter.default.post(name: .entryManagerDidUpdateRecord, object: nil, userInfo: ["id" : id, "record" : record])
        }
    }
}
