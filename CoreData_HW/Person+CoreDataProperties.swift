//
//  Person+CoreDataProperties.swift
//  CoreData
//
//  Created by HIND12 on 13/04/1443 AH.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?
    @NSManaged public var phoneNamber: String?

}

extension Person : Identifiable {

}
