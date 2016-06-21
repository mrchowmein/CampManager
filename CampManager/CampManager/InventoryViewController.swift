//
//  InventoryViewController.swift
//  CampManager
//
//  Created by Jason Chan MBP on 6/13/16.
//  Copyright © 2016 Jason Chan. All rights reserved.
//

import UIKit
import Firebase

class InventoryViewController: UITableViewController {
    
    var invItems = [item]()
    
    var ref: FIRDatabaseReference!
    
    
    @IBAction func addButton(sender: AnyObject) {
        var alert = UIAlertController(title: "New Item",
                                      message: "Add an Item and Qty",
                                      preferredStyle: .Alert)
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .Default) { (action: UIAlertAction!) -> Void in
                                        
                                        let userID = FIRAuth.auth()?.currentUser?.uid
                                        
                                        self.ref.child("users").child(userID!).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
                                            
                                            let itemNameTextField = alert.textFields![0]
                                            let qtyTextField = alert.textFields![1]
                                            
                                            
                                            // Write new post
                                            self.writeNewItem(userID!, item: itemNameTextField.text!, qty: qtyTextField.text!)
                                            
                                        }) { (error) in
                                            print(error.localizedDescription)
                                        }
                                        
                                        
                                        
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
    
    
    @IBAction func backButton(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    override func viewDidAppear(animated: Bool) {
    let ref = FIRDatabase.database().reference()
         ref.observeEventType (FIRDataEventType.Value, withBlock: { (snapshot) in
            
            var newItems = [item]()
            
//            // 3
//            for item in snapshot.children {
//                
//                // 4
//                let item = item(snapshot: item as! FDataSnapshot)
//                newItems.append(groceryItem)
//            }
//            
//            // 5
//            self.items = newItems
//            self.tableView.reloadData()
            
        })
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ref = FIRDatabase.database().reference()
        
        
    }
    
    
    
    //Save Function
    
    func writeNewItem(userID: String, item: String, qty: String) {
        
        let key = ref.child("inventoryItems").childByAutoId().key
        let inventoryItems = ["uid": userID,
                              "item": item,
                              "qty": qty]
        let childUpdates = ["/inventoryItems/\(key)": inventoryItems]
        ref.updateChildValues(childUpdates)
        
    }
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return invItems.count
    }
    
    
     override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell" , forIndexPath: indexPath)
     let invItem = invItems[indexPath.row]
     
     cell.textLabel?.text = invItem.item
     cell.detailTextLabel?.text = invItem.qty
     
     // Determine whether the cell is checked
     //toggleCellCheckbox(cell, isCompleted: groceryItem.completed)
     
     return cell
     }
    
    
    
     // Override to support conditional editing of the table view.
     override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
    
    
    
     // Override to support editing the table view.
     override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // 1
            let invItem = invItems[indexPath.row]
            // 2
            invItem.ref?.removeValue()
     }
     }
    
    
    /*
     // Override to support rearranging the table view.
     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
