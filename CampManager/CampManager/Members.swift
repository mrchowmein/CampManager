//
//  Members.swift
//  CampManager
//
//  Created by Jason Chan MBP on 7/26/16.
//  Copyright © 2016 Jason Chan. All rights reserved.
//

import Foundation
import FirebaseDatabase
import Firebase

struct Members {
    
    let key:String!
    let name:String!
    let prof:String!
    let itemRef:FIRDatabaseReference?
    
    init (name:String, prof:String, key:String = "") {
        self.key = key
        self.name = name
        self.prof = prof
        self.itemRef = nil
    }
    
    init (snapshot:FIRDataSnapshot) {
        key = snapshot.key
        itemRef = snapshot.ref
        
        if let nameContent = snapshot.value!["name"] as? String {
            name = nameContent
        }else {
            name = ""
        }
        
        if let nameUser = snapshot.value!["prof"] as? String {
            prof = nameUser
        }else {
            prof = ""
        }
        
    }
    
    func toAnyObject() -> AnyObject {
        return ["name":name, "prof":prof]
    }
    
}