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

    @IBAction func randomiseButtonTapped(sender: AnyObject) {
        if (UserController.sharedController.userArray.count > 1) {
            let random = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(UserController.sharedController.userArray)
            UserController.sharedController.userArray = random as! [User]
            tableView.reloadData()
        } else {
            notEnoughUsersAlertController()
        }
    }
    
    
    //MARK: Create User Alert Controller
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
    
    //MARK: Not Enough Users Alert Controller
    func notEnoughUsersAlertController() {
        let alertController = UIAlertController(title: "Sorry", message: "Not enough users to make a pair", preferredStyle: .Alert)
        
        let okAction = UIAlertAction(title: "ok", style: .Default, handler: nil)
        
        alertController.addAction(okAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    //MARK: Table View Data Source
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
    
    //MARK: Depicting Pairs based on Colors
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if (UserController.sharedController.userArray.count > 1) {
            if (indexPath.row % 2 == 0) {
                cell.backgroundColor = UIColor.blueColor()
            } else {
                cell.backgroundColor = UIColor.redColor()
            }
        }
    }
    
    




}
