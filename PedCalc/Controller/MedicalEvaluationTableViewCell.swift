//
//  MedicalEvaluationTableViewCell.swift
//  PedCalc
//
//  Created by Wagner Barbosa on 10/04/18.
//  Copyright © 2018 51700182. All rights reserved.
//

import UIKit

class MedicalEvaluationTableViewCell: UITableViewCell {

    @IBOutlet weak var lbChildName: UILabel!    
    
    @IBOutlet weak var lbMedicalEvaluationDate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
