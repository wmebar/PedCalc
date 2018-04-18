//
//  DataManager.swift
//  PedCalc
//
//  Created by Wagner Melo Barbosa on 21/03/18.
//  Copyright © 2018 51700182. All rights reserved.
//

import Foundation
import CoreLocation
import CoreData
class ChildManager {
    static let shared : ChildManager = ChildManager()
    var children : [ChildData]!
    init() {
    }
    
    func loadChildren(with context: NSManagedObjectContext) -> [ChildData] {
        let fetchRequest : NSFetchRequest<ChildData> = ChildData.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "childName", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        var children = [ChildData]()
        
        do {
            try children = context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
        
        return children
    }
    

    
    func createChild(_ name : String, with context: NSManagedObjectContext) -> ChildData? {
        
        let child = ChildData(context: context)
        child.childName = name
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
            return nil
        }
        return child
    }
    func updateChild(_ child : ChildData, with name: String, and context: NSManagedObjectContext) -> Bool {
        
        child.childName = name
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
            return false
        }
        
        return true
    }
    func deleteChild(_ child : ChildData, with context: NSManagedObjectContext) -> Bool {
        
        context.delete(child)
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
            return false
        }
        
        return true
        
    }
    
    
}
