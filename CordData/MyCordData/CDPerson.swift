//
//  CDPerson.swift
//  CordData
//
//  Created by طلال عبيدالله دعيع القلادي on 18/11/2021.
//

import Foundation
import CoreData

@objc(CDPerson)
public class CDPerson : NSManagedObject  {
    
    @NSManaged public var name: String?
    @NSManaged public var number: Int64
    
    func create(person: Person) {

        let context = PersistentStorage.shared.context
        let cdPerson = CDPerson(context: context)
        cdPerson.name = person.name
        cdPerson.number  = person.number
        
        PersistentStorage.shared.saveContext()

    }
    
}
