//
//  PersistentStorage.swift
//  TestCoreData
//
//  Created by Mobark Alseif on 11/04/1443 AH.
//

import Foundation
import CoreData

class PersistentStorage {
    
    
    static let shared = PersistentStorage()
    lazy var context = persistentContainer.viewContext
  
    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "HWCoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    // MARK: - Core Data Saving support

    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    func fetchManagedObject<T: NSManagedObject>(managedObject: T.Type) -> [T]? {
        do {
            guard let result = try PersistentStorage.shared.context.fetch(managedObject.fetchRequest()) as? [T] else {return nil}
            return result
        } catch let error {
            debugPrint(error)
        }
        return nil
    }
}
