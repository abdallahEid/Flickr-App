//
//  GroupTableViewCell.swift
//  Flickr-App
//
//  Created by Abdallah Eid on 6/21/19.
//  Copyright © 2019 Abdallah Eid. All rights reserved.
//

import UIKit

class GroupTableViewCell: UITableViewCell, GroupTableViewCellDelegate{

    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var memberNumberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none

    }
    
    func displayGroupName(name: String) {
        groupNameLabel.text = name
    }
    
    func displayGroupMembersNumber(number: String) {
        memberNumberLabel.text = number
    }
}
