//
//  VictimListViewController.swift
//  Project1
//
//  Created by Kyle Wilson on 9/6/14.
//  Copyright (c) 2014 MHacks. All rights reserved.
//

import Foundation

import UIKit

class VictimListViewController : UIViewController {
    
    var TitleName: String?
    
    var victimList = [String]()
    
    @IBOutlet weak var offenderNameTitleField: UILabel!
    
    @IBOutlet weak var victimTextArea: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Set Title to offenderName
        if let name = TitleName {
            offenderNameTitleField.text = name
        }
        
        // Retreive username for current user
        let username = PFUser.currentUser().username!
        
        // Query parse for provided offenderName
        var offender_query = PFQuery(className: "OffenderObject")
        offender_query.whereKey("name", equalTo: TitleName!.lowercaseString)
        offender_query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                NSLog("Successfully retrieved \(objects.count) offender(s) with matching name \(self.TitleName!).")

                if (objects.count > 0) {
                    // Case 1: name already in parse database
                    
                    for object in objects {
                        // Attempt to downcast object to a PFObject to retrieve members
                        if let offender = object as? PFObject {
                            let found_offender_count = offender.objectForKey("count") as Int
                        
                            // Increase reported count, display reported count, and update parse database
                            let object_id = offender.objectId
                            var query = PFQuery(className: "OffenderObject")
                            query.getObjectInBackgroundWithId(object_id) {
                                (offender: PFObject!, error: NSError!) -> Void in
                                if error != nil {
                                    NSLog("%@", error)
                                } else {
                                    let updated_offender_count = found_offender_count + 1
                                    offender["count"] = updated_offender_count
                                    self.offenderNameTitleField.text = "\(self.TitleName!): \(updated_offender_count) reported incidents"
                                    offender.addUniqueObject(username, forKey: "reporters")
                                    self.victimList = offender["reporters"] as [String]
                                    
                                    // Temporary: display reportee usernames in TextView
                                    var display_str = ""
                                    for victim in self.victimList {
                                        display_str += "\(victim)\n"
                                    }
                                    self.victimTextArea.text! = display_str
                                    
                                    offender.saveInBackground()
                                }
                            }
                        }
                    }
                }
                else {
                    // Case 2: name not in parse database
                    self.offenderNameTitleField.text = "\(self.TitleName!): first reported incident"
                    
                    // Add new offender to parse database with count 1
                    var new_offender = PFObject(className: "OffenderObject")
                    new_offender["name"] = self.TitleName!.lowercaseString
                    new_offender["count"] = 1
                    new_offender["reporters"] = [username]
                    new_offender.saveInBackground()
                }
            } else {
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
    }
}











