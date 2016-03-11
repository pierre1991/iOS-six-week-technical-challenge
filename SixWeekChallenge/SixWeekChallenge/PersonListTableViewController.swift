//
//  PersonListTableViewController.swift
//  SixWeekChallenge
//
//  Created by Pierre on 3/11/16.
//  Copyright © 2016 pierre. All rights reserved.
//

import UIKit

class PersonListTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    //MARK: Actions
    @IBAction func addButtonTapped(sender: AnyObject) {
        createAlertController()
    }
    
    @IBAction func pairButtonTapped(sender: AnyObject) {
        
        
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


    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            //TODO: Delete Row
        } else if editingStyle == .Insert {

        }
    }



}
