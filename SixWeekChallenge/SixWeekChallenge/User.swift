//
//  User.swift
//  SixWeekChallenge
//
//  Created by Pierre on 3/11/16.
//  Copyright © 2016 pierre. All rights reserved.
//

import Foundation

class User: NSObject, NSCoding {
    
    private let kName = "name"
    
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    @objc required init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObjectForKey(kName) as? String else {
            self.name = ""
            return nil
        }
        self.name = name
    }
    
    @objc func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: kName)
    }
    
    
}
