//
//  CDPerson+CoreDataClass.swift
//  WEEK-07_HW_CoreData
//
//  Created by mac on 12/04/1443 AH.


import Foundation
import CoreData

@objc(CDPerson)
public class CDPerson: NSManagedObject {

    @NSManaged public var name: String?
    @NSManaged public var number: String
    
    func create(person: Person) {

        let context = PersistentStorage.shared.context
        let cdPerson = CDPerson(context: context)
        cdPerson.name = person.name
        cdPerson.number  = person.number
        
        PersistentStorage.shared.saveContext()

    }
}
