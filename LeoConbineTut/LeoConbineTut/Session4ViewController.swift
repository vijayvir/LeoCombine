//
//  Session4ViewController.swift
//  swiftindia-combine-workshop
//
//  Created by Ritesh Gupta on 07/02/20.
//  Copyright © 2020 Ritesh Gupta. All rights reserved.
//

import UIKit
import Combine

// Objectives
// 1. Convert UITableView's scrollViewDidScroll method into a Publisher
// 2. Update UILabel's textColor to green color if content offset is positive else set to red color
// 3. Also update UILabel's text to content offset's live value

class Session4ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
