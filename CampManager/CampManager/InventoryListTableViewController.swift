//
//  NotesTableViewController.swift
//  FirePad2
//
//  Created by Jason Chan MBP on 7/19/16.
//  Copyright © 2016 Jason Chan. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class InventoryListViewController: UITableViewController {
    
    var dbRef: FIRDatabaseReference!
    
    var items = [Items]()
    
    
    @IBAction func backButtonInv(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dbRef = FIRDatabase.database().reference().child("inv-items")
        startObservingDB()
        
        
    }
    
    func startObservingDB () {
        dbRef.observeEventType(.Value, withBlock: { (snapshot:FIRDataSnapshot) in
            var newItems = [Items]()
            
            for item in snapshot.children {
                let itemObject = Items(snapshot: item as! FIRDataSnapshot)
                newItems.append(itemObject)
            }
            
            self.items = newItems
            self.tableView.reloadData()
            
        }) { (error:NSError) in
            print(error.description)
        }
    }
    
    
    
    
    @IBAction func addButton(sender: AnyObject) {
        
        let alert = UIAlertController(title: "New Item", message: "Enter Your Item", preferredStyle: .Alert)
        
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .Default) { (action: UIAlertAction!) -> Void in
                                        
                                        let itemField = alert.textFields?[0].text
                                        let qtyField = alert.textFields?[1].text
                                        
                                        let item = Items(item: itemField!, qty: qtyField!)
                                        
                                        let itemRef = self.dbRef.child(itemField!.lowercaseString)
                                        
                                        itemRef.setValue(item.toAnyObject())
                                        
                                        
        }
        
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .Default) { (action: UIAlertAction!) -> Void in
        }
        
        alert.addTextFieldWithConfigurationHandler {
            (itemField) -> Void in
            itemField.placeholder = "Enter your item"
        }
        
        alert.addTextFieldWithConfigurationHandler {
            (qtyField) -> Void in
            qtyField.placeholder = "Enter the qty"
            
            alert.addAction(saveAction)
            alert.addAction(cancelAction)
            
            self.presentViewController(alert,
                animated: true,
                completion: nil)
        }
        
    }
    
        
        
        
        
        
        override func viewDidAppear(animated: Bool) {
            super.viewDidAppear(animated)
            
            FIRAuth.auth()?.addAuthStateDidChangeListener({ (auth:FIRAuth, user:FIRUser?) in
                if let user = user {
                    print("Welcome \(user.email)")
                    self.startObservingDB()
                }else{
                    print("You need to sign up or login first")
                }
            })
            
        }
        
        // MARK: - Table view data source
        
        override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
        }
        
        override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return items.count
        }
        
        
        override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell", forIndexPath: indexPath)
            
            let item = items[indexPath.row]
            
            cell.textLabel?.text = item.item
            cell.detailTextLabel?.text = item.qty
            
            return cell
        }
        
        
        override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
            if editingStyle == .Delete {
                let item = items[indexPath.row]
                
                item.itemRef?.removeValue()
            }
        }
        
}
