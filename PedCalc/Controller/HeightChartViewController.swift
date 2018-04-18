//
//  HeightChartViewController.swift
//  PedCalc
//
//  Created by Wagner Barbosa on 15/04/18.
//  Copyright © 2018 51700182. All rights reserved.
//

import UIKit
import Charts
import CoreData
class HeightChartViewController: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource {
    
    var chartParameter: Int = 1
    var children = [ChildData]()
    var child: ChildData!
    private var evaluations = [MedicalEvaluationData]()
    private var nameViewExpanded: Bool = false
    
    private var evals = [MedicalEvaluationData]()
    @IBOutlet weak var lbChild: UILabel!
    
    @IBOutlet weak var pvChild: UIPickerView!
    
    @IBOutlet weak var viewData: UIView!
    
    
    @IBOutlet weak var lineChartView: LineChartView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pvChild.isHidden = true
        self.children = ChildManager.shared.loadChildren(with: context)
        self.pvChild.delegate = self
        self.pvChild.dataSource = self
        updateChartWithData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.children.count
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let child = self.children[row]
        return child.childName
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.child = self.children[row]
        self.lbChild.text = child.childName
        self.evaluations.removeAll()
        evals = MedicalEvaluationManager.shared.loadMedicalEvaluationsAscendent(with: context)
        for i in 0 ..< evals.count {
            if child.childName == evals[i].childName {
                self.evaluations.append(evals[i])
            }
            
        }
        
        //self.evaluations = child.consults?.allObjects as! [MedicalEvaluationData]
        updateChartWithData()
        
    }
    func updateChartWithData() {
        var dataEntries: [ChartDataEntry] = []
        var dataPoints = [String]()
        if evaluations != nil {
            for i in 0..<evaluations.count {
                //let age = Double((evaluations[i].evaluationDate?.timeIntervalSince(child.childBirthday!))!)/(365*60*24)
                
                let evaluationDate = evaluations[i].evaluationDate
                let birthday: Date = child.childBirthday!
                let calendar = Calendar.current
                
                let ageComponents = calendar.dateComponents([.year, .month], from: birthday, to: evaluationDate!)
                let age:Double = Double(ageComponents.month!)
                
                switch self.chartParameter {
                case 0:
                    let dataEntry = ChartDataEntry(x: age, y:evaluations[i].height )
                    dataEntries.append(dataEntry)
                case 1:
                    let dataEntry = ChartDataEntry(x: age, y:evaluations[i].weight )
                    dataEntries.append(dataEntry)
                case 2:
                    let dataEntry = ChartDataEntry(x: age, y:evaluations[i].bmi)
                    dataEntries.append(dataEntry)
                case 3:
                    let dataEntry = ChartDataEntry(x: age, y:evaluations[i].perimeterHead)
                    dataEntries.append(dataEntry)
                default:
                    break
                }
                let dataEntry = ChartDataEntry(x: age, y:evaluations[i].weight )
                dataEntries.append(dataEntry)
            }
            let lineChartDataSet = LineChartDataSet(values: dataEntries, label: "Consultas")
            let lineChartDataSets = [lineChartDataSet]
            let lineChartData = LineChartData(dataSets: lineChartDataSets )
            lineChartView.data = lineChartData
            
        }      
        
        

    }
    @IBAction func didChooseChild(_ sender: UIButton) {
        if nameViewExpanded {
            nameViewExpanded = false
            self.pvChild.isHidden = true
        } else {            
            nameViewExpanded = true
            self.pvChild.isHidden = false
        }
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
