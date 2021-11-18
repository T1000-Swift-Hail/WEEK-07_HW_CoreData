//
//  CDPerson+CoreDataClass.swift
//  HW_CoreData
//
//  Created by Mac on 18/11/2021.
//

import Foundation
import CoreData

@objc(CDPerson)
public class CDPerson: NSManagedObject {

    @NSManaged public var name: String?
    @NSManaged public var phoneNumber: Int32
    
    func create(person: Person) {

        let context = PersistentStorage.shared.context
        let cdPerson = CDPerson(context: context)
        cdPerson.name = person.name
        cdPerson.phoneNumber  = Int32(person.phoneNumber ?? 0)
        
        PersistentStorage.shared.saveContext()

    }
}
