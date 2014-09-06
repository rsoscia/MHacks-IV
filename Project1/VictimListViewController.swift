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
    
    @IBOutlet weak var offenderNameTitleField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Set Title to offenderName
        if let name = TitleName {
            offenderNameTitleField.text = name
        }
    }
}