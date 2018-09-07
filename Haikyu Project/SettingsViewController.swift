//
//  SettingsViewController.swift
//  Haikyu Project
//
//  Created by Joshua Patrick on 8/30/18.
//  Copyright © 2018 xactimate28. All rights reserved.
//

import Foundation
import UIKit
import FBSDKLoginKit

class SettingsViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var TableView: UITableView!
    
    enum Section: Int {
        case info = 0, logout
    }
    enum Row: Int {
        case name = 0, username, email
    }
    
    override func viewDidLoad() {
        TableView.delegate = self
        TableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case Section.info.rawValue:
            return 3
        case Section.logout.rawValue:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case Section.info.rawValue:
            return GetInfoCell(row: indexPath.row)
        case Section.logout.rawValue:
            let cell = UITableViewCell()
            cell.textLabel?.text = "Logout"
            cell.isUserInteractionEnabled = true
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func GetInfoCell(row: Int) -> UITableViewCell {
        let cell = UITableViewCell()
        switch row {
        case Row.name.rawValue:
            cell.textLabel?.text = "Name"
            cell.isUserInteractionEnabled = false
        case Row.username.rawValue:
            cell.textLabel?.text = "Username"
            cell.isUserInteractionEnabled = false
        case Row.email.rawValue:
            cell.textLabel?.text = "Email"
            cell.isUserInteractionEnabled = false
        default:
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.section == Section.logout.rawValue) {
            let loginManager = FBSDKLoginManager()
            loginManager.logOut()
            if(FBSDKAccessToken.current() == nil) {
                let loginController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginViewController")
                self.present(loginController, animated: true, completion: nil)
            }
        }
    }
}
