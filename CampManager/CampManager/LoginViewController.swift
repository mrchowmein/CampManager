//
//  LoginViewController.swift
//  CampManager
//
//  Created by Jason Chan MBP on 6/12/16.
//  Copyright © 2016 Jason Chan. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func loginButton(sender: AnyObject) {
        
        if emailField.text == "" && passwordField.text == "" {
            
            let alertController = UIAlertController(title: "Not so fast!", message:
                "Please enter email and password", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
            
        }
            
        else {

            FIRAuth.auth()?.signInWithEmail(emailField.text!, password:passwordField.text!) { (user, error) in
                
                if error != nil {
                    
                    print(error!.description)
                }
                
                else {
                    
                    self.performSegueWithIdentifier("menuSegue", sender: nil)
                    
                }
            }
            
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
//    override func viewDidAppear(animated: Bool) {
//        super.viewDidAppear(animated)
//        
//        if FIRAuth.auth()?.currentUser = true {
//            
//
//        }
//            
//            
//        }
    
    
    
    //
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
