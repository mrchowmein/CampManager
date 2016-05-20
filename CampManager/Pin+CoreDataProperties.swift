//
//  Pin+CoreDataProperties.swift
//  
//
//  Created by Jason Chan MBP on 5/19/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Pin {

    @NSManaged var longitude: NSNumber?
    @NSManaged var latitude: NSNumber?

}
