//
//  Person+CoreDataClass.swift
//  HW_CoreData
//
//  Created by Munira abdullah on 13/04/1443 AH.
//
//

import Foundation
import CoreData

@objc(CDPerson)
public class CDPerson: NSManagedObject {

    @NSManaged public var name: String?
    @NSManaged public var phoneNumber: String?

    func create(person: Person) {
        
       
        let context = PersistentStorage.shared.context
        let cdPerson = CDPerson(context: context)
        cdPerson.name = person.name
        cdPerson.phoneNumber  = person.number
        
        PersistentStorage.shared.saveContext()

        
    }

}
