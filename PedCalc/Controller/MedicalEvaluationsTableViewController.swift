//
//  MedicalEvaluationsTableViewController.swift
//  PedCalc
//
//  Created by Wagner Barbosa on 10/04/18.
//  Copyright © 2018 51700182. All rights reserved.
//

import UIKit
import CoreData
class MedicalEvaluationsTableViewController: UITableViewController {

    var evaluations = [MedicalEvaluationData]()
    var section: Int?
    var row: Int?
    let swiftLocale: Locale = Locale.current
    let AddEvaluation = "AddEvaluationSegue"
    let CellSegue = "EditEvaluationSegue"
    let CellDetailIdentifier = "CellMedicalEvaluation"
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func loadEvaluation() {
        self.evaluations = MedicalEvaluationManager.shared.loadMedicalEvaluations(with: context)
        self.tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadEvaluation()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.evaluations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellDetailIdentifier, for: indexPath) as! MedicalEvaluationTableViewCell
        
        let evaluation = self.evaluations[indexPath.row]
        cell.lbChildName?.text = evaluation.childName
        if let date = evaluation.evaluationDate {
            //let swiftLocale: Locale = Locale.current
            //let swiftCountry: String? = swiftLocale.regionCode
            cell.lbMedicalEvaluationDate?.text = "\(date.description(with: swiftLocale))"
        }
        
        
        return cell
    }
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
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
                
                let evaluation = self.evaluations[indexPath.row]
                MedicalEvaluationManager.shared.deleteMedicalEvaluation(evaluation, with: self.context)
                
                self.evaluations.remove(at: indexPath.row)
                
                tableView.deleteRows(at: [indexPath], with: .fade)
                
            }
            alert.addAction(okAction)
            
            self.present(alert, animated: true, completion: nil)
            
        } else if editingStyle == .insert {
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //performSegue(withIdentifier: "EditChildSegue", sender: <#T##Any?#>)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case CellSegue:
            let destination = segue.destination as! MedicalEvaluationRecordTableViewController
            let indexPath = tableView.indexPathForSelectedRow!
            let selectedEvaluation = self.evaluations[(self.tableView.indexPathForSelectedRow?.row)!]
            destination.back = true
            destination.add = false
            destination.del = true
            destination.save = true
            destination.evaluation = selectedEvaluation
            
        case AddEvaluation:
            let destination = segue.destination as! MedicalEvaluationRecordTableViewController
            destination.back = true
            destination.add = true
            destination.del = false
            destination.save = false
            //destination.childName = ""
            
        default:
            print("Unknown segue: \(segue.identifier!)")
        }
    }
    
    
}

