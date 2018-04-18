//
//  ChildRecordTableViewController.swift
//  PedCalc
//
//  Created by Wagner Barbosa on 29/03/18.
//  Copyright © 2018 51700182. All rights reserved.
//

import UIKit
import CoreData

class ChildRecordTableViewController: UITableViewController {
    
    let swiftLocale: Locale = Locale.current    
    
    var child: ChildData?
    
    @IBOutlet weak var tfNameChild: UITextField!
    
    @IBOutlet weak var lbBirthdayChild: UILabel!
    
    @IBOutlet weak var dpBirthDayChild: UIDatePicker!
    
    @IBOutlet weak var scChildGender: UISegmentedControl!
    
    @IBOutlet weak var tfMotherName: UITextField!
    
    @IBOutlet weak var tfFatherName: UITextField!
    
    @IBOutlet weak var tfEmail: UITextField!
    
    @IBOutlet weak var tfPhone: UITextField!
    
    @IBOutlet weak var tfAdress: UITextField!
    
    @IBOutlet weak var viewCellBitrhDayChild: UITableViewCell!
    
    @IBOutlet var tableViewChildRecord: UITableView!
    
    @IBOutlet weak var backButton: UIButton!    
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var delButton: UIButton!
    
    private var dateCellExpanded: Bool = false
    
    var childName : String?
    
    var childBithday : Date?
    
    var childGender : String?
    
    var motherName : String?
    
    var fatherName : String?
    
    var email : String?
    
    var phone : String?
    
    var adress : String?
    
    var add : Bool = false
    
    var back : Bool = true
    
    var del : Bool = false
    
    var update : Bool = false
    
    var save : Bool = true
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // For removing the extra empty spaces of TableView below
        tableView.tableFooterView = UIView()
        self.backButton.isEnabled = self.back
        self.addButton.isEnabled = self.add
        self.delButton.isEnabled = self.del
        self.saveButton.isEnabled = self.save
        self.backButton.isHidden = !self.back
        self.addButton.isHidden = !self.add
        self.delButton.isHidden = !self.del
        self.saveButton.isHidden = !self.save
        if let name = child?.childName {
            self.tfNameChild.text = name
        }
        if let birthday = child?.childBirthday {
            self.dpBirthDayChild.date = birthday
            //let swiftLocale: Locale = Locale.current
            self.lbBirthdayChild.text = "\(birthday.description(with: swiftLocale))"
        }
        if let gender = child?.childGender  {
            self.scChildGender.selectedSegmentIndex = Int(gender)
        }
        if let mother = child?.motherName {
            self.tfMotherName.text = mother
        }
        if let father = child?.fatherName {
            self.tfFatherName.text = father
        }
        if let email = child?.email {
            self.tfEmail.text = email
        }
        if let adress = child?.adress {
            self.tfAdress.text = adress
        }
        if let phone = child?.phone {
            self.tfPhone.text = phone
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 9
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 && indexPath.section == 1 {
            if dateCellExpanded {
                dateCellExpanded = false
            } else {
                dateCellExpanded = true
            }
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 && indexPath.section == 1 {
            if dateCellExpanded {
                return 250
            } else {
                return 50
            }
        }
        return 50
    }
    

    //Hide keyboard when user touch return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        tfNameChild.resignFirstResponder()
        return (true)
    }
    func beforeUpdateChild() {
        child?.childName = self.tfNameChild.text
        child?.childBirthday = childBithday
        child?.childGender = Int16(self.scChildGender.selectedSegmentIndex)
        child?.motherName = self.tfMotherName.text
        child?.fatherName = self.tfFatherName.text
        child?.email = self.tfEmail.text
        child?.phone = self.tfPhone.text
        child?.adress = self.tfAdress.text
    }
    
    @IBAction func didCreateChild(_ sender: Any) {
        self.child=ChildManager.shared.createChild(self.tfNameChild.text!, with: context)
        beforeUpdateChild()
        ChildManager.shared.updateChild(self.child!, with: self.tfNameChild.text!, and: context)
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBAction func didUpdateChild(_ sender: UIButton) {

        beforeUpdateChild()
        ChildManager.shared.updateChild(self.child!, with: self.tfNameChild.text!, and: context)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didBackToTheCaller(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
   
    
    @IBAction func pvBirthdayChange(_ sender: Any) {
        childBithday = self.dpBirthDayChild.date
        self.lbBirthdayChild.text = formatDate(self.dpBirthDayChild.date)
        
    }
    
    
    func formatDate(_ date: Date) -> String  {
        //let swiftLocale: Locale = Locale.current
        return "\(self.dpBirthDayChild.date.description(with: swiftLocale))"

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue" {
            if let destination = segue.destination as? DetailEvaluationsTableViewController {
                //let child = self.children[(self.tableView.indexPathForSelectedRow?.row)!]
                destination.child = child
            }
        }
    }
    
    
    
    
    
    
    @IBAction func didDeleteChild(_ sender: UIButton) {
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
