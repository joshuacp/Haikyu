//
//  MyEventsTableViewController.swift
//  Haikyu Project
//
//  Created by Joshua Patrick on 9/7/18.
//  Copyright © 2018 xactimate28. All rights reserved.
//

import Foundation
import UIKit

class MyEventsTableViewController : UITableViewController {
    
    override func viewDidLoad() {
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Event 1"
        return cell
    }
}
