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

class SettingsTableViewController : UITableViewController {
    
    enum Section: Int {
        case info = 0, logout
    }
    enum Row: Int {
        case name = 0, email
    }
    
    var _userData: NSDictionary = [:]
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        getFBUserData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case Section.info.rawValue:
            return 2
        case Section.logout.rawValue:
            return 1
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case Section.info.rawValue:
            return GetInfoCell(row: indexPath.row)
        case Section.logout.rawValue:
            let cell = UITableViewCell()
            cell.textLabel?.text = "Logout"
            cell.textLabel?.textColor = .red
            cell.textLabel?.textAlignment = .center
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
            cell.textLabel?.text = _userData["name"] as? String
            cell.isUserInteractionEnabled = false
        case Row.email.rawValue:
            cell.textLabel?.text = _userData["email"] as? String
            cell.isUserInteractionEnabled = false
        default:
            return UITableViewCell()
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.section == Section.logout.rawValue) {
            let loginManager = FBSDKLoginManager()
            loginManager.logOut()
            if(FBSDKAccessToken.current() == nil) {
                let loginController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginViewController")
                self.present(loginController, animated: true, completion: nil)
            }
        }
    }
    
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    self._userData = result as! NSDictionary
                    self.tableView.reloadData()
                }
            })
        }
    }
}
