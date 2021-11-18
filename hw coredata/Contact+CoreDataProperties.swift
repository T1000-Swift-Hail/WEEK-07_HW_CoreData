//
//  Contact+CoreDataProperties.swift
//  hw coredata
//
//  Created by Mastorah on 18/11/2021.
//
//

import Foundation
import CoreData


extension Contact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact")
    }

    @NSManaged public var name: String?
    @NSManaged public var phoneNumber: String?

}

extension Contact : Identifiable {

}
