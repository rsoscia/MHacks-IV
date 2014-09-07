//
//  SubmitNameView.swift
//  Project1
//
//  Created by Kyle Wilson on 9/6/14.
//  Copyright (c) 2014 MHacks. All rights reserved.
//

import Foundation

import UIKit

class SubmitNameViewController : UIViewController {
    
    var offenderName: String?
    
    // Outlet for text field
    @IBOutlet weak var offenderNameField: UITextField!
    
    // Outlet for "Welcome, username" label
    @IBOutlet weak var WelcomeLabel: UILabel!
    
    // Action for touch-up on submitName button
    @IBAction func submitName(sender: AnyObject) {
        if let name = offenderNameField.text {
            if !name.isEmpty {
                // If a name has been typed in the text box, segue to the victim list scene
                offenderName = offenderNameField.text!
                self.performSegueWithIdentifier("SubmitNameSegue", sender: self)
            }
        }
    }
    
    @IBAction func LogOut(sender: AnyObject) {
        PFUser.logOut()
        performSegueWithIdentifier("loginSegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Already set offenderName to value in text field
        if (segue.identifier == "SubmitNameSegue") {
            let navigationController = segue.destinationViewController as UINavigationController
            let destViewController = navigationController.topViewController as VictimListViewController
            destViewController.TitleName = self.offenderName
        }
    }
    
    override func viewDidLoad() {
        // Check for cached currentuser
        var currentUser = PFUser.currentUser()
        if currentUser != nil {
            // Do nothing: avoid login / signup scene
            WelcomeLabel.text! = "Welcome, \(currentUser.username)!"
        }
        else {
            // Segue to login / signup scene
            performSegueWithIdentifier("loginSegue", sender: self)
        }
    }
    
}