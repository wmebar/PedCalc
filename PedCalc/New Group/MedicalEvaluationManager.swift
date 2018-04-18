//
//  MedicalEvaluationManager.swift
//  PedCalc
//
//  Created by Wagner Barbosa on 22/03/18.
//  Copyright © 2018 51700182. All rights reserved.
//

import Foundation
import CoreLocation
import CoreData
class MedicalEvaluationManager {
    static let shared : MedicalEvaluationManager = MedicalEvaluationManager()
    init() {
    }
    func loadMedicalEvaluations(with context: NSManagedObjectContext) -> [MedicalEvaluationData] {
        let fetchRequest : NSFetchRequest<MedicalEvaluationData> = MedicalEvaluationData.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "evaluationDate", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        var medicalEvaluations = [MedicalEvaluationData]()
        
        do {
            try medicalEvaluations = context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
        
        return medicalEvaluations
    }
    func loadMedicalEvaluationsAscendent(with context: NSManagedObjectContext) -> [MedicalEvaluationData] {
        let fetchRequest : NSFetchRequest<MedicalEvaluationData> = MedicalEvaluationData.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "evaluationDate", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        var medicalEvaluations = [MedicalEvaluationData]()
        
        do {
            try medicalEvaluations = context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
        
        return medicalEvaluations
    }
    func loadMedicalEvaluationsChild(with context: NSManagedObjectContext, at child: ChildData) -> [MedicalEvaluationData] {
        let fetchRequest : NSFetchRequest<MedicalEvaluationData> = MedicalEvaluationData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "childName == %@ AND ANY consults.childName == %@", child.childName!, child.childName!)
        let sortDescriptor = NSSortDescriptor(key: "evaluationDate", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        var medicalEvaluations = [MedicalEvaluationData]()
        
        do {
            try medicalEvaluations = context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
        
        return medicalEvaluations
    }
    func checkIfMedicalEvaluationExists(_ medicalEvaluation: MedicalEvaluationData, at child: ChildData, with context: NSManagedObjectContext) -> Bool {
        
        let fetchRequest : NSFetchRequest<ChildData> = ChildData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "childName == %@ AND ANY consults.childName == %@", child.childName!, medicalEvaluation.childName!)
        
        var count = 0
        do {
            try count = context.count(for: fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
        return (count > 0)
    }
    func updateMedicalEvaluation(_ medicalEvaluation : MedicalEvaluationData, with child: ChildData, and context: NSManagedObjectContext) -> Bool {
        
        if (checkIfMedicalEvaluationExists(medicalEvaluation, at: child, with: context)) {
            return false
        }
        
        medicalEvaluation.child = child
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
            return false
        }
        
        return true
    }
    func createMedicalEvaluation(_ name : String, with context: NSManagedObjectContext) -> MedicalEvaluationData? {
        
        let medicalEvaluation = MedicalEvaluationData(context: context)
        medicalEvaluation.childName = name
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
            return nil
        }
        return medicalEvaluation
    }
    func deleteMedicalEvaluation(_ medicalEvaluation : MedicalEvaluationData, with context: NSManagedObjectContext) -> Bool {
        
        context.delete(medicalEvaluation)
        
        do {
            try context.save()
            _ = self.loadMedicalEvaluations(with: context)
        } catch {
            print(error.localizedDescription)
            return false
        }
        
        return true
        
    }
}
