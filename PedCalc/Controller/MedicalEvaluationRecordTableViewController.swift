//
//  MedicalEvaluationRecordTableViewController.swift
//  PedCalc
//
//  Created by Wagner Barbosa on 10/04/18.
//  Copyright © 2018 51700182. All rights reserved.
//

import UIKit
import CoreData
class MedicalEvaluationRecordTableViewController: UITableViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    
    
    let swiftLocale: Locale = Locale.current
    var children = [ChildData]()
    var child: ChildData!
    var evaluation: MedicalEvaluationData!
    @IBOutlet weak var lbChildName: UILabel!    
    
    @IBOutlet weak var pickerChildName: UIPickerView!
    
    //var pickerData: [String] = [String]()
    
    @IBOutlet weak var lbEvaluationDate: UILabel!
    
    @IBOutlet weak var dpEvaluationDate: UIDatePicker!
    
    @IBOutlet weak var scChildGender: UISegmentedControl!
    
    @IBOutlet weak var tfHeight: UITextField!
    
    @IBOutlet weak var tfWeight: UITextField!
    
    @IBOutlet weak var tfCephalicPerimeter: UITextField!
    
    @IBOutlet weak var tfBMI: UITextField!
    
    @IBOutlet weak var tfWeightDivHeight: UITextField!
    
    @IBOutlet weak var viewCellEvaluationDate: UITableViewCell!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var delButton: UIButton!
    
    private var dateCellExpanded: Bool = false
    
    private var nameCellExpanded: Bool = false
    
    var indexChild : Int?
    
    var childName : String?
    
    var evaluationDate : Date?
    
    var childGender : String?
    
    var height : Double?
    
    var weight : Double?
    
    var cephalicPerimeter : Double?
    
    var bmi : Double?
    
    var weightDivHeight : Double?
    
    var add : Bool = false
    
    var back : Bool = true
    
    var del : Bool = false
    
    var update : Bool = false
    
    var save : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //loadChildren()
        
        children = ChildManager.shared.loadChildren(with: context)
        self.pickerChildName.delegate = self
        self.pickerChildName.dataSource = self
        self.tfWeightDivHeight.isEnabled = false
        self.tfBMI.isEnabled = false
        self.backButton.isEnabled = self.back
        self.addButton.isEnabled = self.add
        self.delButton.isEnabled = self.del
        self.saveButton.isEnabled = self.save
        self.backButton.isHidden = !self.back
        self.addButton.isHidden = !self.add
        self.delButton.isHidden = !self.del
        self.saveButton.isHidden = !self.save

        if let name = evaluation?.childName {
            self.lbChildName.text = name
        }
        if let evaluationDate = evaluation?.evaluationDate {
            self.dpEvaluationDate.date = evaluationDate
            //let swiftLocale: Locale = Locale.current
            self.lbEvaluationDate.text = "\(evaluationDate.description(with: swiftLocale))"
        }
        if self.evaluation != nil {
            if let h: Double = self.evaluation.height {
                self.height = h
                self.tfHeight.text = String(h)
            }
            
            
            if let w: Double = self.evaluation.weight {
                self.weight = w
                self.tfWeight.text = String(w)
            }
            
            if let pc: Double = self.evaluation.perimeterHead {
                self.cephalicPerimeter = pc
                self.tfCephalicPerimeter.text = String(pc)
            }
            
            
            if let imc: Double = self.evaluation.bmi {
                self.bmi = imc
                self.tfBMI.text = String(imc)
            }
            
            if let wDivH: Double = self.evaluation.heightDivWeight {
                self.weightDivHeight = wDivH
                self.tfWeightDivHeight.text  = String(wDivH)
            }
            
        }
        
        
        // For removing the extra empty spaces of TableView below
        //tableView.tableFooterView = UIView()
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
        self.lbChildName.text = child.childName
        self.scChildGender.selectedSegmentIndex = Int(children[row].childGender)
    }

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 9
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            switch indexPath.section {
            case 0:
                if nameCellExpanded {
                    nameCellExpanded = false
                } else {
                    nameCellExpanded = true
                }
                tableView.beginUpdates()
                tableView.endUpdates()
            case 1:
                if dateCellExpanded {
                    dateCellExpanded = false
                } else {
                    dateCellExpanded = true
                }
                tableView.beginUpdates()
                tableView.endUpdates()
            default:
                break
            }
            
        }

    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            switch indexPath.section {
            case 0:
                if nameCellExpanded {
                    return 250
                } else {
                    return 50
                }
            case 1:
                if dateCellExpanded {
                    return 250
                } else {
                    return 50
                }
            default:
                return 50
            }
        }
        return 50
    }
    
    
    //Hide keyboard when user touch return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        lbChildName.resignFirstResponder()
        return (true)
    }
    func beforeUpdateEvaluation() {
        
        if let d = self.evaluationDate {
            evaluation?.evaluationDate = d
        }
        if let h = self.height {
            evaluation?.height = h
        }
        if let w = self.weight {
            evaluation?.weight = w
        }
        if let pc = self.cephalicPerimeter {
            evaluation?.perimeterHead = pc
        }
        if let imc = self.bmi {
            evaluation?.bmi = imc
        }
        if let wDivH = self.weightDivHeight {
            evaluation?.heightDivWeight = wDivH
        }        

        
    }
    func checkInputs() {
        if let h = self.tfHeight.text?.replacingOccurrences(of: ",", with: ".") {
            if let he = Double(h) {
                self.height = he
            }
        }
        if let w = self.tfWeight.text?.replacingOccurrences(of: ",", with: ".") {
            if let we = Double(w) {
                self.weight = we
            }
        }
        if let pc = self.tfCephalicPerimeter.text?.replacingOccurrences(of: ",", with: ".") {
            if let cp = Double(pc) {
                self.cephalicPerimeter = cp
            }
        }
        if let h = self.tfHeight.text?.replacingOccurrences(of: ",", with: "."), let w = self.tfWeight.text?.replacingOccurrences(of: ",", with: ".") {
            if let he = Double(h), let we = Double(w)  {
                if he > 0 {
                    let bmi = we/(he*he)
                    self.bmi = bmi
                    let wDivH = we/he
                    self.weightDivHeight = wDivH
                    self.tfBMI.text = String(wDivH)
                }
            }
            
        }
        
    }
    @IBAction func didEndEditditingHeight(_ sender: UITextField) {
        checkInputs()
    }
    
    
    @IBAction func didEndEditingWeight(_ sender: UITextField) {
        checkInputs()
    }
    
    @IBAction func didEditingChanged(_ sender: Any) {
        checkInputs()
    }
    @IBAction func didEndEditigPC(_ sender: UITextField) {
        checkInputs()
    }
    
    @IBAction func didCreateEvaluation(_ sender: Any) {
        if let ch = self.child {
            self.evaluation = MedicalEvaluationManager.shared.createMedicalEvaluation(ch.childName!, with: self.context)
            self.children = ChildManager.shared.loadChildren(with: self.context)
            
        }
        beforeUpdateEvaluation()
        let ch = self.children[self.pickerChildName.selectedRow(inComponent: 0)]
        if (MedicalEvaluationManager.shared.updateMedicalEvaluation(self.evaluation, with: ch, and: self.context)) {
            self.children = ChildManager.shared.loadChildren(with: self.context)

        } 

        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBAction func didUpdateEvaluation(_ sender: UIButton) {
        beforeUpdateEvaluation()
        let ch = self.children[self.pickerChildName.selectedRow(inComponent: 0)]
        if (MedicalEvaluationManager.shared.updateMedicalEvaluation(self.evaluation, with: ch, and: self.context)) {
            self.children = ChildManager.shared.loadChildren(with: self.context)
            
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didBackToTheCaller(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func pvEvaluationDate(_ sender: Any) {
        evaluationDate = self.dpEvaluationDate.date
        self.lbEvaluationDate.text = formatDate(self.dpEvaluationDate.date)
    }
    
    func formatDate(_ date: Date) -> String  {
        
        return "\(self.dpEvaluationDate.date.description(with: swiftLocale))"
        
    }
    
    
    
    
    
    @IBAction func didDeleteEvaluation(_ sender: UIButton) {
        let swiftLanguage: String? = swiftLocale.languageCode
        var title = "Caution!"
        var message = "Are you sure that you want delete this child?"
        var positiveResponse = "Yes"
        var negativeResponse = "No"
        switch swiftLanguage {
        case "en"?:
            title = "Caution!"
            message = "Are you sure that you want delete this child?"
            positiveResponse = "Yes"
            negativeResponse = "No"
        case "pt"?:
            title = "Atençao!"
            message = "Tem certeza que deseja excluir esta criança?"
            positiveResponse = "Sim"
            negativeResponse = "Não"
        case "es"?:
            title = "¡Precaución!"
            message = "¿Estás seguro de que quieres eliminar a este niño?"
            positiveResponse = "Sí"
            negativeResponse = "No"
        case .none:
            title = "Caution!"
            message = "Are you sure that you want delete this child?"
            positiveResponse = "Yes"
            negativeResponse = "No"
        case .some(_):
            title = "Caution!"
            message = "Are you sure that you want delete this child?"
            positiveResponse = "Yes"
            negativeResponse = "No"
        }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: negativeResponse, style: .cancel)
        alert.addAction(cancelAction)
        let okAction = UIAlertAction(title: positiveResponse, style: .default) { (action) in
            
            
            
            ChildManager.shared.deleteChild(self.child!, with: self.context)
            
            
            
            
            
        }
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
    
}
