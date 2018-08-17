//
//  MyViewController.swift
//  Haikyu Project
//
//  Created by Joshua Patrick on 8/9/18.
//  Copyright © 2018 xactimate28. All rights reserved.
//

import Foundation
import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import FirebaseDatabase

class ActivitiesTableViewController: UITableViewController, FBSDKLoginButtonDelegate {
    
    var _activities: [Activity] = []
    var _selectedActivities: [Activity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let ref = Database.database().reference(withPath: "activities")

        ref.observe(.value) { snapshot in
            var newActivities: [Activity] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let activity = Activity(snapshot: snapshot) {
                    newActivities.append(activity)
                }
            }
            self._activities = newActivities
            self.tableView.reloadData()
        }
        
        let loginButton = FBSDKLoginButton()
        loginButton.center.x = view.center.x
        loginButton.center.y = view.center.y + 40
        loginButton.delegate = self as FBSDKLoginButtonDelegate
        
        view.addSubview(loginButton)
    }
    
    @IBAction func DoneButtonPressed(_ sender: UIBarButtonItem) {
        print(_selectedActivities)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _activities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let activity = _activities[indexPath.row]
        
        cell.textLabel?.text = activity.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedActivity = _activities[indexPath.row]
        if let index = _selectedActivities.index(of: selectedActivity) {
            _selectedActivities.remove(at: index)
        } else {
            _selectedActivities.append(selectedActivity)
        }
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        // ...
        let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if let error = error {
                // ...
                print(error)
                return
            }
            // User is signed in
            // ...
        }
    }
    
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            let loginController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginViewController")
            self.present(loginController, animated: true, completion: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
}
