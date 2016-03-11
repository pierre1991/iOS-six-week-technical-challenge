//
//  UserControlelr.swift
//  SixWeekChallenge
//
//  Created by Pierre on 3/11/16.
//  Copyright © 2016 pierre. All rights reserved.
//

import Foundation

class UserController {
    
    static let sharedController = UserController()
    
    var userArray: [User] = []
    
    
    
    func addUser(user: User) {
        userArray.append(user)
    }
    
    
}