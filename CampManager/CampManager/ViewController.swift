//
//  ViewController.swift
//  CampManager
//
//  Created by Jason Chan MBP on 5/5/16.
//  Copyright © 2016 Jason Chan. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    
    
    @IBAction func logOutButton(sender: AnyObject) {
        try! FIRAuth.auth()!.signOut()
        self.dismissViewControllerAnimated(true, completion: nil)
    
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

