//
//  ViewController.swift
//  Project1
//
//  Created by Kyle Wilson on 9/6/14.
//  Copyright (c) 2014 MHacks. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var offenderName: UITextField!
    
    
    
    // Delegate for submitted name
    @IBAction func submitName(sender: AnyObject) {
        if let name = offenderName.text {
            if !name.isEmpty {
                offenderName.text! = "Received name \(name)."
                self.performSegueWithIdentifier("SubmitNameSegue", sender: self)
            }
        }
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

