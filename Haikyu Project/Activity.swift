//
//  Activity.swift
//  Haikyu Project
//
//  Created by Joshua Patrick on 8/16/18.
//  Copyright © 2018 xactimate28. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

struct Activity: Equatable {
    
    let ref: DatabaseReference?
    let key: String
    let name: String
    
    init(name: String, key: String = "") {
        self.ref = nil
        self.key = key
        self.name = name
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let name = value["name"] as? String else {
                return nil
        }
        
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.name = name
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name
        ]
    }
    
    static func ==(lhs: Activity, rhs: Activity) -> Bool {
        return lhs.key == rhs.key && lhs.name == rhs.name
    }
}
