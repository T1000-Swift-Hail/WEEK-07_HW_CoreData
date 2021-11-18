//
//  Person+CoreDataProperties.swift
//  CoreData HW
//
//  Created by Seham الشطنان on 13/04/1443 AH.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?
    @NSManaged public var phoneName: String?

}

extension Person : Identifiable {

}
