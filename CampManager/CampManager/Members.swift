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
    let addedByUser:String!
    let itemRef:FIRDatabaseReference?
    
    init (name:String, addedByUser:String, key:String = "") {
        self.key = key
        self.name = name
        self.addedByUser = addedByUser
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
        
        if let nameUser = snapshot.value!["addedByUser"] as? String {
            addedByUser = nameUser
        }else {
            addedByUser = ""
        }
        
    }
    
    func toAnyObject() -> AnyObject {
        return ["name":name, "addedByUser":addedByUser]
    }
    
}