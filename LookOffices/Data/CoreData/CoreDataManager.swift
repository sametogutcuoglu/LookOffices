//
//  CoreDataManager.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 16.08.2022.
//

import Foundation
import CoreData
import UIKit

protocol CoreDataManagerProtocol {
    func saveCoreDataModels(id: Int, name: String, image: UIImage)
    func deleteCoreDataModels(officeId: Int)
    func getCoreData(complation: @escaping ((Result<[Int], Error>) -> Void))
}

class CoreDataManager {
    
    func getCoreData(complation: @escaping ((Result<[Int], Error>) -> Void)) {
        var coreDataOfficeId : [Int] = []
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CoreDataModel")
        
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let data = try context.fetch(fetchRequest)
            for result in data as! [NSManagedObject] {
                if let id = result.value(forKey: "id") as? Int{
                    coreDataOfficeId.append(id)
                }
            }
            complation(.success(coreDataOfficeId))
        }
        catch {
            complation(.failure(error))
        }
    }
    
    func saveCoreDataModels(id: Int, name: String, image: UIImage) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newLikeOffice = NSEntityDescription.insertNewObject(forEntityName: "CoreDataModel", into: context)
        newLikeOffice.setValue(name, forKey: "officeName")
        newLikeOffice.setValue(id, forKey: "id")
        newLikeOffice.setValue(image.jpegData(compressionQuality:0.5), forKey: "officeImage")
        do {
            try context.save()
        }
        catch {
            print("kaydetme işlemi gerçeleşmedi")
        }
    }
    
    func deleteCoreDataModels(officeId: Int) {
        let appDelaget = UIApplication.shared.delegate as! AppDelegate
        let context = appDelaget.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CoreDataModel")
        
        fetchRequest.predicate = NSPredicate(format: "id = %@", "\(officeId)")
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    if let id = result.value(forKey: "id") as? Int {
                        if  id == officeId {
                            context.delete(result)
                            try context.save()
                        }
                    }
                }
            }
            else {
                print("obje yok")
            }
        }
        catch {
            print("Error")
        }
    }
}
