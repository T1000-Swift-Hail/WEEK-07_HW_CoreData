//
//  File.swift
//  week_7_coreData
//
//  Created by Ahmed Alenazi on 13/04/1443 AH.
//


import Foundation
import CoreData

@objc(CDPhoneBook)
public class CDPhoneBook: NSManagedObject {
    
    @NSManaged public var name: String?
    @NSManaged public var number: Int64
    
    func create(phoneBook: PhoneBook) {
        
        let context = PersistentStorage.shared.context
        let cDPhoneBook = CDPhoneBook(context: context)
        cDPhoneBook.name = phoneBook.name
        cDPhoneBook.number  = phoneBook.number ?? 0
        
        PersistentStorage.shared.saveContext()
        
    }
}

class PersistentStorage {
    
    
    static let shared = PersistentStorage()
    lazy var context = persistentContainer.viewContext
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "CoreData")
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
