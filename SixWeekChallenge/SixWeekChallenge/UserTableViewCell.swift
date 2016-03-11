//
//  UserTableViewCell.swift
//  SixWeekChallenge
//
//  Created by Pierre on 3/11/16.
//  Copyright © 2016 pierre. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var pairedImage: UIImageView!
    
    
    func updatePairedImage(isPaired: Bool) {
        if isPaired {
            pairedImage.image = UIImage(named: "paired")
        } else {
            pairedImage.image = UIImage(named: "not_paired")
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
