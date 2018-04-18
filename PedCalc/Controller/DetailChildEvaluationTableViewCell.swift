//
//  DetailChildEvaluationTableViewCell.swift
//  PedCalc
//
//  Created by Wagner Barbosa on 17/04/18.
//  Copyright © 2018 51700182. All rights reserved.
//

import UIKit

class DetailChildEvaluationTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lbChildName: UILabel!
    
    
    @IBOutlet weak var lbEvaluationDate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
