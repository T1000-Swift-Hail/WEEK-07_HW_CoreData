//
//  Person+CoreDataClass.swift
//  CoreData
//
//  Created by HIND12 on 13/04/1443 AH.
//
//

import Foundation
import CoreData

@objc(Person)
public class Person: NSManagedObject {
    
 
    func create(person: CDPerson) {

        let context = PersistentStorage.shared.context
  let cdPerson = CDPerson(context: context)
        cdPerson.name = person.name
 cdPerson.phoneNamber  = person.phoneNamber ?? 0
        
        PersistentStorage.shared.saveContext()

    }
    
}
