//
//  Item.swift
//  CampManager
//
//  Created by Jason Chan MBP on 6/13/16.
//  Copyright © 2016 Jason Chan. All rights reserved.
//

import UIKit

class item: NSObject {
    var uid: String
    var item: String
    var qty: String
    
    
    init(uid: String, item: String, qty: String) {
        self.uid = uid
        self.item = item
        self.qty = qty
        
    }
    
    convenience override init() {
        self.init(uid: "", item: "", qty: "")
    }
}