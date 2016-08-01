//
//  MembersTableViewController.swift
//  CampManager
//
//  Created by Jason Chan MBP on 7/26/16.
//  Copyright © 2016 Jason Chan. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class MembersTableViewController: UITableViewController {

    @IBAction func backButtonMembers(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func addButton(sender: AnyObject) {
        
        let alert = UIAlertController(title: "New Member", message: "Enter Name and Profession", preferredStyle: .Alert)
        
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .Default) { (action: UIAlertAction!) -> Void in
                                        
                                        let nameField = alert.textFields?[0].text
                                        let profField = alert.textFields?[1].text
                                        
                                        let name = Members(name: nameField!, prof: profField!)
                                        
                                        let nameRef = self.dbRef.child(nameField!.lowercaseString)
                                        
                                        nameRef.setValue(name.toAnyObject())
                                        
                                        
        }
        
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .Default) { (action: UIAlertAction!) -> Void in
        }
        
        alert.addTextFieldWithConfigurationHandler {
            (itemField) -> Void in
            itemField.placeholder = "Enter Name"
        }
        
        alert.addTextFieldWithConfigurationHandler {
            (qtyField) -> Void in
            qtyField.placeholder = "Enter Prof"
            
            alert.addAction(saveAction)
            alert.addAction(cancelAction)
            
            self.presentViewController(alert,
                animated: true,
                completion: nil)
        }
        
//        let nameAlert = UIAlertController(title: "New Member", message: "Enter Name", preferredStyle: .Alert)
//        nameAlert.addTextFieldWithConfigurationHandler { (textField:UITextField) in
//            textField.placeholder = "Name"
//        }
//        nameAlert.addAction(UIAlertAction(title: "Save", style: .Default, handler: { (action:UIAlertAction) in
//            if let nameContent = nameAlert.textFields?.first?.text {
//                
//                let userEmail = FIRAuth.auth()?.currentUser?.email
//                let name = Members(name: nameContent, addedByUser: userEmail!)
//                
//                let nameRef = self.dbRef.child(nameContent.lowercaseString)
//                
//                nameRef.setValue(name.toAnyObject())
//                
//            }
//        }))
//        
//        self.presentViewController(nameAlert, animated: true, completion: nil)
    }
    
    
    
    var dbRef: FIRDatabaseReference!
    
    var names = [Members]()
    
    
    func startObservingDB () {
        dbRef.observeEventType(.Value, withBlock: { (snapshot:FIRDataSnapshot) in
            var newNames = [Members]()
            
            for note in snapshot.children {
                let nameObject = Members(snapshot: note as! FIRDataSnapshot)
                newNames.append(nameObject)
            }
            
            self.names = newNames
            self.tableView.reloadData()
            
        }) { (error:NSError) in
            print(error.description)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dbRef = FIRDatabase.database().reference().child("members-items")
        startObservingDB()
        
        
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
        return names.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let name = names[indexPath.row]
        
        cell.textLabel?.text = name.name
        cell.detailTextLabel?.text = name.prof
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let name = names[indexPath.row]
            
            name.itemRef?.removeValue()
        }
    }
    


    

}
