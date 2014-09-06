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
    
    // Delegate for submitted name
    @IBAction func submitName(sender: AnyObject) {
        if let name = offenderNameField.text {
            if !name.isEmpty {
                offenderName = offenderNameField.text!
                self.performSegueWithIdentifier("SubmitNameSegue", sender: self)
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Already set offenderName to value in text field
        if (segue.identifier == "SubmitNameSegue") {
            let navigationController = segue.destinationViewController as UINavigationController
            let destViewController = navigationController.topViewController as VictimListViewController
            destViewController.TitleName = self.offenderName
        }
    }
    
}