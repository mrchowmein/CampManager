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

struct Items {
    
    
    
    let item:String!
    let qty:String!
    let key:String!
    let itemRef:FIRDatabaseReference?
    
    init ( item:String, qty:String, key:String = "") {
        
        self.item = item
        self.qty = qty
        self.key = key
        self.itemRef = nil
    }
    
    init (snapshot:FIRDataSnapshot) {
        key = snapshot.key
        itemRef = snapshot.ref
        
        if let itemContent = snapshot.value!["item"] as? String {
            item = itemContent
        }else {
            item = ""
        }
        
        if let qtyContent = snapshot.value!["qty"] as? String {
            qty = qtyContent
        }else {
            qty = ""
        }
    

        
    }
    
    func toAnyObject() -> AnyObject {
        return ["item":item, "qty":qty]
    }
    
}