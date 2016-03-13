//
//  PersonListTableViewController.swift
//  SixWeekChallenge
//
//  Created by Pierre on 3/11/16.
//  Copyright © 2016 pierre. All rights reserved.
//

import UIKit
import GameplayKit

class PersonListTableViewController: UITableViewController {
    
    static let sharedController = PersonListTableViewController()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        tableView.reloadData()
    }

    //MARK: Actions
    @IBAction func addButtonTapped(sender: AnyObject) {
        createAlertController()
    }
    
    @IBAction func pairButtonTapped(sender: AnyObject) {
    }
    
    @IBAction func randomiseButtonTapped(sender: AnyObject) {
        var userArray = UserController.sharedController.userArray
        var randomArray = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(userArray)
        print(randomArray)
    }

    //MARK: New User Alert Controller
    func createAlertController() {
        let alertController = UIAlertController(title: "Add a person..", message: "", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "cancel", style: .Default, handler: nil)
        
        let saveAction = UIAlertAction(title: "save", style: .Default) { (action) -> Void in
            if let  textFields = alertController.textFields,
                    name = textFields[0].text {
                        if name.isEmpty {
                            return
                        } else {
                            let person = User(name: name)
                            UserController.sharedController.addUser(person)
                            self.tableView.reloadData()
                        }
            }
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        
        alertController.addTextFieldWithConfigurationHandler { (nameField) -> Void in
            nameField.placeholder = "name"
        }
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    //MARK: Edit User Alert Controller
    func editAlertController() {
        let alertController = UIAlertController(title: "Edit", message: "", preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "cancel", style: .Default, handler: nil)
        
        let saveAction = UIAlertAction(title: "save", style: .Default) { (action) in
            if let  textField = alertController.textFields,
                    name = textField[0].text {
                if name.isEmpty {
                    return
                } else {
                    let person = User(name: name)
                    let selectedIndex = self.tableView.indexPathForSelectedRow
                    UserController.sharedController.editUser(person, indexPath: selectedIndex!)
                    
                    self.tableView.reloadData()
                }
            }
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        
        alertController.addTextFieldWithConfigurationHandler { (nameField) -> Void in
            nameField.placeholder = "name"
        }
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    // MARK: Table View Data Source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserController.sharedController.userArray.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("personCell", forIndexPath: indexPath)
        
        let person = UserController.sharedController.userArray[indexPath.row]
        
        cell.textLabel?.text = person.name
        
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        editAlertController()
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == .Delete) {
            UserController.sharedController.userArray.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    




}
