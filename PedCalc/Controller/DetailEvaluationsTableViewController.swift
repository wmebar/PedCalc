//
//  DetailEvaluationsTableViewController.swift
//  PedCalc
//
//  Created by Wagner Barbosa on 17/04/18.
//  Copyright © 2018 51700182. All rights reserved.
//

import UIKit
import CoreData
class DetailEvaluationsTableViewController: UITableViewController {
    
    let swiftLocale: Locale = Locale.current
    var child: ChildData!
    private var evaluations = [MedicalEvaluationData]()
    private var evals = [MedicalEvaluationData]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.evaluations.removeAll()
        evals = MedicalEvaluationManager.shared.loadMedicalEvaluations(with: context)
        for i in 0 ..< evals.count {
            if child.childName == evals[i].childName {
                self.evaluations.append(evals[i])
            }
            
        }
        
        
        
        
        
        //self.evaluations = MedicalEvaluationManager.shared.loadMedicalEvaluationsChild(with: context, at: child)
        //self.evaluations = child.consults?.allObjects as! [MedicalEvaluationData]
        //self.evaluations = MedicalEvaluationManager.shared.loadMedicalEvaluations(with: context)
        //let fetchRequest : NSFetchRequest<MedicalEvaluationData> = MedicalEvaluationData.fetchRequest()
        
        //fetchRequest.predicate = NSPredicate(format: "childName == %@ AND ANY consults.childName == %@", child.childName!, child.childName!)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        // #warning Incomplete implementation, return the number of rows
        return evaluations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! DetailChildEvaluationTableViewCell
        
        let evaluation = evaluations[indexPath.row]
        cell.lbChildName?.text = evaluation.childName
        cell.lbEvaluationDate.text = "\(evaluation.evaluationDate!.description(with: swiftLocale))"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            if (PlaceManager.shared.deletePlace(self.places[indexPath.row], with: context)) {
//                self.places.remove(at: indexPath.row)
//            }
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
