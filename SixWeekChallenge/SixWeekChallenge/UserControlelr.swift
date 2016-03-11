//
//  UserControlelr.swift
//  SixWeekChallenge
//
//  Created by Pierre on 3/11/16.
//  Copyright © 2016 pierre. All rights reserved.
//

import Foundation

class UserController {
    
    private let kUsers = "users"
    
    static let sharedController = UserController()
    
    var userArray: [User]
    init() {
        userArray = []
        loadFromPersistanceStorage()
    }
    
    /*
    //MARK: Pair users
    func pairUsers() {
        let usersArray = userArray
        let firstRandomIndex = Int(arc4random_uniform(UInt32(usersArray.count)))
        let secondRandomIndex = Int(arc4random_uniform(UInt32(usersArray.count)))
        
        if (firstRandomIndex == secondRandomIndex) && (firstRandomIndex != secondRandomIndex) {
            
        }
    }
    */


    
    
    func addUser(user: User) {
        userArray.append(user)
        saveToPersistantStorage()
    }
    
    func removeUser(indexPath: NSIndexPath) {
        userArray.removeAtIndex(indexPath.row)
        saveToPersistantStorage()
    }
    
    func saveToPersistantStorage() {
        NSKeyedArchiver.archiveRootObject(self.userArray, toFile: self.filePath(kUsers))
    }
    
    func loadFromPersistanceStorage() {
        let unarchivedUsers = NSKeyedUnarchiver.unarchiveObjectWithFile(filePath(kUsers))
        
        if let users = unarchivedUsers as? [User] {
            userArray = users
        }
    }
    
    func filePath(key: String) -> String {
        let directorySearchResults = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .AllDomainsMask, true)
        let documentPath: AnyObject = directorySearchResults[0]
        let userPath = documentPath.stringByAppendingString("/\(key).plist")
        return userPath
    }
    
    
}