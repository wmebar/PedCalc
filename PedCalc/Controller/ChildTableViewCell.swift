//
//  ChildTableViewCell.swift
//  PedCalc
//
//  Created by Wagner Barbosa on 25/03/18.
//  Copyright © 2018 51700182. All rights reserved.
//

import UIKit

class ChildTableViewCell: UITableViewCell {

    static let reuseIdentifier = "ChildCell"
    
    @IBOutlet weak var lbChildName: UILabel!
    
    @IBOutlet weak var lbChildBirthdayChild: UILabel!
    
    
    @IBOutlet weak var scChildGender: UISegmentedControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
