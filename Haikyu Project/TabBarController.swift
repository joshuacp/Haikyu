//
//  TabBarController.swift
//  Haikyu Project
//
//  Created by Joshua Patrick on 9/7/18.
//  Copyright © 2018 xactimate28. All rights reserved.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    
    @IBInspectable var defaultIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedIndex = defaultIndex
    }
}
