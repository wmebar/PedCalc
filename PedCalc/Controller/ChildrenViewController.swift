//
//  ChildrenViewController.swift
//  PedCalc
//
//  Created by COTEMIG on 22/03/18.
//  Copyright © 2018 51700182. All rights reserved.


import UIKit
import CoreData
import Foundation
import CoreLocation

class ChildrenViewController: UIViewController, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    // MARK: - Properties
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: -
    
    private let persistentContainer = NSPersistentContainer(name: "ChildData")
    
    // MARK: -
    
    fileprivate lazy var fetchedResultsController: NSFetchedResultsController<ChildData> = {
        // Create Fetch Request
        let fetchRequest: NSFetchRequest<ChildData> = ChildData.fetchRequest()
        
        // Configure Fetch Request
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "childName", ascending: true)]
        
        // Create Fetched Results Controller
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        
        // Configure Fetched Results Controller
        fetchedResultsController.delegate = self as? NSFetchedResultsControllerDelegate
        
        return fetchedResultsController
    }()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        persistentContainer.loadPersistentStores { (persistentStoreDescription, error) in
            if let error = error {
                print("Unable to Load Persistent Store")
                print("\(error), \(error.localizedDescription)")
                
            } else {
                self.setupView()
                
                do {
                    try self.fetchedResultsController.performFetch()
                } catch {
                    let fetchError = error as NSError
                    print("Unable to Perform Fetch Request")
                    print("\(fetchError), \(fetchError.localizedDescription)")
                }
                
                self.updateView()
            }
        }
    }
    
    // MARK: - View Methods
    
    private func setupView() {
        setupMessageLabel()
        
        updateView()
    }
    
    private func updateView() {
        var hasChildren = false
        
        if let children = fetchedResultsController.fetchedObjects {
            hasChildren = children.count > 0
        }
        
        tableView.isHidden = !hasChildren
        messageLabel.isHidden = hasChildren
        
        //activityIndicatorView.stopAnimating()
    }
    
    // MARK: -
    
    private func setupMessageLabel() {
        messageLabel.text = "You don't have any quotes yet."
    }
    
    //UITableViewDataSource Protocol
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let children = fetchedResultsController.fetchedObjects else { return 0 }
        return children.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChildTableViewCell.reuseIdentifier, for: indexPath) as? ChildTableViewCell else {
            fatalError("Unexpected Index Path")
        }
        
        // Fetch Quote
        let child = fetchedResultsController.object(at: indexPath)
        
        // Configure Cell
        cell.lbChildName.text = child.childName
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat="dd-MM-yyyy"
        let birthday = dateFormatter.string(from: child.childBirthday!)
        cell.lbChildBirthdayChild.text = birthday
        
        
        return cell
    }
    
}

//extension ViewController: NSFetchedResultsControllerDelegate {
//
//}

//extension ViewController: UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        guard let children = fetchedResultsController.fetchedObjects else { return 0 }
//        return children.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChildTableViewCell.reuseIdentifier, for: indexPath) as? ChildTableViewCell else {
//            fatalError("Unexpected Index Path")
//        }
//
//        // Fetch Quote
//        let child = fetchedResultsController.object(at: indexPath)
//
//        // Configure Cell
//        cell.lbChildName.text = child.childName
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat="dd-MM-yyyy"
//        let birthday = dateFormatter.string(from: child.childBirthday!)
//        cell.lbChildBirthday.text = birthday
//
//
//        return cell
//    }
//
//}


//import UIKit
//import CoreData
//class ChildrenViewController: UIViewController, UIPickerViewDataSource, UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate, UIPickerViewDelegate,NSFetchedResultsControllerDelegate {
//
//
//
//    var managedObjectContext: NSManagedObjectContext!
//    //var children = [ChildData]()
//    var childrenNames: [String] = []
//    lazy var pickerView : UIPickerView = {
//        let pickerView = UIPickerView()
//        pickerView.dataSource = self
//        pickerView.delegate = self
//        return pickerView
//    }()
//    var children = [ChildData]() {
//        didSet {
//            updateView()
//        }
//    }
//    private let persistentContainer = NSPersistentContainer(name: "Children")
//    @IBOutlet weak var childName: UITextField!
//
//
//    @IBOutlet weak var pvChildName: UIPickerView!
//    @IBOutlet weak var tVChildren: UITableView!
//    @IBOutlet weak var tfChildBirthyDay: UITextField!
//
//    @IBOutlet weak var messageLabel: UILabel!
//
//    fileprivate func updateView() {
//        let hasChildren = children.count > 0
//
//        tVChildren.isHidden = !hasChildren
//        //messageLabel.isHidden = hasChildren
//    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        //title = "The List"
//        self.childName.delegate = self
//        tVChildren.register(UITableViewCell.self, forCellReuseIdentifier: "ChildCell")
//        persistentContainer.loadPersistentStores { (persistentStoreDescription, error) in
//            if let error = error {
//                print("Unable to Load Persistent Store")
//                print("\(error), \(error.localizedDescription)")
//
//            } else {
//                self.setupView()
//
//                do {
//                    try self.fetchedResultsController.performFetch()
//                } catch {
//                    let fetchError = error as NSError
//                    print("Unable to Perform Fetch Request")
//                    print("\(fetchError), \(fetchError.localizedDescription)")
//                }
//
//                self.updateView()
//                self.createDatePiker()
//            }
//        }
//
//        // Do any additional setup after loading the view.
//    }
//    private func setupView() {
//        setupMessageLabel()
//        updateView()
//    }
//    private func setupMessageLabel() {
//        messageLabel.text = "O cadastro contêm \(self.children.count) crianças"
//    }
//
//    @IBAction func didUpdadteChild(_ sender: UIBarButtonItem) {
//
//    }
//    @IBAction func didBackItem(_ sender: UIBarButtonItem) {
//        dismiss(animated: true, completion: nil)
//    }
//
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 0
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return 0
//    }
//
//
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        guard let children = fetchedResultsController.fetchedObjects else { return 0 }
//        return children.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChildTableViewCell.reuseIdentifier, for: indexPath) as? ChildTableViewCell else {
//            fatalError("Unexpected Index Path")
//        }
//
//        // Fetch Quote
//        let child = fetchedResultsController.object(at: indexPath)
//
//        // Configure Cell
//        cell.lbChildName.text = child.childName
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat="dd-MM-yyyy"
//        let birthday = dateFormatter.string(from: child.childBirthday!)
//        cell.lbChildBirthday.text = birthday
//
//
//        return cell
//    }
//
//    func loadChildren() {
//        self.children = ChildManager.shared.loadChildren(with: context)
//        self.tVChildren.reloadData()
//    }
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        loadChildren()
//    }
//
//    fileprivate lazy var fetchedResultsController: NSFetchedResultsController<ChildData> = {
//        // Create Fetch Request
//        let fetchRequest: NSFetchRequest<ChildData> = ChildData.fetchRequest()
//
//        // Configure Fetch Request
//        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "childName", ascending: true)]
//
//        // Create Fetched Results Controller
//        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
//
//        // Configure Fetched Results Controller
//        fetchedResultsController.delegate = self
//
//        return fetchedResultsController
//    }()
//
//    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        tVChildren.beginUpdates()
//    }
//
//    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        tVChildren.endUpdates()
//        updateView()
//    }
//
//    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
//        switch (type) {
//        case .insert:
//            if let indexPath = newIndexPath {
//                tVChildren.insertRows(at: [indexPath], with: .fade)
//            }
//            break;
//        case .delete:
//            if let indexPath = indexPath {
//                tVChildren.deleteRows(at: [indexPath], with: .fade)
//            }
//            break;
//        default:
//            print("...")
//        }
//
//    }
//
//
//    //Hide keyboard when user touch outside keyboard
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.view.endEditing(true)
//    }
//    //Hide keyboard when user touch return key
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        childName.resignFirstResponder()
//        return (true)
//    }
//
//    //    override func didReceiveMemoryWarning() {
////        super.didReceiveMemoryWarning()
////        // Dispose of any resources that can be recreated.
////    }
//
//
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//
//
//    /*********** Begin DatePicker ***********/
//
//
//
//    let picker = UIDatePicker();
//
//
//
//    func createDatePiker()
//
//    {
//
//        picker.locale = Locale.init(identifier: "pt-BR")
//
//
//
//        let toolbar = UIToolbar()
//
//        toolbar.sizeToFit()
//
//
//
//        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
//
//        toolbar.setItems([done], animated: false)
//
//
//
//        tfChildBirthyDay.inputAccessoryView = toolbar;
//
//        tfChildBirthyDay.inputView = picker
//
//        picker.datePickerMode = .date
//
//    }
//
//
//
//    @objc func donePressed()
//
//    {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat="dd-MM-yyyy"
//        //let dateFromString = dateToString(picker.date)
//        //let dateFromString  = DateFormatter()
//        //dateFromString .dateFormat = "MM/dd/YYYY"
//        let birthday = dateFormatter.string(from: picker.date)
//        tfChildBirthyDay.text = "\(birthday)"
//
//        self.view.endEditing(true)
//
//    }
//
//
//    /*********** End DatePicker ***********/
//
//
//
//}
//
//extension UIViewController {
//
//    var context : NSManagedObjectContext {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        return appDelegate.persistentContainer.viewContext
//    }
//}



