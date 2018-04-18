//
//  HeightCalcViewController.swift
//  PedCalc
//
//  Created by COTEMIG on 21/03/18.
//  Copyright © 2018 51700182. All rights reserved.
//

import UIKit

class HeightCalcViewController: UIViewController {
    
    
    
    
    
    @IBOutlet weak var tfHeightChild: UITextField!
    @IBOutlet weak var tfChildMonths: UITextField!
    @IBOutlet weak var tfChildYears: UITextField!
    @IBOutlet weak var segmentControlGenderChild: UISegmentedControl!
    @IBOutlet weak var tvChildName: UITextField!
    @IBOutlet weak var pickerViewChild: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func willCheckWillCheckHeightXAge(_ sender: Any) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
