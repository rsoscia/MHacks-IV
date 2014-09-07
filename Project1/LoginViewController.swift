//
//  LoginViewController.swift
//  Project1
//
//  Created by Kyle Wilson on 9/7/14.
//  Copyright (c) 2014 MHacks. All rights reserved.
//

import Foundation

import UIKit

class LoginViewController : UIViewController, UIAlertViewDelegate {
    
    // Outlets for the username & pasword Text Fields in the view
    @IBOutlet weak var UsernameField: UITextField!
    @IBOutlet weak var PasswordField: UITextField!
    
    override func viewDidLoad() {
        
    }
    
    // Action triggered when the "Sign In" button on the LoginViewController scene is pressed.
    @IBAction func SignIn(sender: AnyObject) {
        // Ensure both username and password fields are filled in
        let username = UsernameField.text
        let password = PasswordField.text
        if username == nil || username.isEmpty || password == nil || password.isEmpty {
            // Alert user to fill in required account details
            alert("Missing Information", msg: "Missing username and/or password.")
        }
        else {
            var new_user = PFUser()
            new_user.username = username!
            new_user.password = password!
            
            // Attempt login
            loginWithParse(new_user)
        }
    }
    
    // Action triggered when the "Sign Up" button on the LoginViewController scene is pressed.
    @IBAction func SignUp(sender: AnyObject) {
        // Ensure both username and password fields are filled in
        let username = UsernameField.text
        let password = PasswordField.text
        if username == nil || username.isEmpty || password == nil || password.isEmpty {
            // Alert user to fill in required account details
            alert("Missing Information", msg: "Missing username and/or password.")
        }
        else {
            var new_user = PFUser()
            new_user.username = username!
            new_user.password = password!
            
            new_user.signUpInBackgroundWithBlock {
                (succeeded: Bool!, error: NSError!) -> Void in
                if error == nil {
                    // Success! Signed Up
                    // Login with new credentials
                    self.loginWithParse(new_user)
                }
                else {
                    self.alert("Error Signing Up", msg: "Username already taken.")
                }
            }
        }
    }
    
    // Helper function logs into Parse user management system.  Segues to SubmitNameView if login is successful.
    private func loginWithParse(user: PFUser) {
        PFUser.logInWithUsernameInBackground(user.username, password: user.password) {
            (user: PFUser!, error: NSError!) -> Void in
            if user != nil {
                // Successful Login
                // Segue to SubmitNameView scene
                self.performSegueWithIdentifier("SuccessfulLoginSegue", sender: self)
            } else {
                self.alert("Error", msg: "Login attempt failed.")
            }
        }
    }
    
    // Helper function for showing an alert box
    private func alert(title: String, msg: String) {
        var alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
}